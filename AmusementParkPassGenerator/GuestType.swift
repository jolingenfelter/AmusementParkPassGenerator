//
//  GuestType.swift
//  AmusementParkPassGenerator
//
//  Created by Joanna Lingenfelter on 8/16/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import Foundation


enum GuestType: String, Entrant {
    case Classic = "Classic"
    case VIP = "VIP"
    case freeChild = "Child"
    case seasonPass = "Season Pass"
    case seniorGuest = "Senior"
    
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
}
