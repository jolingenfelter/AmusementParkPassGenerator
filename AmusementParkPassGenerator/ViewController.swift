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
    @IBOutlet weak var r2b5: UIButton!
    
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
    
    var textFieldArray = [UITextField]()
    
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
        
        secondRowButtonsArray = [r2b1, r2b2, r2b3, r2b4, r2b5]
        textFieldArray = [DOBTextField, SSNTextField, projectNumberTextField, firstNameTextField, lastNameTextField, companyTextField, streetAddressTextField, cityTextField, stateTextField, zipCodeTextField]
        
        self.initialViewSetup()
    }
    
    func initialViewSetup() {
        
        currentlySelectedTypeButton = guestButton
        currentlySelectedTypeButton.backgroundColor = buttonPressedPurple
        
        setSecondRowButtons(guestButton)
        
        enableTextFields(false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Select entrant type and subtype
    
    @IBAction func entrantTypeSelected(sender: UIButton) {
        
        switch sender.tag {
        
        case 1:
            switchHighlight(guestButton)
            setSecondRowButtons(guestButton)
            enableTextFields(false)
            deselectSubtype()
    
        case 2:
            switchHighlight(employeeButton)
            setSecondRowButtons(employeeButton)
            enableTextFields(false)
            deselectSubtype()
        
        case 3:
            switchHighlight(contractorButton)
            setSecondRowButtons(contractorButton)
            enableTextFields(true)
            companyTextField.enabled = false
            companyTextField.backgroundColor = UIColor.clearColor()
            SSNTextField.enabled = false
            SSNTextField.backgroundColor = UIColor.clearColor()
        
        case 4:
            switchHighlight(vendorButton)
            setSecondRowButtons(vendorButton)
            enableTextFields(true)
            projectNumberTextField.enabled = false
            projectNumberTextField.backgroundColor = UIColor.clearColor()
            SSNTextField.enabled = false
            SSNTextField.backgroundColor = UIColor.clearColor()
        
        default: break
        
        }
    }
    
    @IBAction func entrantSubtypeSelected(sender: UIButton) {
        
        if let title = sender.currentTitle {
            
            switch title {
        
            // Guest
            case GuestType.freeChild.rawValue :
                highlightSubtype(r2b1)
                childSettings()
          
            case GuestType.Classic.rawValue :
                highlightSubtype(r2b2)
                enableTextFields(false)
        
            
            case GuestType.seniorGuest.rawValue :
                highlightSubtype(r2b3)
                seniorSettings()
            
            
            case GuestType.seasonPass.rawValue:
                highlightSubtype(r2b4)
                seasonPassSettings()
           
        
            case GuestType.VIP.rawValue:
                highlightSubtype(r2b5)
                enableTextFields(false)
            
            // Employee
            case EmployeeType.FoodServices.rawValue:
                highlightSubtype(r2b1)
                employeeSettings()
            
            case EmployeeType.RideServices.rawValue:
                highlightSubtype(r2b2)
                employeeSettings()
        
            case EmployeeType.Maintenance.rawValue:
                highlightSubtype(r2b3)
                employeeSettings()

            case EmployeeType.Manager.rawValue:
                highlightSubtype(r2b4)
                employeeSettings()
            
            default: break
            
            }
        }
    }
    
    func employeeSettings() {
        enableTextFields(true)
        
        DOBTextField.enabled = true
        SSNTextField.enabled = true
        
        projectNumberTextField.enabled = false
        projectNumberTextField.backgroundColor = UIColor.clearColor()
        
        firstNameTextField.enabled = true
        lastNameTextField.enabled = true
        
        companyTextField.enabled = false
        companyTextField.backgroundColor = UIColor.clearColor()
        
        streetAddressTextField.enabled = true
        cityTextField.enabled = true
        stateTextField.enabled = true
        zipCodeTextField.enabled = true
        
    }
    
    func seasonPassSettings() {
        enableTextFields(true)
        
        DOBTextField.enabled = false
        DOBTextField.backgroundColor = UIColor.clearColor()
        
        SSNTextField.enabled = false
        SSNTextField.backgroundColor = UIColor.clearColor()
        
        projectNumberTextField.enabled = false
        projectNumberTextField.backgroundColor = UIColor.clearColor()
        
        firstNameTextField.enabled = true
        lastNameTextField.enabled = true
        
        companyTextField.enabled = false
        companyTextField.backgroundColor = UIColor.clearColor()
        
        streetAddressTextField.enabled = true
        cityTextField.enabled = true
        stateTextField.enabled = true
        zipCodeTextField.enabled = true
        
    }
    
    func seniorSettings() {
        enableTextFields(true)
        
        DOBTextField.enabled = true
        
        SSNTextField.enabled = false
        SSNTextField.backgroundColor = UIColor.clearColor()
        
        projectNumberTextField.enabled = false
        projectNumberTextField.backgroundColor = UIColor.clearColor()
        
        firstNameTextField.enabled = true
        lastNameTextField.enabled = true
        
        companyTextField.enabled = false
        companyTextField.backgroundColor = UIColor.clearColor()
        
        streetAddressTextField.enabled = false
        streetAddressTextField.backgroundColor = UIColor.clearColor()
        
        cityTextField.enabled = false
        cityTextField.backgroundColor = UIColor.clearColor()
        
        stateTextField.enabled = false
        stateTextField.backgroundColor = UIColor.clearColor()
        
        zipCodeTextField.enabled = false
        zipCodeTextField.backgroundColor = UIColor.clearColor()
        
    }
    
    func childSettings() {
        enableTextFields(true)
        for textField in textFieldArray {
            if textField != DOBTextField {
                textField.enabled = false
                textField.backgroundColor = UIColor.clearColor()
            } else {
                textField.enabled = true
            }
        }
    }
    
    func enableTextFields(isEnabled: Bool) {
        for textField in textFieldArray {
            if isEnabled == false {
                textField.enabled = false
                textField.backgroundColor = UIColor.clearColor()
            } else {
                textField.enabled = true
                textField.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    func deselectSubtype() {
        for button in secondRowButtonsArray {
            if button.selected == true {
                button.selected = false
            }
        }
    }
    
    // Button helper methods
    
    func highlightSubtype(button: UIButton) {
        previouslySelectedSubType = currentlySelectedSubType
        previouslySelectedSubType.selected = false
        currentlySelectedSubType = button
        currentlySelectedSubType.selected = true
    }
    
    func setSecondRowButtons(button: UIButton) {
        switch button {
            case guestButton :
                r2b1.setTitle(GuestType.freeChild.rawValue, forState: .Normal)
                r2b2.setTitle(GuestType.Classic.rawValue, forState: .Normal)
                r2b3.setTitle(GuestType.seniorGuest.rawValue, forState: .Normal)
                r2b4.setTitle(GuestType.seasonPass.rawValue, forState: .Normal)
                r2b5.setTitle(GuestType.VIP.rawValue, forState: .Normal)
                
                r2b5.hidden = false
                secondRowButtonsStackView.addArrangedSubview(r2b5)
                secondRowButtonsStackView.hidden = false
            
            case employeeButton :
                r2b1.setTitle(EmployeeType.FoodServices.rawValue, forState: .Normal)
                r2b2.setTitle(EmployeeType.RideServices.rawValue, forState: .Normal)
                r2b3.setTitle(EmployeeType.Maintenance.rawValue, forState: .Normal)
                r2b4.setTitle(EmployeeType.Manager.rawValue, forState: .Normal)
                
                r2b5.hidden = true
                secondRowButtonsStackView.removeArrangedSubview(r2b5)
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

