//
//  MenuViewController.swift
//  Dee Fu Fend
//
//  Created by Caleb Lindsey on 7/13/16.
//  Copyright © 2016 KlubCo. All rights reserved.
//

import Foundation
import SpriteKit
import GoogleMobileAds
import AVFoundation



class MenuViewController : UIViewController, GADInterstitialDelegate {
    
    
    @IBOutlet weak var comboNum: UILabel!
    @IBOutlet weak var menuBannerAd: GADBannerView!
    
    
    
    
    //Public
    struct menuPublicVariables {
        static var gameMode = String()
        static var themePlayer : AVAudioPlayer = AVAudioPlayer()
        static var themeIsPlaying = false
        static var themeInitialized = false
        static var firstTime = true
    }
    
    //Declare Variables
    var interstitialAd : GADInterstitial!
    @IBOutlet weak var classicButton: UIButton!
    @IBOutlet weak var challengeButton: UIButton!
    var adTimer = Timer()
    var showAd = false
    var classicHighScore = Int()
    var challengeHighScore = Int()
    var InterstitialTime = Timer()
    var authorized = Bool()
    var screenTouched = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classicButton.isUserInteractionEnabled = false
        challengeButton.isUserInteractionEnabled = false
        
        if UserDefaults.standard.value(forKey: "authorized") != nil {
            authorized = UserDefaults.standard.value(forKey: "authorized") as! Bool
        }
        if authorized == true {
            HighScoreView().authPlayer()
        }
        
        if UserDefaults.standard.value(forKey: "characterSkin") == nil {
            UserDefaults.standard.set("DeeFu", forKey: "characterSkin")
        } else {
            print("")
        }
        
        //Code needed for interstitial Ad
        interstitialAd = creatAndLoadInterstitial()
        
        //Setup HighScore
        let currentHighScore = UserDefaults.standard
        
        if currentHighScore.value(forKey: "ClassicHighScore") != nil {
            
            classicHighScore = currentHighScore.value(forKey: "ClassicHighScore") as! NSInteger
            menuPublicVariables.firstTime = false
            
        } else {
            print("")
        }
        
        if currentHighScore.value(forKey: "ChallengeHighScore") != nil {
            
            challengeHighScore = currentHighScore.value(forKey: "ChallengeHighScore") as! NSInteger
            comboNum.text = "\(challengeHighScore)"
            menuPublicVariables.firstTime = false
            
        } else {
            print("")
            comboNum.text = "0"
        }
        
        //Code needed for banner Ad
        self.menuBannerAd.adUnitID = "ca-app-pub-3929537682716172/7762791843"
        self.menuBannerAd.rootViewController = self
        let request : GADRequest = GADRequest()
        self.menuBannerAd.load(request)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        showAd = GameViewController.gameViewControllerPublicVariables.transitioningToMain
        
        let currentHighScore = UserDefaults.standard
        if currentHighScore.value(forKey: "ChallengeHighScore") != nil {
            
            challengeHighScore = currentHighScore.value(forKey: "ChallengeHighScore") as! NSInteger
            comboNum.text = "\(challengeHighScore)"
            
        } else {
            print("")
            comboNum.text = "0"
        }
        
        //Play Theme Music
        let audioPath = Bundle.main.path(forResource: "themeMusic", ofType: "mp3")!
        let url = URL(fileURLWithPath: audioPath)
        
        if menuPublicVariables.themeInitialized == false {
            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                menuPublicVariables.themePlayer = sound
                menuPublicVariables.themePlayer.volume = 0.6
                menuPublicVariables.themePlayer.numberOfLoops = -1
                menuPublicVariables.themeIsPlaying = true
                sound.play()
                menuPublicVariables.themeInitialized = true
                
            } catch {
                print("couldn't load file ")
                
            }
        }
        
        if showAd == true {
            presentInterstitial()
            GameViewController.gameViewControllerPublicVariables.transitioningToMain = false
            
        } 
        
        
        if currentHighScore.value(forKey: "ClassicHighScore") != nil {
            
            classicHighScore = currentHighScore.value(forKey: "ClassicHighScore") as! NSInteger
            
        } else {
            print("")
        }
        
        if currentHighScore.value(forKey: "ChallengeHighScore") != nil {
            
            challengeHighScore = currentHighScore.value(forKey: "ChallengeHighScore") as! NSInteger
            
        } else {
            print("")
        }
        
        showDirections()
        
        
        
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    @IBAction func gameModeChosen(_ sender: AnyObject) {
        
        if sender.tag == 0 {
            menuPublicVariables.gameMode = "classic"
        }
        else if sender.tag == 1 {
            menuPublicVariables.gameMode = "challenge"
        }
        
        
        
    }
    
    @IBAction func highScoreButton(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func unwindToMenu(_ segue: UIStoryboardSegue) {
        
    }
    
    func creatAndLoadInterstitial() -> GADInterstitial {
        
        let ad = GADInterstitial()
        ad.setAdUnitID("ca-app-pub-3929537682716172/8076006240")
        let request2 = GADRequest()
        ad.load(request2)
        return ad
    }
    
    func presentInterstitial() {
        
        menuPublicVariables.themePlayer.volume = 0.0
        InterstitialTime = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(removeAd), userInfo: nil, repeats: false)
        
        if interstitialAd != nil {
            if (interstitialAd.isReady) {
                interstitialAd.present(fromRootViewController: self)
                interstitialAd = creatAndLoadInterstitial()
            } else {
                print("Ad wasn't ready...")
            }
        } else {
            print("Ad must have been nil")
        }
    }
    
    
    func showDirections() {
        
        //Display Directions View
        if menuPublicVariables.firstTime == true {
            
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "directionsView")
            self.show(vc as! UIViewController, sender: vc)
            menuPublicVariables.firstTime = false
            
        }
        
    }
    
    func removeAd() {
        
        menuPublicVariables.themePlayer.volume = 0.6
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if screenTouched == false && menuPublicVariables.firstTime == false {
            presentInterstitial()
            classicButton.isUserInteractionEnabled = true
            challengeButton.isUserInteractionEnabled = true
            screenTouched = true
        }
        
    }
    
}
    
   














