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
