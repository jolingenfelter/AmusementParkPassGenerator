//
//  SoundCoordinator.swift
//  AmusementParkPassGenerator.xcodeproject
//
//  Created by Joanna Lingenfelter on 9/10/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundCoordinator {
    
    private var accessGrantedSound: SystemSoundID = 0
    private var accessDeniedSound: SystemSoundID = 0
    
    init() {
        loadAccessDeniedSound()
        loadAccessGrantedSound()
    }
    
   private func loadAccessGrantedSound() {
        let pathToFile = Bundle.main.path(forResource: "AccessGranted", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &accessGrantedSound)
    }
    
    private func loadAccessDeniedSound() {
        let pathToFile = Bundle.main.path(forResource: "AccessDenied", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &accessDeniedSound)
    }
    
    func playAccessGrantedSound() {
        AudioServicesPlaySystemSound(accessGrantedSound)
    }
    
    func playAccessDeniedSound() {
        AudioServicesPlaySystemSound(accessDeniedSound)
    }
    
}
