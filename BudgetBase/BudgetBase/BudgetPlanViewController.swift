/* BudgetPlanViewController.swift
 Programmer: Andrew Lee
 
 Description:
    The code for the Budget Plan screen in BudgetPlan.storyboard
 
 */
import UIKit

class BudgetPlanViewController: UIViewController {

    @IBOutlet weak var planSetupView: UIView!
    @IBOutlet weak var fiftyThirtyTwentyView: UIView!
    @IBOutlet weak var zeroBasedView: UIView!
    @IBOutlet weak var payYourselfFirstView: UIView!
    @IBOutlet weak var planButton: UIButton!
    @IBOutlet weak var zeroBasedSection: UIView!
    @IBOutlet weak var payYourselfFirstSection: UIView!
    @IBOutlet weak var savingsTypeLabel: UILabel!
    @IBOutlet weak var savingsGoalLabel: UILabel!

    let savedPlanKey = "savedBudgetPlan"
    let plans = ["50/30/20", "Zero-Based", "Pay Yourself First"]
    var selectedPlan = "50/30/20"

    @IBAction func fiftyThirtyTwentyTapped(_ sender: UIButton) {
        choosePlan("50/30/20")
    }

    @IBAction func zeroBasedTapped(_ sender: UIButton) {
        choosePlan("Zero-Based")
    }

    @IBAction func payYourselfFirstTapped(_ sender: UIButton) {
        choosePlan("Pay Yourself First")
    }

    @IBAction func changePlanTapped(_ sender: UIButton) {
        showScreen(for: nil)
    }

    @IBAction func savingsTypeChanged(_ sender: UISwitch) {
        savingsTypeLabel.text = sender.isOn ? "Block Savings" : "Percentage Savings"
        savingsGoalLabel.text = sender.isOn ? "How much do you aim to put into savings this month? ($)" : "How much do you aim to put into savings this month? (%)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let savedPlan = UserDefaults.standard.string(forKey: savedPlanKey)
        if let savedPlan, plans.contains(savedPlan) {
            selectedPlan = savedPlan
        }
        setUpPlanMenu()
        showScreen(for: savedPlan)
    }

    func setUpPlanMenu() {
        planButton.menu = UIMenu(children: plans.map { plan in
            UIAction(title: plan, state: plan == selectedPlan ? .on : .off) { [weak self] _ in
                self?.selectedPlan = plan
                self?.showPlanInputs()
            }
        })
        showPlanInputs()
    }

    func choosePlan(_ plan: String) {
        selectedPlan = plan
        UserDefaults.standard.set(plan, forKey: savedPlanKey)
        setUpPlanMenu()
        showScreen(for: plan)
    }

    func showPlanInputs() {
        zeroBasedSection.isHidden = selectedPlan != "Zero-Based"
        payYourselfFirstSection.isHidden = selectedPlan != "Pay Yourself First"
    }

    func showScreen(for plan: String?) {
        fiftyThirtyTwentyView.isHidden = plan != "50/30/20"
        zeroBasedView.isHidden = plan != "Zero-Based"
        payYourselfFirstView.isHidden = plan != "Pay Yourself First"
        planSetupView.isHidden = !fiftyThirtyTwentyView.isHidden || !zeroBasedView.isHidden || !payYourselfFirstView.isHidden
    }
}
