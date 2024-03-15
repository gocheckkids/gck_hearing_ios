//
//  ResultModels.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/13/24.
//

import Foundation

struct ResultDetails {
    var date: String
    var leftEarResultMap: Dictionary<Int, Bool> = [:]
    var rightEarResultMap: Dictionary<Int, Bool> = [:]
    
    var hasRiskFactor: Bool = false
}

struct ResultsModel: Identifiable {
    var id = UUID()
    
    var date: String
    var referralResult: Bool
    
    init(date: String, referralResult: Bool) {
        self.date = date
        self.referralResult = referralResult
    }
    
    var riskFactorSummary: String {
        return referralResult ? "Risk Factors": "No Risk Factors"
    }
}
