//
//  dateFormatter.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 8/20/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import Foundation

// Methods to check age and birthday

var dateFormatter: NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
}

func calculateAge(person: Person) -> Int {
    
    var ageComponents = NSDateComponents()
    
    if let birthday = person.DOB  {
        let calendar = NSCalendar.currentCalendar()
        
        ageComponents = calendar.components(NSCalendarUnit.Year, fromDate: dateFormatter.dateFromString(birthday)!, toDate: NSDate(), options: [])
    }
    
    return ageComponents.year
    
}

func checkForBirthday(person: Person) {
    
    if let birthday = person.DOB {
        let birthdayDate = dateFormatter.dateFromString(birthday)
        let calendar = NSCalendar.currentCalendar()
        let todayComponents = calendar.components([.Month, .Day], fromDate: NSDate())
        let birthdayComponents = calendar.components([.Month, .Day], fromDate: birthdayDate!)
        
        if todayComponents.month == birthdayComponents.month && todayComponents.day == birthdayComponents.day {
            print("Happy birthday!  Thanks for choosing us to spend your special day with!")
        }
        
    }
}