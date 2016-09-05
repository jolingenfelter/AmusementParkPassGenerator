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
    
    // Sound Effects 
    var accessGrantedSound: SystemSoundID = 0
    var accessDeniedSound: SystemSoundID = 0
    
    // Area Testing Labels
    @IBOutlet weak var kitchenLabel: UILabel!
    @IBOutlet weak var amusementParkLabel: UILabel!
    @IBOutlet weak var maintenanceZonesLabel: UILabel!
    @IBOutlet weak var officesLabel: UILabel!
    @IBOutlet weak var rideControlLabel: UILabel!
    
    @IBOutlet weak var areaTestingStackView: UIStackView!

    
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
    
    var passType = String()
    var date = String()
    
    var generatedPass: PassGenerator?
    
    var entrantDiscount: DiscountAccessType {
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
        
        loadAccessDeniedSound()
        loadAccessGrantedSound()
        
        // Round Corners
        let buttonsArray = [AreaAccessTestButton, RideAccessTestButton, DiscountAccessTestButton, CreateNewPassButton]
        for button in buttonsArray {
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
        }
        
        let viewsArray = [passView, pictureView, testAreaView]
        for view in viewsArray {
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = true
        }
        
        passTypeLabel.text = passType
        dateLabel.text = date
    }

    @IBAction func swipeForAreaAccess(sender: AnyObject) {
        areaTestingStackView.hidden = false
        
        if entrantAreaAccess.amusementArea == true {
            amusementParkLabel.backgroundColor = UIColor.greenColor()
        } else {
            amusementParkLabel.backgroundColor = UIColor.redColor()
        }
        
        if entrantAreaAccess.kitchenAreas == true {
           kitchenLabel.backgroundColor = UIColor.greenColor()
        } else {
            kitchenLabel.backgroundColor = UIColor.redColor()
        }
        
        if entrantAreaAccess.maintenanceAreas == true {
            maintenanceZonesLabel.backgroundColor = UIColor.greenColor()
        } else {
            maintenanceZonesLabel.backgroundColor = UIColor.redColor()
        }
        
        if entrantAreaAccess.officeAreas == true {
            officesLabel.backgroundColor = UIColor.greenColor()
        } else {
            officesLabel.backgroundColor = UIColor.redColor()
        }
        
        if entrantAreaAccess.rideControlAreas == true {
            rideControlLabel.backgroundColor = UIColor.greenColor()
        } else {
            rideControlLabel.backgroundColor = UIColor.redColor()
        }
        
        if entrantAreaAccess.amusementArea == false && entrantAreaAccess.kitchenAreas == false && entrantAreaAccess.maintenanceAreas == false && entrantAreaAccess.officeAreas == false && entrantAreaAccess.rideControlAreas == false {
            playAccessDeniedSound()
        } else {
            playAccessGrantedSound()
        }
    }
    
    @IBAction func swipeForRideAccess(sender: AnyObject) {
    }
    
    @IBAction func swipeForDiscountAccess(sender: AnyObject) {
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
