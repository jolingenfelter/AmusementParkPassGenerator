//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Joanna Lingenfelter on 8/16/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    var today: String = ""
    
    // Picker Views
    var companiesArray = [String]()
    var projectNumbersArray = [String]()
    var companyPicker = UIPickerView()
    var projectNumberPicker = UIPickerView()
    
    // Instance of Person created from input data
    
    var entrant = Person()
    var pass: PassGenerator
    var entrantTypeString = String()
    
    // Button Highlighting Variables
    
    @IBOutlet weak var secondRowButtonsStackView: UIStackView!
    
    var currentlySelectedTypeButton = UIButton()
    var previouslySelectedTypeButton = UIButton()
    
    var selectedType: EntrantType
    
    var buttonPressedPurple = UIColor()
    var buttonNormalStatePurple = UIColor()
    
    var secondRowButtonsArray = [UIButton]()
    
    var currentlySelectedSubTypeButton = UIButton()
    var previouslySelectedSubTypeButton = UIButton()
    
    var selectedSubType: String
    
    var person: Person {
        
        willSet {
            
            set(textField: companyTextField, enabled: false)
            set(textField: projectNumberTextField, enabled: false)
            
            let newPerson = newValue
            
            if newPerson.DOB == nil {
                set(textField: DOBTextField, enabled: false)
            } else {
                set(textField: DOBTextField, enabled: true)
            }
            
            if newPerson.SSN == nil {
                set(textField: SSNTextField, enabled: false)
            } else {
                set(textField: SSNTextField, enabled: true)
            }
            
            if newPerson.firstName == nil {
                set(textField: firstNameTextField, enabled: false)
            } else {
                set(textField: firstNameTextField, enabled: true)
            }
            
            if newPerson.lastName == nil {
                set(textField: lastNameTextField, enabled: false)
            } else {
                set(textField: lastNameTextField, enabled: true)
            }
            
            if newPerson.address == nil {
                set(textField: streetAddressTextField, enabled: false)
            } else {
                set(textField: streetAddressTextField, enabled: true)
            }
            
            if newPerson.city == nil {
                set(textField: cityTextField, enabled: false)
            } else {
                set(textField: cityTextField, enabled: true)
            }
            
            if newPerson.state == nil {
                set(textField: stateTextField, enabled: false)
            } else {
                set(textField: stateTextField, enabled: true)
            }
            
            if newPerson.zipCode == nil {
                set(textField: zipCodeTextField, enabled: false)
            } else {
                set(textField: zipCodeTextField, enabled: true)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        person = GuestType.classic.testCase
        self.pass = PassGenerator(entrant: person, entrantType: GuestType.classic)
        selectedType = GuestType.entrantType
        selectedSubType = GuestType.classic.rawValue
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colors to highlight and unhighlight type
        buttonPressedPurple = UIColor(red: 151/255.0, green: 114/255.0, blue: 194/255.0, alpha: 1)
        buttonNormalStatePurple = UIColor(red: 129/255.0, green: 98/255.0, blue: 164/255.0, alpha: 1.0)
        
        // Arrays for convenience later
        secondRowButtonsArray = [r2b1, r2b2, r2b3, r2b4, r2b5]
        textFieldArray = [DOBTextField, SSNTextField, projectNumberTextField, firstNameTextField, lastNameTextField, companyTextField, streetAddressTextField, cityTextField, stateTextField, zipCodeTextField]
        
        // Round Buttons
        generatePassButton.layer.cornerRadius = 5
        generatePassButton.layer.masksToBounds = true
        
        populateDataButton.layer.cornerRadius = 5
        populateDataButton.layer.masksToBounds = true
        
        // Initial Setup
        self.initialViewSetup()
        self.setupPickerViews()
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
    
    @IBAction func entrantTypeSelected(_ sender: UIButton) {
        
        switch sender.tag {
        
        case 1:
            switchHighlight(guestButton)
            setSecondRowButtons(guestButton)
            enableTextFields(false)
            selectedType = EntrantType.guest
            deselectSubtype()
    
        case 2:
            switchHighlight(employeeButton)
            setSecondRowButtons(employeeButton)
            enableTextFields(false)
            selectedType = EntrantType.employee
            deselectSubtype()
        
        case 3:
            switchHighlight(contractorButton)
            setSecondRowButtons(contractorButton)
            selectedType = EntrantType.contractEmployee
            person = ContractEmployeeType.testCase
            set(textField: projectNumberTextField, enabled: true)
        
        case 4:
            switchHighlight(vendorButton)
            setSecondRowButtons(vendorButton)
            selectedType = EntrantType.vendor
            person = VendorType.testCase
            set(textField: companyTextField, enabled: true)
        
        default: break
        
        }
    }
    
    @IBAction func entrantSubtypeSelected(_ sender: UIButton) {
        
        if let title = sender.currentTitle {
            
            switch title {
        
            // Guest
            case GuestType.freeChild.rawValue :
                highlightSubtype(r2b1)
                selectedSubType = GuestType.freeChild.rawValue
                person = GuestType.freeChild.testCase
          
            case GuestType.classic.rawValue :
                highlightSubtype(r2b2)
                selectedSubType = GuestType.classic.rawValue
                person = GuestType.classic.testCase
        
            
            case GuestType.seniorGuest.rawValue :
                highlightSubtype(r2b3)
                selectedSubType = GuestType.seniorGuest.rawValue
                person = GuestType.seniorGuest.testCase
            
            case GuestType.seasonPass.rawValue:
                highlightSubtype(r2b4)
                selectedSubType = GuestType.seasonPass.rawValue
                person = GuestType.seasonPass.testCase
           
        
            case GuestType.VIP.rawValue:
                highlightSubtype(r2b5)
                selectedSubType = GuestType.VIP.rawValue
                person = GuestType.VIP.testCase
            
            // Employee
            case EmployeeType.foodServices.rawValue:
                highlightSubtype(r2b1)
                selectedSubType = EmployeeType.foodServices.rawValue
                person = EmployeeType.testCase
            
            case EmployeeType.rideServices.rawValue:
                highlightSubtype(r2b2)
                selectedSubType = EmployeeType.rideServices.rawValue
                person = EmployeeType.testCase
        
            case EmployeeType.maintenance.rawValue:
                highlightSubtype(r2b3)
                selectedSubType = EmployeeType.maintenance.rawValue
                person = EmployeeType.testCase

            case EmployeeType.manager.rawValue:
                highlightSubtype(r2b4)
                selectedSubType = EmployeeType.manager.rawValue
                person = EmployeeType.testCase
            
            default: break
            
            }
        }
    }
    
      func enableTextFields(_ isEnabled: Bool) {
        for textField in textFieldArray {
            if isEnabled == false {
                textField.isEnabled = false
                textField.backgroundColor = UIColor.clear
                textField.text = ""
            } else {
                textField.isEnabled = true
                textField.backgroundColor = UIColor.white
            }
        }
    }
    
    func set(textField: UITextField, enabled: Bool) {
        
        textField.isEnabled = enabled
        
        if textField.isEnabled {
            textField.backgroundColor = .white
        } else {
            textField.backgroundColor = .clear
            textField.text = ""
        }
        
    }

    
    // Button helper methods
    
    func highlightSubtype(_ button: UIButton) {
        previouslySelectedSubTypeButton = currentlySelectedSubTypeButton
        previouslySelectedSubTypeButton.isSelected = false
        currentlySelectedSubTypeButton = button
        currentlySelectedSubTypeButton.isSelected = true
    }
    
    func setSecondRowButtons(_ button: UIButton) {
        switch button {
            case guestButton :
                r2b1.setTitle(GuestType.freeChild.rawValue, for: UIControlState())
                r2b2.setTitle(GuestType.classic.rawValue, for: UIControlState())
                r2b3.setTitle(GuestType.seniorGuest.rawValue, for: UIControlState())
                r2b4.setTitle(GuestType.seasonPass.rawValue, for: UIControlState())
                r2b5.setTitle(GuestType.VIP.rawValue, for: UIControlState())
                
                r2b5.isHidden = false
                secondRowButtonsStackView.addArrangedSubview(r2b5)
                secondRowButtonsStackView.isHidden = false
            
            case employeeButton :
                r2b1.setTitle(EmployeeType.foodServices.rawValue, for: UIControlState())
                r2b2.setTitle(EmployeeType.rideServices.rawValue, for: UIControlState())
                r2b3.setTitle(EmployeeType.maintenance.rawValue, for: UIControlState())
                r2b4.setTitle(EmployeeType.manager.rawValue, for: UIControlState())
                
                r2b5.isHidden = true
                secondRowButtonsStackView.removeArrangedSubview(r2b5)
                secondRowButtonsStackView.isHidden = false
            
            case contractorButton :
            
                secondRowButtonsStackView.isHidden = true
            
            case vendorButton :
            
                secondRowButtonsStackView.isHidden = true
        
            default: break
        }
    }
    
    
    func switchHighlight(_ button: UIButton) {
        previouslySelectedTypeButton = currentlySelectedTypeButton
        previouslySelectedTypeButton.backgroundColor = buttonNormalStatePurple
        currentlySelectedTypeButton = button
        button.backgroundColor = buttonPressedPurple
    }
    
    func deselectSubtype() {
        for button in secondRowButtonsArray {
            if button.isSelected == true {
                button.isSelected = false
            }
        }
    }
    
    // Generate Pass
    @IBAction func GeneratePass(_ sender: AnyObject) {
        
        today = dateFormatter.string(from: Date())
        
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let address = streetAddressTextField.text
        let city = cityTextField.text
        let state = stateTextField.text
        let zipCode = zipCodeTextField.text
        let SSN = SSNTextField.text
        let DOB = DOBTextField.text
        
        entrant = Person(firstName: firstName, lastName: lastName, address: address, city: city, state: state, zipCode: Int(zipCode!), SSN: Int(SSN!), DOB: DOB, dateOfVisit: today)
        
        
        if selectedType == EntrantType.guest {
            
            guard let guestType = GuestType(rawValue: selectedSubType) else {
                displayAlertWithTitle("Error", andMessage: "Please choose a subtype")
                return
            }
            
            entrantTypeString = String(guestType.rawValue)
            pass = PassGenerator(entrant: entrant, entrantType: guestType)
            tryPass(pass)
            
        }
        
        
        if selectedType == EntrantType.employee {
            
            guard let employeeType = EmployeeType(rawValue: selectedSubType) else {
                displayAlertWithTitle("Error", andMessage: "Please choose a subtype")
                return
            }
            
            entrantTypeString = String(employeeType.rawValue)
            pass = PassGenerator(entrant: entrant, entrantType: employeeType)
            tryPass(pass)
        }
        
        if selectedType == EntrantType.vendor {

            guard let company = companyTextField.text, let vendorType = VendorType(rawValue: company) else {
                displayAlertWithTitle("Error", andMessage: "Invalid Company")
                return
            }
            
            entrantTypeString = String(vendorType.rawValue)
            pass = PassGenerator(entrant: entrant, entrantType: vendorType)
            tryPass(pass)

        }
        
        if selectedType == EntrantType.contractEmployee {
            
            guard let projectNumber = projectNumberTextField.text, let contractEmployeeType = ContractEmployeeType(rawValue: projectNumber) else {
                displayAlertWithTitle("Error", andMessage: "Invalid Project Number")
                return
            }
            
            entrantTypeString = String(contractEmployeeType.rawValue)
            pass = PassGenerator(entrant: entrant, entrantType: contractEmployeeType)
            tryPass(pass)
          
        }
        
    }
    
    // try pass
    
    func tryPass(_ pass: PassGenerator) {
        
        do {
            
            try pass.checkForCorrectData()
            displayPassVC()
            
        } catch PersonalInformationError.InvalidDOB {
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidDOB.rawValue)
        } catch PersonalInformationError.InvalidSSN {
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidSSN.rawValue)
        } catch PersonalInformationError.InvalidName {
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidName.rawValue)
        } catch PersonalInformationError.InvalidAddress {
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidAddress.rawValue)
        } catch PersonalInformationError.InvalidCity {
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidCity.rawValue)
        } catch PersonalInformationError.InvalidState {
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidCity.rawValue)
        } catch PersonalInformationError.InvalidZipCode{
            displayAlertWithTitle("Error", andMessage: PersonalInformationError.InvalidZipCode.rawValue)
        } catch let error {
            displayAlertWithTitle("Error", andMessage: "\(error)")
        }
        
            

    }
    
    @IBAction func PopulateData(_ sender: AnyObject) {
        
        populateData()
        
    }
    
    
    // Pass Generated VC
    
    func displayPassVC() {
        let passVC = self.storyboard?.instantiateViewController(withIdentifier: "PassViewController") as! PassViewController
        passVC.date = today
        passVC.passType = entrantTypeString
        passVC.generatedPass = pass
        
        self.present(passVC, animated: true, completion: nil)
    }

}

