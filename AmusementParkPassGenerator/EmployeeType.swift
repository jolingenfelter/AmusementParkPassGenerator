//
//  EmployeeType.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

enum EmployeeType: String, Entrant {
    
    case FoodServices = "Food Services"
    case RideServices = "Ride Services"
    case Maintenance = "Maintenance"
    case Manager = "Manager"
    
    func areaAccess() -> AreaAccessType {
        switch self {
        case .FoodServices:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
        case .RideServices:
            return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
        case .Maintenance:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        case .Manager:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Manager:
            return DiscountAccessType(foodDiscount: 25, merchandiseDiscount: 25)
        default:
            return DiscountAccessType(foodDiscount: 15, merchandiseDiscount: 25)
        }
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: true, skipLines: false)
    }
}

