//
//  TransactionDetailViewController.swift
//  BudgetBase
//
//  Created by Chantal Le on 10/22/26.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    @IBOutlet weak var categoryValueLabel: UILabel!
    @IBOutlet weak var notesSection: UIStackView!
    @IBOutlet weak var notesValueLabel: UILabel!
    
    // Set by the History screen right before this screen appears
    var transaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"   // Text in nav bar
        navigationItem.largeTitleDisplayMode = .never   // keep nav bar title small
        showTransaction()
    }
    
    // Copies each piece of the transaction into its label
    func showTransaction() {
        // If no transaction was handed over, there's nothing to show.
        guard let transaction else { return }

        descriptionLabel.text = transaction.description

        // Same green/red as the Add screen, for consistency
        let color: UIColor = transaction.isIncome ? .systemGreen : .systemRed

        // .formatted(.currency(code: "USD")) turns 45.5 into "$45.50"
        let sign = transaction.isIncome ? "+" : "-"
        amountLabel.text = sign + transaction.amount.formatted(.currency(code: "USD"))
        amountLabel.textColor = color

        typeValueLabel.text = transaction.isIncome ? "Income" : "Expense"
        typeValueLabel.textColor = color

        // .long gives "October 19, 2026"; .omitted leaves out the time
        dateValueLabel.text = transaction.date.formatted(date: .long, time: .omitted)

        categoryValueLabel.text = transaction.category

        // Notes are optional. Show the section only if there's real text.
        // (Whitespace-only notes count as empty, same rule as your Add screen.)
        if let notes = transaction.notes,
            !notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                notesValueLabel.text = notes
                notesSection.isHidden = false
        } else {
            notesSection.isHidden = true   // the stack view closes the gap
        }
    }
    

}
