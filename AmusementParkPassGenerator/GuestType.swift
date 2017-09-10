//
//  GuestType.swift
//  AmusementParkPassGenerator
//
//  Created by Joanna Lingenfelter on 8/16/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import Foundation


enum GuestType: String, Entrant {
    
    case classic = "Classic"
    case VIP = "VIP"
    case freeChild = "Child"
    case seasonPass = "Season Pass"
    case seniorGuest = "Senior"
    
    static var entrantType: EntrantType {
        return EntrantType.guest
    }
    
    func areaAccess() -> AreaAccessType {
        return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .VIP, .seasonPass:
            return DiscountAccessType(foodDiscount: 10, merchandiseDiscount: 20)
        case .seniorGuest:
            return DiscountAccessType(foodDiscount: 10, merchandiseDiscount: 10)
        default:
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .VIP, .seasonPass, .seniorGuest:
            return RideAccessType(allRides: true, skipLines: true)
        default:
            return RideAccessType(allRides: true, skipLines: false)
        }
    }
    
    var testCase: Person {
        
        switch self {
        case .freeChild:
            return Person(firstName: nil, lastName: nil, address: nil, city: nil, state: nil, zipCode: nil, SSN: nil, DOB: "9/10/2017", dateOfVisit: nil)
        case .seniorGuest:
            return Person(firstName: nil, lastName: nil, address: nil, city: nil, state: nil, zipCode: nil, SSN: nil, DOB: "1/1/1900", dateOfVisit: nil)
        case .seasonPass:
            return Person(firstName: "Johnny", lastName: "Rocket", address: "555 Somewhere Rd", city: "City", state: "State", zipCode: nil, SSN: nil, DOB: "1/1/1990", dateOfVisit: "1/1/2017")
        default:
            return Person()
        }
    }
}
