//
//  Date + Formatting.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/19/24.
//

import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        self = calendar.date(from: dateComponents) ?? Date.distantPast
        
    }
    
    static func randomDate() -> Date {
         let randomInterval = TimeInterval(arc4random_uniform(UInt32.max))
         let randomDate = Date(timeIntervalSince1970: randomInterval)
         return randomDate
     }
}
