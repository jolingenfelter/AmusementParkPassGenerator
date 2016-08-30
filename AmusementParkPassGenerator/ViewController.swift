//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Joanna Lingenfelter on 8/16/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var accessGrantedSound: SystemSoundID = 0
    var accessDeniedSound: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAccessDeniedSound()
        loadAccessGrantedSound()
        
        
        //Create filler data
        
        
        // Classic guest tries to enter as child
        /*
        let classicGuest = Person(firstName: nil, lastName: nil, address: nil, city: nil, state: nil, zipCode: nil, SSN: nil, DOB: "8/20/1990")
        let classicGuestPass = PassGenerator(entrant: classicGuest, entrantType: GuestType.freeChild)

        do {
            try classicGuestPass.checkForCorrectData()
        } catch {
            
        }
        
        classicGuestPass.printData()
         */
        
        // Senior guest
        /*
        let seniorGuest = Person(firstName: "Billy", lastName: "Bob", address: "an Adress", city: "City", state: "State", zipCode: 1236548, SSN: nil, DOB: "12/27/1900", dateOfVisit: nil, associatedCompany: nil)
        let seniorGuestPass = PassGenerator(entrant: seniorGuest, entrantType: GuestType.seniorGuest)
        
        do {
            try seniorGuestPass.checkForCorrectData()
        } catch {
            
        }
        
        seniorGuestPass.printData()
        */
        
        // Vendor
        
        let vendor = Person(firstName: "Henry", lastName: "Button", address: "1234 Somewhere St.", city: "City", state: "State", zipCode: 1234567, SSN: 1234567, DOB: "12/31/1988", dateOfVisit: "8/30/2016", associatedCompany: .Fedex)
        
        let vendorPass = PassGenerator(entrant: vendor, entrantType: vendor.associatedCompany!)
 
        do {
            try vendorPass.checkForCorrectData()
        } catch {
            
        }
        
        vendorPass.printData()
        
        // Kitchen Employee with birthday
     
        /*
        let kitchenEmployee = Person(firstName: "Jane", lastName: "Doe", address: "123 Apple St.", city: "Somewhere", state: "State", zipCode: 123456, SSN: nil, DOB: "08/21/1988")
        let kitchenEmplyeePass = PassGenerator(entrant: kitchenEmployee, entrantType: EmployeeType.FoodServices)
        
        do {
            try kitchenEmplyeePass.checkForCorrectData()
        } catch {
            
        }
        
        kitchenEmplyeePass.printData()
       */
        
        /*
        let manager = Person(firstName: "Billy", lastName: "Bob", address: "135 6th Street", city: "City", state: "State", zipCode: 1234567, SSN: 1234556, DOB: "11/13/1978")
        let managerPass = PassGenerator(entrant: manager, entrantType: EmployeeType.Manager)
        
        do {
            try managerPass.checkForCorrectData()
        } catch {
            
        }
        
        managerPass.printData()
        */
        
        // Check one area to see if access is correct for EntrantType
        func swipePassAtOfficeArea(pass: PassGenerator) {
            switch pass.entrantType {
            case is GuestType:
                playAccessDeniedSound()
                print("Access denied")
            case EmployeeType.FoodServices, EmployeeType.Maintenance, EmployeeType.RideServices:
                playAccessDeniedSound()
                print("Access denied")
            case EmployeeType.Manager:
                playAccessGrantedSound()
                print("Access granted")
            default:
                break
            }
        }
        
        //swipePassAtOfficeArea(managerPass)
        //swipePassAtOfficeArea(classicGuestPass)
        //swipePassAtOfficeArea(seniorGuestPass)
 
 

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Sound Effects
    
    func loadAccessGrantedSound() {
        let pathToFile = NSBundle.mainBundle().pathForResource("AccessGranted", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToFile!)
        AudioServicesCreateSystemSoundID(soundURL, &accessGrantedSound)
    }
    
    func loadAccessDeniedSound() {
        let pathToFile = NSBundle.mainBundle().pathForResource("AccessDenied", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToFile!)
        AudioServicesCreateSystemSoundID(soundURL, &accessDeniedSound)
    }
    
    func playAccessGrantedSound() {
        AudioServicesPlaySystemSound(accessGrantedSound)
    }
    
    func playAccessDeniedSound() {
        AudioServicesPlaySystemSound(accessDeniedSound)
    }


}

