//
//  dateFormatter.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 8/20/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import Foundation

// Methods to check age and birthday

var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
}

func calculateAge(_ person: Person) throws -> Int {
    
    var ageComponents = DateComponents()
    
    guard let birthday = person.DOB, let fromDate = dateFormatter.date(from: birthday) else {
        throw PersonalInformationError.InvalidDOB
    }
    
    let calendar = Calendar.current
        
    ageComponents = (calendar as NSCalendar).components(NSCalendar.Unit.year, from: fromDate, to: Date(), options: [])

    return ageComponents.year!
    
}

func checkForBirthday(_ person: Person) {
    
    if let birthday = person.DOB {
        let birthdayDate = dateFormatter.date(from: birthday)
        let calendar = Calendar.current
        let todayComponents = (calendar as NSCalendar).components([.month, .day], from: Date())
        let birthdayComponents = (calendar as NSCalendar).components([.month, .day], from: birthdayDate!)
        
        if todayComponents.month == birthdayComponents.month && todayComponents.day == birthdayComponents.day {
            print("Happy birthday!  Thanks for choosing us to spend your special day with!")
        }
        
    }
}