// MARK: - PickerView DataSouce and Delegate

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPickerViews() {
        companiesArray = [VendorType.ACME.rawValue, VendorType.Orkin.rawValue, VendorType.Fedex.rawValue, VendorType.NWElectrical.rawValue]
        projectNumbersArray = [String(ContractEmployeeType.a.rawValue), String(ContractEmployeeType.b.rawValue), String(ContractEmployeeType.c.rawValue), String(ContractEmployeeType.d.rawValue), String(ContractEmployeeType.e.rawValue)]
        
        companyPicker.delegate = self
        companyTextField.inputView = companyPicker
        
        projectNumberPicker.delegate = self
        projectNumberTextField.inputView = projectNumberPicker
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var numberOfrows = 0
        
        if pickerView == companyPicker {
            numberOfrows = companiesArray.count
        } else if pickerView == projectNumberPicker {
            numberOfrows = projectNumbersArray.count
        }
        
        return numberOfrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var title = String()
        
        if pickerView == companyPicker {
            title = companiesArray[row]
        } else if pickerView == projectNumberPicker {
            title = projectNumbersArray[row]
        }
        
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == companyPicker {
            companyTextField.text = companiesArray[row]
        } else if pickerView == projectNumberPicker {
            projectNumberTextField.text = projectNumbersArray[row]
        }
    }
    
}

