/* BudgetPlanViewController.swift
 Programmer: Andrew Lee
 
 Description:
    The code for the Budget Plan screen in Main.storyboard
 
 */
import UIKit

class BudgetPlanViewController: UIViewController {

    @IBOutlet weak var planSetupView: UIView!
    @IBOutlet weak var fiftyThirtyTwentyView: UIView!
    @IBOutlet weak var zeroBasedView: UIView!
    @IBOutlet weak var planButton: UIButton!

    let savedPlanKey = "savedBudgetPlan"

    @IBAction func savePlanTapped(_ sender: UIButton) {
        guard let plan = planButton.menu?.selectedElements.first?.title else { return }
        UserDefaults.standard.set(plan, forKey: savedPlanKey)
        showScreen(for: plan)
    }

    @IBAction func fiftyThirtyTwentyTapped(_ sender: UIButton) {
        showScreen(for: "50/30/20")
    }

    @IBAction func zeroBasedTapped(_ sender: UIButton) {
        showScreen(for: "Zero-Based")
    }

    @IBAction func changePlanTapped(_ sender: UIButton) {
        showScreen(for: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showScreen(for: UserDefaults.standard.string(forKey: savedPlanKey))
    }

    func showScreen(for plan: String?) {
        fiftyThirtyTwentyView.isHidden = plan != "50/30/20"
        zeroBasedView.isHidden = plan != "Zero-Based"
        planSetupView.isHidden = !fiftyThirtyTwentyView.isHidden || !zeroBasedView.isHidden
    }
}
