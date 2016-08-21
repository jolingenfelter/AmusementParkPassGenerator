//
//  PassGenerator.swift
//  AmusementParkPassGenerator
//
//  Created by Joanna Lingenfelter on 8/17/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import Foundation

// Generates a pass for a guest or employee

class PassGenerator {
    var entrant: Person
    var entrantType: Entrant
    
    init(entrant: Person, entrantType: Entrant) {
        self.entrant = entrant
        self.entrantType = entrantType
    }
    
    func checkForCorrectData() throws {
        switch self.entrantType {
        case GuestType.freeChild:
            guard self.entrant.DOB != nil else {
                print(PersonalInformationError.InvalidDOB.rawValue)
                throw PersonalInformationError.InvalidDOB
            }
            
            let entrantAge = calculateAge(self.entrant)
            
            if entrantAge > 5 {
                self.entrantType = GuestType.Classic
            }
        
        case GuestType.Classic, GuestType.VIP:
            print("No information necessary")
        
        case is EmployeeType:
            guard self.entrant.firstName != nil else {
                print(PersonalInformationError.InvalidName.rawValue)
                throw PersonalInformationError.InvalidName
            }
            guard self.entrant.lastName != nil else {
                print(PersonalInformationError.InvalidName.rawValue)
                throw PersonalInformationError.InvalidName
            }
            guard self.entrant.address != nil else {
                (PersonalInformationError.InvalidName.rawValue)
                throw PersonalInformationError.InvalidAddress
            }
            guard self.entrant.city != nil else {
                (PersonalInformationError.InvalidCity.rawValue)
                throw PersonalInformationError.InvalidCity
            }
            guard self.entrant.state != nil else {
                (PersonalInformationError.InvalidState.rawValue)
                throw PersonalInformationError.InvalidState
            }
            guard self.entrant.zipCode != nil else {
                (PersonalInformationError.InvalidZipCode.rawValue)
                throw PersonalInformationError.InvalidZipCode
            }
            
        default: break
        
        }
        
        checkForBirthday(self.entrant)
    
    }
    
    func printData() {
        print(entrant, entrantType)
    }
    
}