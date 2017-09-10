//
//  PersonalInformationError.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

enum PersonalInformationError: String, Error {
    case InvalidName = "No valid name provided"
    case InvalidAddress = "No valid address provided"
    case InvalidCity = "No valid city provided"
    case InvalidState = "No valid state provided"
    case InvalidZipCode = "Invalid zip code"
    case InvalidSSN = "Invalid social security number"
    case InvalidDOB = "Invalid date of birth"
    case InvalidEntrantType = "Invalid Entrant Type"
}