// MARK: - Data Population

extension ViewController {
    
    func populateData() {
        if selectedType == GuestType.entrantType {
            
            if selectedSubType == GuestType.freeChild.rawValue {
                DOBTextField.text = GuestType.freeChild.testCase.DOB
            }
            
            if selectedSubType == GuestType.seniorGuest.rawValue {
                DOBTextField.text = GuestType.seniorGuest.testCase.DOB
            }
            
            if selectedSubType == GuestType.seasonPass.rawValue {
                
                firstNameTextField.text = GuestType.seasonPass.testCase.firstName
                lastNameTextField.text = GuestType.seasonPass.testCase.lastName
                
                streetAddressTextField.text = GuestType.seasonPass.testCase.address
                cityTextField.text = GuestType.seasonPass.testCase.city
                stateTextField.text = GuestType.seasonPass.testCase.state
                zipCodeTextField.text = String(describing: GuestType.seasonPass.testCase.zipCode!)
                
            }
            
        }
        
        if selectedType == EmployeeType.entrantType {
            
            DOBTextField.text = EmployeeType.testCase.DOB
            SSNTextField.text = String(describing: EmployeeType.testCase.SSN!)
            
            firstNameTextField.text = EmployeeType.testCase.firstName
            lastNameTextField.text = EmployeeType.testCase.lastName
            
            streetAddressTextField.text = EmployeeType.testCase.address
            cityTextField.text = EmployeeType.testCase.city
            stateTextField.text = EmployeeType.testCase.state
            zipCodeTextField.text = String(describing: EmployeeType.testCase.zipCode!)
            
        }
        
        if selectedType == VendorType.entrantType {
            
            DOBTextField.text = VendorType.testCase.DOB
            
            firstNameTextField.text = VendorType.testCase.firstName
            lastNameTextField.text = VendorType.testCase.lastName
            
            companyTextField.text = (companiesArray.shuffle)[0]
            
            streetAddressTextField.text = VendorType.testCase.address
            cityTextField.text = VendorType.testCase.city
            stateTextField.text = VendorType.testCase.state
            zipCodeTextField.text = String(describing: VendorType.testCase.zipCode!)
        }
        
        if selectedType == ContractEmployeeType.entrantType {
            DOBTextField.text = ContractEmployeeType.testCase.DOB
            SSNTextField.text = String(describing: ContractEmployeeType.testCase.SSN!)
            
            firstNameTextField.text = ContractEmployeeType.testCase.firstName
            lastNameTextField.text = ContractEmployeeType.testCase.lastName
            
            projectNumberTextField.text = (projectNumbersArray.shuffle)[0]
            
            streetAddressTextField.text = ContractEmployeeType.testCase.address
            cityTextField.text = ContractEmployeeType.testCase.city
            stateTextField.text = ContractEmployeeType.testCase.state
            zipCodeTextField.text = String(describing: ContractEmployeeType.testCase.zipCode!)
        }

    }
}

