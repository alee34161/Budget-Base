// Created by Andrew Lee for Transaction History table cells. Feel free to move the code/adjust as needed, only an initial implementation.

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.description
        dateLabel.text = transaction.date.formatted(date: .abbreviated, time: .omitted)

        let sign = transaction.isIncome ? "+" : "-"
        amountLabel.text = sign + transaction.amount.formatted(.currency(code: "USD"))
        amountLabel.textColor = transaction.isIncome
            ? UIColor(red: 0.13, green: 0.62, blue: 0.29, alpha: 1)
            : UIColor(red: 0.86, green: 0.2, blue: 0.25, alpha: 1)
    }
}
