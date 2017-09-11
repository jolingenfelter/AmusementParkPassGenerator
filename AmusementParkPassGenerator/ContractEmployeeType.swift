//
//  ContractEmployeeType.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

enum ContractEmployeeType: String, Entrant {
    
    case a = "1001"
    case b = "1002"
    case c = "1003"
    case d = "2001"
    case e = "2002"
    
    static var entrantType: String {
        return "\(ContractEmployeeType.self)"
    }
    
    func areaAccess() -> AreaAccessType {
        switch self {
        case .a:
            return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
        case .b:
            return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: true, officeAreas: false)
        case .c:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        case .d:
            return AreaAccessType(amusementArea: false, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: true)
        case .e:
            return AreaAccessType(amusementArea: false, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: true, officeAreas: false)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: false, skipLines: false)
    }
    
    static var testCase: Person {
        return Person(firstName: "Johnny", lastName: "Rocket", address: "555 Somewhere Rd", city: "City", state: "State", zipCode: 55555, SSN: 1112223333, DOB: "1/1/1990", dateOfVisit: "1/1/2017")
    }
}
