//
//  FakeDatabase.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation

/// Mocked JSON data
let jsonData = """
[
  {
    "first_name": "John",
    "last_name": "Doe",
    "date_of_birth": "1990-05-15"
  },
  {
    "first_name": "Alice",
    "last_name": "Smith",
    "date_of_birth": "1985-10-20"
  },
  {
    "first_name": "Michael",
    "last_name": "Johnson",
    "date_of_birth": "1978-03-28"
  },
  {
    "first_name": "Emily",
    "last_name": "Brown",
    "date_of_birth": "1995-12-10"
  },
  {
    "first_name": "David",
    "last_name": "Martinez",
    "date_of_birth": "1983-07-04"
  },
  {
    "first_name": "Emma",
    "last_name": "Taylor",
    "date_of_birth": "1992-09-03"
  },
  {
    "first_name": "Daniel",
    "last_name": "Wilson",
    "date_of_birth": "1989-11-18"
  }
]
""".data(using: .utf8)!

class MockData {
    static let shared = MockData()
    
    
    var mockPatient = Patient(id: 003, firstName: "Jackie", lastName: "Bulb", dob: "2-05-2019")
    
    var mockPatientList = [
        Patient(id: 01, firstName: "Jahn", lastName: "Smith", dob: "2019-04-01"),
        Patient(id: 02, firstName: "Bada", lastName: "Pinkei", dob: "2018-02-18"),
        Patient(id: 03, firstName: "Jimmy", lastName: "Gordon", dob: "2014-01-21"),
        Patient(id: 04, firstName: "Zoey", lastName: "Oneoone", dob: "2016-10-08")]
    
    var mockPatientVisits = [
        ResultsModel(date: "01/10/24", referralResult: true),
        ResultsModel(date: "12/03/23", referralResult: false),
        ResultsModel(date: "11/04/23", referralResult: false)
    ]
    
    var mockPatientResultDetails = ResultDetails(date: "12-01-23")
}
