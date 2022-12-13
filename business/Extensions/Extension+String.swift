//
//  Extension+String.swift
//  business
//
//  Created by Rahmat Hidayat on 13/12/22.
//

import Foundation

extension String {
    func dateRelativeFormatting() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.DEFAULT_DATE_TIME_FORMAT
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: date)
    }
}
