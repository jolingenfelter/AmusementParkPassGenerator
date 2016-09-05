//
//  PassViewController.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/4/16.
//  Copyright © 2016 JoLingenfelter. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        
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

}
