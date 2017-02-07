//
//  CharacterSelectViewController.swift
//  Dee Fu Fend
//
//  Created by Caleb Lindsey on 7/29/16.
//  Copyright © 2016 KlubCo. All rights reserved.
//

import Foundation
import UIKit

class CharacterSelectView : UIViewController {
    
    var classHighScore : Int = 0
    var userSkinChoice = String()
    var buttonPressed = false
    @IBOutlet weak var DeeFuButton: UIButton!
    @IBOutlet weak var rippedDeeFuButton: UIButton!
    @IBOutlet weak var deeFuNinjaButton: UIButton!
    
    @IBOutlet weak var deeFuLabel: UILabel!
    @IBOutlet weak var rippedDeeFuLabel: UILabel!
    @IBOutlet weak var deeFuNinjaLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DeeFuButton.isUserInteractionEnabled = true
        rippedDeeFuButton.isUserInteractionEnabled = false
        deeFuNinjaButton.isUserInteractionEnabled = false
        
        let currentHighScore = UserDefaults.standard
        
        if currentHighScore.value(forKey: "ClassicHighScore") != nil {
            classHighScore = currentHighScore.value(forKey: "ClassicHighScore") as! NSInteger
        } else {
            classHighScore = 0
        }
        
        if classHighScore >= 50000 {
            rippedDeeFuButton.isUserInteractionEnabled = true
            rippedDeeFuButton.setBackgroundImage(UIImage(named: "rippedDeeFuUnlocked"), for: UIControlState())
            
            rippedDeeFuLabel.text = "Ripped"
            
        }
        if classHighScore >= 75000 {
            deeFuNinjaButton.isUserInteractionEnabled = true
            deeFuNinjaButton.setBackgroundImage(UIImage(named: "DeeFuNinjaUnlockedButton"), for: UIControlState())
            
            deeFuNinjaLabel.text = "Ninja"
            
        }
        
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        if sender.tag == 0 {
            
            userSkinChoice = "DeeFu"
            buttonPressed = true
            deeFuLabel.textColor = UIColor.yellow
            rippedDeeFuLabel.textColor = UIColor.white
            deeFuNinjaLabel.textColor = UIColor.white
            
            
        }
        if sender.tag == 1 {
            
            userSkinChoice = "RippedDeeFu"
            buttonPressed = true
            deeFuLabel.textColor = UIColor.white
            rippedDeeFuLabel.textColor = UIColor.yellow
            deeFuNinjaLabel.textColor = UIColor.white
            
        }
        if sender.tag == 2 {
            
            userSkinChoice = "DeeFuNinja"
            buttonPressed = true
            deeFuLabel.textColor = UIColor.white
            rippedDeeFuLabel.textColor = UIColor.white
            deeFuNinjaLabel.textColor = UIColor.yellow
            
        }
        
    }
    
    @IBAction func checkButtonPressed(_ sender: AnyObject) {
        
        if buttonPressed == true {
            UserDefaults.standard.set(userSkinChoice, forKey: "characterSkin")
            
        }
        print(UserDefaults.standard.value(forKey: "characterSkin")!)
    }
}
