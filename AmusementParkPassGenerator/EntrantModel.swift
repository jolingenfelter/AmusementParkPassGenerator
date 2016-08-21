//
//  EntrantModel.swift
//  AmusementParkPassGenerator
//
//  Created by Joanna Lingenfelter on 8/16/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import Foundation

protocol Entrant: AreaAccess, DiscountAccess, RideAccess {
    
}

protocol AreaAccess {
    func areaAccess() -> AreaAccessType
}

protocol DiscountAccess {
    func discountAccess() -> DiscountAccessType
}

protocol RideAccess {
    func rideAccess() -> RideAccessType
}

struct AreaAccessType {
    var amusementArea: Bool
    var kitchenAreas: Bool
    var rideControlAreas: Bool
    var maintenanceAreas: Bool
    var officeAreas: Bool
}

struct RideAccessType {
    var allRides: Bool
    var skipLines: Bool
}

struct DiscountAccessType {
    var foodDiscount: Double?
    var merchandiseDiscount: Double?
}

enum PersonalInformationError: String, ErrorType {
    case InvalidName = "No valid name provided"
    case InvalidAddress = "No valid address provided"
    case InvalidCity = "No valid city provided"
    case InvalidState = "No valid state provided"
    case InvalidZipCode = "No valid zipcode provided"
    case InvalidSSN = "No valid social security number provided"
    case InvalidDOB = "Invalid date of birth"
    case InvalidEntrantType = "Invalid Entrant Type"
}

protocol PersonalInformation {
    var firstName: String? { get}
    var lastName: String? { get }
    var address: String? { get }
    var city: String? { get }
    var state: String? { get }
    var zipCode: Int? { get }
    var SSN: Int? { get }
    var DOB: String? { get }
}

enum EmployeeType: Entrant {
    case FoodServices
    case RideServices
    case Maintenance
    case Manager
    
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
            return DiscountAccessType(foodDiscount: 0.25, merchandiseDiscount: 0.25)
        default:
            return DiscountAccessType(foodDiscount: 0.15, merchandiseDiscount: 0.25)
        }
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: true, skipLines: false)
    }
}

struct Person: PersonalInformation {
    var firstName: String?
    var lastName: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var SSN: Int?
    var DOB: String?
    
}

enum GuestType: Entrant {
    case Classic
    case VIP
    case freeChild
    
    func areaAccess() -> AreaAccessType {
        return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .VIP:
            return DiscountAccessType(foodDiscount: 0.10, merchandiseDiscount: 0.20)
        default:
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .VIP:
            return RideAccessType(allRides: true, skipLines: true)
        default:
            return RideAccessType(allRides: true, skipLines: false)
        }
    }
}