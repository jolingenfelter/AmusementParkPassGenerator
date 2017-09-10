//
//  PassViewController.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/4/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import UIKit
import AudioToolbox

class PassViewController: UIViewController {
    
    // Area Testing Labels
    @IBOutlet weak var kitchenLabel: UILabel!
    @IBOutlet weak var amusementParkLabel: UILabel!
    @IBOutlet weak var maintenanceZonesLabel: UILabel!
    @IBOutlet weak var officesLabel: UILabel!
    @IBOutlet weak var rideControlLabel: UILabel!
    
    @IBOutlet weak var areaTestingStackView: UIStackView!
    
    // Discount Testing Labels
    @IBOutlet weak var merchandiseLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    
    //Ride Access Testing Label
    @IBOutlet weak var rideAccessLabel: UILabel!

    
    // Buttons
    @IBOutlet weak var AreaAccessTestButton: UIButton!
    @IBOutlet weak var RideAccessTestButton: UIButton!
    @IBOutlet weak var DiscountAccessTestButton: UIButton!
    @IBOutlet weak var CreateNewPassButton: UIButton!
    
    // Views
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var testAreaView: UIView!
    
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // SoundEffects
    let soundCoordinator = SoundCoordinator()
    
    var passType = String()
    var date = String()
    
    var generatedPass: PassGenerator?
    
    var entrantDiscountAccess: DiscountAccessType {
        guard let pass = generatedPass?.entrantType else {
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
        
        return pass.discountAccess()
    }
    
    var entrantRideAccess: RideAccessType {
        guard let pass = generatedPass?.entrantType else {
            return RideAccessType(allRides: false, skipLines: false)
        }
        
        return pass.rideAccess()
    }
    
    var entrantAreaAccess: AreaAccessType {
        guard let pass = generatedPass?.entrantType else {
            return AreaAccessType(amusementArea: false, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
        }
        
        return pass.areaAccess()
    }
    
    override func viewDidLoad() {
        
        // Round Corners
        let buttonsArray = [AreaAccessTestButton, RideAccessTestButton, DiscountAccessTestButton, CreateNewPassButton]
        for button in buttonsArray {
            button?.layer.cornerRadius = 5
            button?.layer.masksToBounds = true
        }
        
        let viewsArray = [passView, pictureView, testAreaView]
        for view in viewsArray {
            view?.layer.cornerRadius = 5
            view?.layer.masksToBounds = true
        }
        
        passTypeLabel.text = passType
        dateLabel.text = date
    }

    @IBAction func swipeForAreaAccess(_ sender: AnyObject) {
        areaTestingStackView.isHidden = false
        
        if entrantAreaAccess.amusementArea == true {
            amusementParkLabel.backgroundColor = UIColor.green
        } else {
            amusementParkLabel.backgroundColor = UIColor.red
        }
        
        if entrantAreaAccess.kitchenAreas == true {
           kitchenLabel.backgroundColor = UIColor.green
        } else {
            kitchenLabel.backgroundColor = UIColor.red
        }
        
        if entrantAreaAccess.maintenanceAreas == true {
            maintenanceZonesLabel.backgroundColor = UIColor.green
        } else {
            maintenanceZonesLabel.backgroundColor = UIColor.red
        }
        
        if entrantAreaAccess.officeAreas == true {
            officesLabel.backgroundColor = UIColor.green
        } else {
            officesLabel.backgroundColor = UIColor.red
        }
        
        if entrantAreaAccess.rideControlAreas == true {
            rideControlLabel.backgroundColor = UIColor.green
        } else {
            rideControlLabel.backgroundColor = UIColor.red
        }
        
        if entrantAreaAccess.amusementArea == false && entrantAreaAccess.kitchenAreas == false && entrantAreaAccess.maintenanceAreas == false && entrantAreaAccess.officeAreas == false && entrantAreaAccess.rideControlAreas == false {
            soundCoordinator.playAccessDeniedSound()
        } else {
            soundCoordinator.playAccessGrantedSound()
        }
    }
    
    @IBAction func swipeForRideAccess(_ sender: AnyObject) {
        if entrantRideAccess.allRides == true && entrantRideAccess.skipLines == true {
            rideAccessLabel.text = "All rides, skip lines"
            soundCoordinator.playAccessGrantedSound()
        }
        
        if entrantRideAccess.allRides == false && entrantRideAccess.skipLines == false {
            rideAccessLabel.text = "No ride access"
            soundCoordinator.playAccessDeniedSound()
        }
        
        if entrantRideAccess.allRides == true && entrantRideAccess.skipLines == false {
            rideAccessLabel.text = "All rides, normal lines"
            soundCoordinator.playAccessGrantedSound()
        }
    }
    
    @IBAction func swipeForDiscountAccess(_ sender: AnyObject) {
        
        if entrantDiscountAccess.merchandiseDiscount != 0 {
            soundCoordinator.playAccessGrantedSound()
            merchandiseLabel.text = "Merchandise discount: \(String(entrantDiscountAccess.merchandiseDiscount))%"
        }
        
        if entrantDiscountAccess.foodDiscount != 0 {
            soundCoordinator.playAccessGrantedSound()
            foodLabel.text = "Food discount: \(entrantDiscountAccess.foodDiscount)%"
        }
        
        else if entrantDiscountAccess.foodDiscount == 0 && entrantDiscountAccess.merchandiseDiscount == 0 {
            soundCoordinator.playAccessDeniedSound()
            merchandiseLabel.text = "No discount on merchandise today"
            foodLabel.text = "No discount on food today"
        }
    }
    
}
