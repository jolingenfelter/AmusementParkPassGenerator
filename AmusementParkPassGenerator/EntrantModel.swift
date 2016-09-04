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
    case InvalidDateOfVisit = "Invalid visit date"
    case InvalidCompany = "Invalid Company"
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
    var dateOfVisit: String? { get }
    var associatedCompany: VendorType? { get }
}

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
            return DiscountAccessType(foodDiscount: 0.25, merchandiseDiscount: 0.25)
        default:
            return DiscountAccessType(foodDiscount: 0.15, merchandiseDiscount: 0.25)
        }
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: true, skipLines: false)
    }
}

enum VendorType: String, Entrant {
    
    case ACME = "ACME"
    case Orkin = "Orkin"
    case Fedex = "Fedex"
    case NWElectrical = "NW Electrical"
    
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
        return DiscountAccessType(foodDiscount: nil, merchandiseDiscount: nil)
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: false, skipLines: false)
    }
    
}

enum ContractEmployeeType: Int, Entrant {
    
    case A = 1001
    case B = 1002
    case C = 1003
    case D = 2001
    case E = 2002
    
    func areaAccess() -> AreaAccessType {
        switch self {
        case A:
            return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
        case B:
            return AreaAccessType(amusementArea: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: true, officeAreas: false)
        case C:
            return AreaAccessType(amusementArea: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
        case D:
            return AreaAccessType(amusementArea: false, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: true)
        case E:
            return AreaAccessType(amusementArea: false, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: true, officeAreas: false)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        return DiscountAccessType(foodDiscount: nil, merchandiseDiscount: nil)
    }
    
    func rideAccess() -> RideAccessType {
        return RideAccessType(allRides: false, skipLines: false)
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
    var dateOfVisit: String?
    var associatedCompany: VendorType?
    
}

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
            return DiscountAccessType(foodDiscount: 0.10, merchandiseDiscount: 0.20)
        case .seniorGuest:
            return DiscountAccessType(foodDiscount: 0.10, merchandiseDiscount: 0.10)
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