//
//  DateFormatterExtension.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation



enum MovieFormat {
    case searchCell
    case detailView
}

extension DateFormatter {
    
    func movieCellDateFormat(from str: String) -> String? {
        self.dateFormat = "YYYY-MM-dd"
        guard let date = self.date(from: str) else { return nil }
        self.dateFormat = "MMMM d, YYYY"
        return self.string(from: date)
    }
    
    func movieDetailDateFormat(from str: String) -> String? {
        self.dateFormat = "YYYY-MM-dd"
        guard let date = self.date(from: str) else { return nil }
        self.dateFormat = "M/d/YY"
        return self.string(from: date)
    }
    
}
