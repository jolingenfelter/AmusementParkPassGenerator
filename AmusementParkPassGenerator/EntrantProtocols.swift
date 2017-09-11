//
//  EntrantProtocols.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

protocol Entrant: AreaAccess, DiscountAccess, RideAccess {
    static var entrantType: String { get }
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
