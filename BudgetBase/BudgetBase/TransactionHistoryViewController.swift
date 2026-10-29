/* TransactionHistoryViewController.swift
 Programmer: Andrew Lee
 
 Description:
    The code for the Transaction History screen in TransactionHistory.storyboard
 
 */
import UIKit

class TransactionHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var transactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        transactions = [
            Transaction(isIncome: false, amount: 100.00, date: makeDate(2026, 9, 6), category: "Savings Account", description: "Savings Account", notes: nil),
            Transaction(isIncome: false, amount: 500.00, date: makeDate(2026, 9, 6), category: "Bills", description: "Rent", notes: nil),
            Transaction(isIncome: false, amount: 434.21, date: makeDate(2025, 12, 30), category: "Entertainment/Leisure", description: "Dining Out", notes: "Diningout related transaction"),
            Transaction(isIncome: false, amount: 131.56, date: makeDate(2025, 12, 28), category: "Bills", description: "Utilities", notes: "Utilities related transaction"),
            Transaction(isIncome: false, amount: 207.32, date: makeDate(2025, 12, 24), category: "Food", description: "Groceries", notes: "Groceries related transaction"),
            Transaction(isIncome: true, amount: 3020.67, date: makeDate(2025, 9, 30), category: "Salary", description: "Monthly Paycheck", notes: "Paycheck came in from work. Salary for the month.")
        ]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let header = tableView.tableHeaderView else { return }
        header.frame.size.width = tableView.bounds.width
        header.layoutIfNeeded()
        let targetSize = CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let height = header.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        if header.frame.height != height {
            header.frame.size.height = height
            tableView.tableHeaderView = header
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        cell.configure(with: transactions[indexPath.row])
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? TransactionDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            detail.transaction = transactions[indexPath.row]
        }
    }

    func makeDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? .now
    }
}
