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
    
    var mockLocationList = [
        "Clinical Practice #1",
        "Clinical Practice #2",
        "Clinical Practice #3",
        "Clinical Practice #4",
        "Clinical Practice #5",
        "Clinical Practice #6",
        "Clinical Practice #7",
        "Clinical Practice #8",
        "Clinical Practice #9",
        "Clinical Practice #10"
    ]
    
    var mockPatient = Patient(id: 003, firstName: "Jackie", lastName: "Bulb", birthdate: Date.randomDate())
    
    lazy var mockPatientList1 = [
        Patient(id: 01, firstName: "Jahn", lastName: "Smith", birthdate: Date.randomDate()),
        Patient(id: 02, firstName: "Dada", lastName: "Pinky", birthdate: Date.randomDate()),
        Patient(id: 03, firstName: "Jimmy", lastName: "Gordon", birthdate: Date.randomDate()),
        Patient(id: 04, firstName: "Zoey", lastName: "Oneoone", birthdate: Date.randomDate())
    ]
     
    lazy var mockPatientList2 = [
        Patient(id: 05, firstName: "Emma", lastName: "Johnson", birthdate: Date.randomDate()),
        Patient(id: 06, firstName: "Michael", lastName: "Chang", birthdate: Date.randomDate()),
        Patient(id: 07, firstName: "Sophia", lastName: "Martinez", birthdate: Date.randomDate()),
        Patient(id: 08, firstName: "Alexander", lastName: "Lee", birthdate: Date.randomDate()),
        ]
    
    lazy var mockPatientList3 = [
        Patient(id: 09, firstName: "Bubbles", lastName: "McGee", birthdate: Date.randomDate()),
        Patient(id: 10, firstName: "Sunny", lastName: "Delight", birthdate: Date.randomDate()),
        Patient(id: 11, firstName: "Bartholomew", lastName: "Fiddlesticks", birthdate: Date.randomDate()),
        Patient(id: 12, firstName: "Princess", lastName: "Sparklepants", birthdate: Date.randomDate()),
        ]
    
    lazy var mockPatientListAll = [
        Patient(id: 01, firstName: "Jahn", lastName: "Smith", birthdate: Date.randomDate()),
        Patient(id: 02, firstName: "Dada", lastName: "Pinky", birthdate: Date.randomDate()),
        Patient(id: 03, firstName: "Jimmy", lastName: "Gordon", birthdate: Date.randomDate()),
        Patient(id: 04, firstName: "Zoey", lastName: "Oneoone", birthdate: Date.randomDate()),
        
        Patient(id: 05, firstName: "Emma", lastName: "Johnson", birthdate: Date.randomDate()),
        Patient(id: 06, firstName: "Michael", lastName: "Chang", birthdate: Date.randomDate()),
        Patient(id: 07, firstName: "Sophia", lastName: "Martinez", birthdate: Date.randomDate()),
        Patient(id: 08, firstName: "Alexander", lastName: "Lee", birthdate: Date.randomDate()),
        
        Patient(id: 09, firstName: "Bubbles", lastName: "McGee", birthdate: Date.randomDate()),
        Patient(id: 10, firstName: "Sunny", lastName: "Delight", birthdate: Date.randomDate()),
        Patient(id: 11, firstName: "Bartholomew", lastName: "Fiddlesticks", birthdate: Date.randomDate()),
        Patient(id: 12, firstName: "Princess", lastName: "Sparklepants", birthdate: Date.randomDate()),
    ]
    
    lazy var mockDayVisitsList = [
        DayVisits(visitDate: Date(year: 2024, month: 3, day: 18), patientList: mockPatientList1),
        DayVisits(visitDate: Date(year: 2023, month: 12, day: 30), patientList: mockPatientList2),
        DayVisits(visitDate: Date(year: 2023, month: 12, day: 15), patientList: mockPatientList3)
    ]
    
    var mockPatientVisits = [
        ResultsModel(date: "01/10/24", referralResult: true),
        ResultsModel(date: "12/03/23", referralResult: false),
        ResultsModel(date: "11/04/23", referralResult: false)
    ]
    
    var mockPatientResultDetails = ResultDetails(date: "12/01/23")
}
