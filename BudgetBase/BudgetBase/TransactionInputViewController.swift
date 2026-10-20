//
//  TransactionInputViewController.swift
//  BudgetBase
//
//  Created by Chantal Le on 10/19/26.
//

import UIKit

struct Transaction {
    var isIncome: Bool
    var amount: Double
    var date: Date
    var category: String
    var description: String
    var notes: String?
}

class TransactionInputViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var categoryButton: UIButton!
    
    // Actions
    @IBAction func typeChanged(_ sender: UISegmentedControl) {
        updateForTransactionType()
    }
    
    @IBAction func addTransactionTapped(_ sender: UIButton) {
        // 1. Amount: must be a number greater than 0
        guard let amount = Double(amountTextField.text ?? ""), amount > 0 else {
            showAlert(title: "Missing amount", message: "Enter an amount greater than 0.")
            return
        }

        // 2. Category: must be chosen
        guard let category = selectedCategory else {
            showAlert(title: "Missing category", message: "Please choose a category.")
            return
        }

        // 3. Description: can't be empty or only spaces
        let descriptionText = descriptionTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !descriptionText.isEmpty else {
            showAlert(title: "Missing description", message: "Please enter a description.")
            return
        }

        // Notes stay optional: an empty box becomes nil
        let notesText = textView.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let transaction = Transaction(
            isIncome: isIncome,
            amount: amount,
            date: datePicker.date,
            category: category,
            description: descriptionText,
            notes: notesText.isEmpty ? nil : notesText
        )

        print("Saved: \(transaction)")
        showAlert(title: "Transaction added", message: nil)
        clearForm()
    }
    
    // Category Options
    let incomeCategories = ["Salary", "Other"]
    let expenseCategories = ["Bills", "Healthcare", "Education", "Insurance",
                             "Entertainment/Leisure", "Transport", "Food",
                             "Savings Account", "Investment", "Other"]
    
    var selectedCategory: String? // nil = nothing chosen yet
    
    // 0 = Income, 1 = Expense
    var isIncome: Bool {
        typeSegmentedControl.selectedSegmentIndex == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNotesView()
        updateForTransactionType()
        setUpKeyboardHandling()

    }
    
    // Runs every time the screen finishes positioning its views
    override func viewDidLayoutSubviews() {
        // The Content Layout Guide constraints weren't updating the scroll view's
        // content size on smaller phones, so set it from the stack's real height.
        super.viewDidLayoutSubviews()

        // Make sure the stack has its final size before measuring it
        scrollView.layoutIfNeeded()

        // The content needs to reach the bottom of the stack, plus 20 points of padding
        let neededHeight = outerStackView.frame.maxY + 20

        // Only step in if the scroll view's content size is too small
        if scrollView.contentSize.height < neededHeight {
            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: neededHeight)
        }
    }
    
    // Helper Functions
    
    // Recolors the segmented control and changes category options for Income and Expense
    func updateForTransactionType() {
        let categories = isIncome ? incomeCategories : expenseCategories
        let color: UIColor = isIncome ? .systemGreen : .systemRed

        typeSegmentedControl.selectedSegmentTintColor = color
        typeSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)

        // Switching type clears the old choice ("Rent" isn't an income category)
        selectedCategory = nil
        categoryButton.configuration?.title = "Select a category"

        // Turn each category name into a menu item
        let actions = categories.map { name in
            UIAction(title: name) { [weak self] _ in
                self?.selectedCategory = name
                self?.categoryButton.configuration?.title = name
            }
        }
            categoryButton.menu = UIMenu(children: actions)
            categoryButton.showsMenuAsPrimaryAction = true   // one tap opens the menu
    }

    func clearForm() {
        amountTextField.text = ""
        descriptionTextField.text = ""
        textView.text = ""
        datePicker.date = Date()      // Date() = right now
        updateForTransactionType()    // resets the category
        view.endEditing(true)         // hides the keyboard
    }

    // A pop-up message with an OK button
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func styleNotesView() {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
    }

    func setUpKeyboardHandling() {
        scrollView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor).isActive = true
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive   // dragging the form down hides the keyboard

        // Tapping outside a field also hides the keyboard
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false   // taps still reach buttons
        view.addGestureRecognizer(tap)
    }
    

}
