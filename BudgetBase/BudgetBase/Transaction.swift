//
//  Transaction.swift
//  BudgetBase
//
//  Created by Chantal Le on 10/23/26.
//

import Foundation

struct Transaction {
    var isIncome: Bool
    var amount: Double
    var date: Date
    var category: String
    var description: String
    var notes: String?
}
