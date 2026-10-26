import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var typeTagView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryTagView: UIView!
    @IBOutlet weak var categoryTagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    func configure(with transaction: Transaction) {
        if transaction.isIncome {
            typeLabel.text = "income"
            typeLabel.textColor = UIColor(red: 0.1, green: 0.45, blue: 0.2, alpha: 1)
            typeTagView.backgroundColor = UIColor(red: 0.83, green: 0.93, blue: 0.85, alpha: 1)
            amountLabel.textColor = UIColor(red: 0.13, green: 0.62, blue: 0.29, alpha: 1)
        } else {
            typeLabel.text = "expense"
            typeLabel.textColor = UIColor(red: 0.447, green: 0.11, blue: 0.141, alpha: 1)
            typeTagView.backgroundColor = UIColor(red: 0.973, green: 0.843, blue: 0.855, alpha: 1)
            amountLabel.textColor = UIColor(red: 0.86, green: 0.2, blue: 0.25, alpha: 1)
        }

        switch transaction.category {
        case "Savings Account", "Investment":
            showCategoryTag("Savings", background: UIColor(red: 0.157, green: 0.655, blue: 0.271, alpha: 1), text: .white)
        case "Entertainment/Leisure":
            showCategoryTag("Want", background: UIColor(red: 0.09, green: 0.635, blue: 0.722, alpha: 1), text: UIColor(red: 0.02, green: 0.22, blue: 0.27, alpha: 1))
        case "Salary", "Other":
            categoryTagView.isHidden = true
        default:
            showCategoryTag("Essential", background: UIColor(red: 1, green: 0.757, blue: 0.027, alpha: 1), text: UIColor(red: 0.42, green: 0.3, blue: 0, alpha: 1))
        }

        titleLabel.text = transaction.description
        categoryLabel.text = transaction.category
        dateLabel.text = transaction.date.formatted(date: .abbreviated, time: .omitted)

        let sign = transaction.isIncome ? "+" : "-"
        amountLabel.text = sign + transaction.amount.formatted(.currency(code: "USD"))
    }

    func showCategoryTag(_ title: String, background: UIColor, text: UIColor) {
        categoryTagView.isHidden = false
        categoryTagLabel.text = title
        categoryTagLabel.textColor = text
        categoryTagView.backgroundColor = background
    }
}
