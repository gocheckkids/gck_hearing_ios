//
//  Date + Formatting.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/19/24.
//

import Foundation


extension Date {
    
    // Easier init with values
     init(year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        self = calendar.date(from: dateComponents) ?? Date.distantPast
        
    }
    
    // Return random date
    static func randomDate() -> Date {
         let randomInterval = TimeInterval(arc4random_uniform(UInt32.max))
         let randomDate = Date(timeIntervalSince1970: randomInterval)
         return randomDate
     }
    
    /// Compare date to today's date (omitting time)
    func isCurrentDay() -> Bool {
        return self.formattedAsDateString() == Date.now.formattedAsDateString()
    }
    /// Returns String as MM/DD/YYYY
    func formattedAsDateString() -> String {
        return self.formatted(date: .numeric, time: .omitted)
    }
}
