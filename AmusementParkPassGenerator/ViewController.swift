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
    
    // Instance of Person created from input data
    
    var entrant = Person()
    
    // Button Highlighting Variables
    
    @IBOutlet weak var secondRowButtonsStackView: UIStackView!
    
    var currentlySelectedTypeButton = UIButton()
    var previouslySelectedTypeButton = UIButton()
    
    var buttonPressedPurple = UIColor()
    var buttonNormalStatePurple = UIColor()
    
    var secondRowButtonsArray = [UIButton]()
    
    var currentlySelectedSubType = UIButton()
    var previouslySelectedSubType = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAccessDeniedSound()
        loadAccessGrantedSound()
        
        buttonPressedPurple = UIColor(red: 151/255.0, green: 114/255.0, blue: 194/255.0, alpha: 1)
        buttonNormalStatePurple = UIColor(red: 129/255.0, green: 98/255.0, blue: 164/255.0, alpha: 1.0)
        
        secondRowButtonsArray = [r2b1, r2b2, r2b3, r2b4]
        
        self.initialViewSetup()
    }
    
    func initialViewSetup() {
        
        currentlySelectedTypeButton = guestButton
        currentlySelectedTypeButton.backgroundColor = buttonPressedPurple
        
        setSecondRowButtons(guestButton)
        
        currentlySelectedSubType = r2b1
        currentlySelectedSubType.selected = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func entrantTypeSelected(sender: UIButton) {
        
        switch sender.tag {
        
        case 1:
            switchHighlight(guestButton)
            setSecondRowButtons(guestButton)
        case 2:
            switchHighlight(employeeButton)
            setSecondRowButtons(employeeButton)
        case 3:
            switchHighlight(contractorButton)
            setSecondRowButtons(contractorButton)
        case 4:
            switchHighlight(vendorButton)
            setSecondRowButtons(vendorButton)
        default: break
        
        }
    }
    
    @IBAction func entrantSubtypeSelected(sender: UIButton) {
        
        switch sender.currentTitle! {
        
        // Guest
        case "Child" :
           highlightSubtype(r2b1)
        case "Adult":
            highlightSubtype(r2b2)
        case "Senior":
            highlightSubtype(r2b3)
        case "Season Pass":
            highlightSubtype(r2b4)
        
        // Employee
        case "Food Services":
            highlightSubtype(r2b1)
        case "Ride Services":
            highlightSubtype(r2b2)
        case "Maintenance":
            highlightSubtype(r2b3)
        case "Manager" :
            highlightSubtype(r2b4)
            
        default: break
            
        }
    }
    
    func highlightSubtype(button: UIButton) {
        previouslySelectedSubType = currentlySelectedSubType
        previouslySelectedSubType.selected = false
        currentlySelectedSubType = button
        currentlySelectedSubType.selected = true
    }
    
    func setSecondRowButtons(button: UIButton) {
        switch button {
            case guestButton :
                r2b1.setTitle("Child", forState: .Normal)
                r2b2.setTitle("Adult", forState: .Normal)
                r2b3.setTitle("Senior", forState: .Normal)
                r2b4.setTitle("Season Pass", forState: .Normal)
                
                secondRowButtonsStackView.hidden = false
            
            case employeeButton :
                r2b1.setTitle("Food Services", forState: .Normal)
                r2b2.setTitle("Ride Services", forState: .Normal)
                r2b3.setTitle("Maintenance", forState: .Normal)
                r2b4.setTitle("Manager", forState: .Normal)
                
                secondRowButtonsStackView.hidden = false
            
            case contractorButton :
            
                secondRowButtonsStackView.hidden = true
            
            case vendorButton :
            
                secondRowButtonsStackView.hidden = true
        
            default: break
        }
    }
    
    
    func switchHighlight(button: UIButton) {
        previouslySelectedTypeButton = currentlySelectedTypeButton
        previouslySelectedTypeButton.backgroundColor = buttonNormalStatePurple
        currentlySelectedTypeButton = button
        button.backgroundColor = buttonPressedPurple
    }
    
    // Helper Methods
    
    func displayAlertWithTitle(title: String, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
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

