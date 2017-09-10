//
//  EmployeeType.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

enum EmployeeType: String, Entrant {
    
    case foodServices = "Food Services"
    case rideServices = "Ride Services"
    case maintenance = "Maintenance"
    case manager = "Manager"
    
    var entrantType: EntrantType {
        return EntrantType.employee
    }
    
    func areaAccess() -> AreaAccessType {
        switch self {
        case .foodServices:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
        case .rideServices:
            return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
        case .maintenance:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        case .manager:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .manager:
            return DiscountAccessType(foodDiscount: 25, merchandiseDiscount: 25)
        default:
            return DiscountAccessType(foodDiscount: 15, merchandiseDiscount: 25)
        }
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: true, skipLines: false)
    }
}

