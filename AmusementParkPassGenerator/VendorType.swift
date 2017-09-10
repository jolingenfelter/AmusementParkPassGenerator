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
    
    static var entrantType: EntrantType {
        return EntrantType.vendor
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
    
}
