//
//  VendorType.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

enum VendorType: String, Entrant {
    
    case ACME = "Acme"
    case Orkin = "Orkin"
    case Fedex = "Fedex"
    case NWElectrical = "NW Electrical"
    
    static var entrantType: String {
        return "\(VendorType.self)"
    }
    
    func areaAccess() -> AreaAccessType {
        switch self {
        case .ACME:
            return AreaAccessType(amusementArea: false, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
        case .Orkin:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
        case .Fedex:
            return AreaAccessType(amusementArea: false, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: true, officeAreas: true)
        case .NWElectrical:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: false, skipLines: false)
    }
    
    static var testCase: Person {
        return Person(firstName: "Johnny", lastName: "Rocket", address: "555 Somewhere Rd", city: "City", state: "State", zipCode: 55555, SSN: nil, DOB: "1/1/1990", dateOfVisit: "1/1/2017")
    }
    
}
