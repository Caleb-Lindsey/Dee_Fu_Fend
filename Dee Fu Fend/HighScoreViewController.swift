//
//  HighScoreViewController.swift
//  Dee Fu Fend
//
//  Created by Caleb Lindsey on 7/16/16.
//  Copyright © 2016 KlubCo. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import GameKit

class HighScoreView : UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet weak var classicTropDesc: UILabel!
    @IBOutlet weak var challengeTropDesc: UILabel!
    @IBOutlet weak var challengeTrophy: UIImageView!
    @IBOutlet weak var classicTrophy: UIImageView!
    @IBOutlet weak var highScoreBannerAd: GADBannerView!
    @IBOutlet weak var classicHighScore: UILabel!
    @IBOutlet weak var challengeHighScore: UILabel!
    @IBOutlet weak var imageSaved: UIImageView!
    @IBOutlet weak var shareButtonOutlet: UIButton!
    
    
    var classHighScore = Int()
    var challHighScore = Int()
    var formatter = NumberFormatter()
    var displayClassicScore = String()
    var displayChallengeScore = String()
    let gcvc = GKGameCenterViewController()
    var alpha : CGFloat = 0.9
    var alphaTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authPlayer()
        
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        
        let currentHighScore = UserDefaults.standard
        
        if currentHighScore.value(forKey: "ClassicHighScore") != nil {
            
            classHighScore = currentHighScore.value(forKey: "ClassicHighScore") as! NSInteger
            
        } else {
            classHighScore = 0
        }
        
        if currentHighScore.value(forKey: "ChallengeHighScore") != nil {
            
            challHighScore = currentHighScore.value(forKey: "ChallengeHighScore") as! NSInteger
            
        } else {
            challHighScore = 0
        }
        
        if classHighScore != 0 {
            displayClassicScore = formatter.string(from: classHighScore as NSNumber)!
        } else {
            displayClassicScore = "0"
        }
        
        if challHighScore != 0 {
            displayChallengeScore = formatter.string(from: challHighScore as NSNumber)!
        } else {
            displayChallengeScore = "0"
        }
        
        classicHighScore.text = "\(displayClassicScore)"
        challengeHighScore.text = "\(displayChallengeScore)"
        
        
        //Code needed for banner Ad
        self.highScoreBannerAd.adUnitID = "ca-app-pub-3929537682716172/9239525040"
        self.highScoreBannerAd.rootViewController = self
        let request : GADRequest = GADRequest()
        self.highScoreBannerAd.load(request)
        
        
        //Add appropriate trophy
        if classHighScore >= 100000 {
            classicTrophy.image = UIImage(named: "goldTrophy")
            classicTropDesc.text = "3/3 trophies unlocked"
        } else if classHighScore >= 50000 {
            classicTrophy.image = UIImage(named: "silverTrophy")
            classicTropDesc.text = "2/3 trophies unlocked"
        } else if classHighScore >= 25000 {
            classicTrophy.image = UIImage(named: "bronzeTrophy")
            classicTropDesc.text = "1/3 trophies unlocked"
        } else if classHighScore < 25000 {
            classicTrophy.image = UIImage(named: "emptyTrophy")
            classicTropDesc.text = "0/3 trophies unlocked"
        }
        
        
        if challHighScore >= 100 {
            challengeTrophy.image = UIImage(named: "goldTrophy")
            challengeTropDesc.text = "3/3 trophies unlocked"
        } else if challHighScore >= 50 {
            challengeTrophy.image = UIImage(named: "silverTrophy")
            challengeTropDesc.text = "2/3 trophies unlocked"
        } else if challHighScore >= 25 {
            challengeTrophy.image = UIImage(named: "bronzeTrophy")
            challengeTropDesc.text = "1/3 trophies unlocked"
        } else if challHighScore < 25 {
            challengeTrophy.image = UIImage(named: "emptyTrophy")
            challengeTropDesc.text = "0/3 trophies unlocked"
        }
        
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        
        MenuViewController.menuPublicVariables.themeIsPlaying = true
    }
    
    func authPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            } else {
                print(GKLocalPlayer.localPlayer().isAuthenticated)
                self.saveHighScore(self.classHighScore)
            }
        }
        
        
    }
    
    func saveHighScore(_ number: Int) {
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "DeeFuFendLeaderboard")
            scoreReporter.value = Int64(number)
            let scoreArray : [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
            print("savedHighScore")
            UserDefaults.standard.set(true, forKey: "authorized")
        } else {
            print("Couldnt save highscore")
            UserDefaults.standard.set(false, forKey: "authorized")
        }
        
    }
    
    func showLeaderBoard() {
        
        let viewController = self.view.window?.rootViewController
        gcvc.gameCenterDelegate = self
        viewController?.present(gcvc, animated: true, completion: nil)
        gcvc.loadView()
        print("showed leaderboard")
        
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        print("leaderboard dismissed")
        
    }

    @IBAction func shareButton(_ sender: AnyObject) {
        screenShotMethod()
    }
    
    func screenShotMethod() {
        
        shareButtonOutlet.isUserInteractionEnabled = false
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        imageSaved.image = UIImage(named: "imageSaved")
        alphaTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fadeOutImage), userInfo: nil, repeats: true)
        
        
        
    }
    
    func fadeOutImage() {
        
        imageSaved.alpha = alpha
        alpha -= 0.05
        
        if alpha <= 0.0 {
            alphaTimer.invalidate()
            shareButtonOutlet.isUserInteractionEnabled = true
            imageSaved.image = nil
            alpha = 0.9
            imageSaved.alpha = 1
        }
        
    }
    
    
}











