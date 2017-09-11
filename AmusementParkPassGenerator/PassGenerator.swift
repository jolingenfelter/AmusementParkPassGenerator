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
                throw PersonalInformationError.InvalidDOB
            }
            
            let entrantAge = try calculateAge(self.entrant)
            
            if entrantAge > 5 {
                throw PersonalInformationError.InvalidDOB
            }
        
        case GuestType.seniorGuest:
            guard self.entrant.firstName != nil else {
                throw PersonalInformationError.InvalidName
            }
            
            guard self.entrant.lastName != nil else {
                throw(PersonalInformationError.InvalidName)
            }
            
            guard self.entrant.DOB != nil else {
                throw PersonalInformationError.InvalidDOB
            }
            
            let entrantAge = try calculateAge(self.entrant)
            
            if entrantAge < 65 {
                self.entrantType = GuestType.classic
            }
            
        case is EmployeeType, is ContractEmployeeType:
            guard self.entrant.DOB != nil else {
                throw PersonalInformationError.InvalidDOB
            }
            guard self.entrant.SSN != nil else {
                throw PersonalInformationError.InvalidSSN
            }
            guard self.entrant.firstName != nil else {
                throw PersonalInformationError.InvalidName
            }
            guard self.entrant.lastName != nil else {
                throw PersonalInformationError.InvalidName
            }
            guard self.entrant.address != nil else {
                throw PersonalInformationError.InvalidAddress
            }
            guard self.entrant.city != nil else {
                throw PersonalInformationError.InvalidCity
            }
            guard self.entrant.state != nil else {
                throw PersonalInformationError.InvalidState
            }
            guard self.entrant.zipCode != nil else {
                throw PersonalInformationError.InvalidZipCode
            }
            
        case GuestType.seasonPass:
            guard self.entrant.DOB != nil else {
                throw PersonalInformationError.InvalidDOB
            }
            guard self.entrant.firstName != nil else {
                throw PersonalInformationError.InvalidName
            }
            guard self.entrant.lastName != nil else {
                throw PersonalInformationError.InvalidName
            }
            guard self.entrant.address != nil else {
                throw PersonalInformationError.InvalidAddress
            }
            guard self.entrant.city != nil else {
                throw PersonalInformationError.InvalidCity
            }
            guard self.entrant.state != nil else {
                throw PersonalInformationError.InvalidState
            }
            guard self.entrant.zipCode != nil else {
                throw PersonalInformationError.InvalidZipCode
            }
        
        case is VendorType:
            guard self.entrant.firstName != nil else {
                throw PersonalInformationError.InvalidName
            }
            
            guard self.entrant.lastName != nil else {
                throw PersonalInformationError.InvalidName
            }
            
        default: break
        
        }
    
    }
    
    func printData() {
        print(entrant, entrantType)
    }
    
}
