//
//  AccountCustomRow.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 26.04.2023.
//

import UIKit
import Eureka

final class AccountCustomRow: Row<AccountTableViewCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<AccountTableViewCell>(nibName: "AccountTableViewCell")
        cell.height = { 50 }
    }
}
