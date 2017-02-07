//
//  GameViewController.swift
//  Dee Fu Fend
//
//  Created by Caleb Lindsey on 6/21/16.
//  Copyright (c) 2016 KlubCo. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController : UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    //Public Variables
    struct gameViewControllerPublicVariables {
        static var menu = false
        static var transitioningToMain = Bool()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
        
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
    
    @IBAction func menuPressed(_ sender: AnyObject) {
        
        gameViewControllerPublicVariables.transitioningToMain = true
        MenuViewController.menuPublicVariables.themePlayer.play()
        MenuViewController.menuPublicVariables.themePlayer.volume = 0.6
        GameScene().resetAll()
    }
    
    
}















