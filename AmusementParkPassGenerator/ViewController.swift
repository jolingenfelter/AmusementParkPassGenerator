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
    
    // Buttons
    
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var employeeButton: UIButton!
    @IBOutlet weak var contractorButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    
    // 2nd row Buttons
    @IBOutlet weak var r2b1: UIButton!
    @IBOutlet weak var r2b2: UIButton!
    @IBOutlet weak var r2b3: UIButton!
    @IBOutlet weak var r2b4: UIButton!
    
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    // TextFields
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var SSNTextField: UITextField!
    @IBOutlet weak var projectNumberTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var companyTextField: UITextField!
    
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAccessDeniedSound()
        loadAccessGrantedSound()

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

