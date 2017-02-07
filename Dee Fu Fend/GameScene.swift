//
//  GameScene.swift
//  Dee Fu Fend
//
//  Created by Caleb Lindsey on 6/21/16.
//  Copyright (c) 2016 KlubCo. All rights reserved.
//

import SpriteKit
import AVFoundation
import CoreData
import GoogleMobileAds
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}




class GameScene : SKScene, SKPhysicsContactDelegate {
    
    // Declare Sprites and Nodes
    var hero = SKSpriteNode()
    var ground = SKNode()
    var background = SKSpriteNode()
    var castle = SKSpriteNode()
    var rocket1 = SKSpriteNode()
    var rocket2 = SKSpriteNode()
    var rocket3 = SKSpriteNode()
    var explosion1 = SKSpriteNode()
    var explosion2 = SKSpriteNode()
    var explosion3 = SKSpriteNode()
    var explosion4 = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var comboLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    var tapToStart = SKSpriteNode()
    var loadingImage = SKSpriteNode()
    var interiorExplosives = SKSpriteNode()
    var fire1 = SKEmitterNode()
    var smoke1 = SKEmitterNode()
    var comboFire1 = SKEmitterNode()
    var finalExplode = SKEmitterNode()
    var finalSmoke = SKEmitterNode()
    var finalFire = SKEmitterNode()
    var renderExplode = SKSpriteNode()
    var rockBase1 = SKSpriteNode()
    var rockBase2 = SKSpriteNode()
    var rockBase3 = SKSpriteNode()
    
    // Declare Texture
    var heroTexture = SKTexture()
    var castleTexture1 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle1")
    var castleTexture2 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle2")
    var castleTexture3 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle3")
    var castleTexture4 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle4")
    var castleTexture5 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle5")
    var castleTexture6 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle6")
    var castleTexture7 = SKTexture(imageNamed: "Dee_Fu_Fend_Castle7")
    var rocketTexture1 = SKTexture(imageNamed: "Rocket11")
    var rocketTexture2 = SKTexture(imageNamed: "Rocket21")
    var rocketTexture3 = SKTexture(imageNamed: "Rocket31")
    var backgroundTexture = SKTexture(imageNamed: "Dee_Fu_Fend_Hero_Background")
    var jumpTexture = SKTexture()
    var descendTexture = SKTexture()
    var attackTexture = SKTexture()
    let explosionTexture1 = SKTexture(imageNamed: "Explosion1")
    let explosionTexture2 = SKTexture(imageNamed: "Explosion1")
    let explosionTexture3 = SKTexture(imageNamed: "Explosion1")
    let explosionTexture4 = SKTexture(imageNamed: "Explosion1")
    let explosionTexture5 = SKTexture(imageNamed: "Explosion1")
    let interiorExplosivesTexture1 = SKTexture(imageNamed: "Interior_Explosives1")
    let tapToStartTexture = SKTexture(imageNamed: "TouchToStart")
    var rockBaseTexture = SKTexture(imageNamed: "rockwall")
    var loadingImageTexture = SKTexture(imageNamed: "loading")
    
    //Declare Audio Variables
    var grunt1 = SKAction.playSoundFileNamed("grunt1.mp3", waitForCompletion: false)
    var buildingExplosion1 = SKAction.playSoundFileNamed("explosion1.mp3", waitForCompletion: false)
    var buildingExplosion2 = SKAction.playSoundFileNamed("explosion2.mp3", waitForCompletion: false)
    var buildingExplosion3 = SKAction.playSoundFileNamed("explosion3.mp3", waitForCompletion: false)
    var jumpNoise1 = SKAction.playSoundFileNamed("jump1.mp3", waitForCompletion: false)
    var hit1 = SKAction.playSoundFileNamed("hit1", waitForCompletion: false)
    var hit2 = SKAction.playSoundFileNamed("hit2", waitForCompletion: false)
    var hit3 = SKAction.playSoundFileNamed("hit3", waitForCompletion: false)
    var takeOff1 = SKAction.playSoundFileNamed("takeOff1.mp3", waitForCompletion: false)
    var takeOff2 = SKAction.playSoundFileNamed("takeOff2.mp3", waitForCompletion: false)
    var takeOff3 = SKAction.playSoundFileNamed("takeOff3.mp3", waitForCompletion: false)
    var multiplierNoise = SKAction.playSoundFileNamed("4Xmultiplier.mp3", waitForCompletion: false)
    var fireCrackle = SKAction.playSoundFileNamed("fireCrackle1.mp3", waitForCompletion: false)
    var fireCrackle2 = SKAction.playSoundFileNamed("fireCrackle1.mp3", waitForCompletion: false)
    var faster1 = SKAction.playSoundFileNamed("faster1.mp3", waitForCompletion: false)
    var faster2 = SKAction.playSoundFileNamed("faster2.mp3", waitForCompletion: false)
    var returnButtonNoise = SKAction.playSoundFileNamed("buttonSelect1.mp3", waitForCompletion: false)
    var beginNoise = SKAction.playSoundFileNamed("begin.mp3", waitForCompletion: false)
    
    // Declare Variables
    var session = false
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()
    var canJump = true
    var canAttack : Bool = true
    let groundGroup : UInt32 = 1
    let heroGroup : UInt32 = 2
    let rocketGroup : UInt32 = 4
    var gameOnTimer = Timer()
    var rocket1Timer = Timer()
    var rocket2Timer = Timer()
    var rocket3Timer = Timer()
    var flicker1 = SKAction()
    var flicker2 = SKAction()
    var flicker3 = SKAction()
    var explode1 = SKAction()
    var explode2 = SKAction()
    var explode3 = SKAction()
    var explode4 = SKAction()
    var explode5 = SKAction()
    var interiorFlicker = SKAction()
    var explodeTimer1 = Timer()
    var explodeTimer2 = Timer()
    var explodeTimer3 = Timer()
    var explodeTimer4 = Timer()
    var greenIsMoving = false
    var blueIsMoving = false
    var redIsMoving = false
    var shakeCastleTimer = Timer()
    var jShake = Int()
    var score : Int = 0
    var comboScore : Int = 0
    var bestCombo = 0
    var formatter = NumberFormatter()
    var castleHealth : Int = 300
    var numTouches = 97
    var fire1Running = false
    var smoke1Running = false
    var currentGameMode = String()
    var comboVisible = false
    var comboFireVisible = false
    var themeMusicTimer = Timer()
    var canGrunt = false
    var classicHighScore = 0
    var challengeHighScore = 0
    var fireCrackleTimer = Timer()
    var fireCrackleCount = -1
    var rocket1Speed : Float = 0.92
    var rocket2Speed : Float = 1
    var fireRocketInterval : Float = 1.2
    var didDestroyRocket1 = false
    var didDestroyRocket2 = false
    var good2000 = true
    var good5000 = true
    var good7500 = true
    var good10000 = true
    var good20000 = true
    var good30000 = true
    var good40000 = true
    var good50000 = true
    var isSpeaking = false
    var checkSpeakingTimer = Timer()
    var health150 = true
    var health285 = true
    var rocket1Points = 75
    var rocket2Points = 120
    var rocket3Points = 175
    var castleIsShaking = false
    var breakTimer = Timer()
    var loadingTimer = Timer()
    var viewController: UIViewController?
    
    //Position Variables
    let rocket1X : Int = 916
    let rocket1Y : Int = 350
    let rocket2X : Int = 835
    let rocket2Y : Int = 380
    let rocket3X : Int = 715
    let rocket3Y : Int = 380
    
    //Declare Arrays
    var rocket1TextureArray = [SKTexture]()
    var rocket2TextureArray = [SKTexture]()
    var rocket3TextureArray = [SKTexture]()
    var explosionTextureArray = [SKTexture]()
    var interiorExplosivesArray = [SKTexture]()
    var attackNoiseArray = [SKAction]()
    var goodArray = [SKAction]()
    var badArray = [SKAction]()
    
    override func didMove(to view: SKView) {
        
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        currentGameMode = MenuViewController.menuPublicVariables.gameMode
        let CurrentHighScore = UserDefaults.standard
        MenuViewController.menuPublicVariables.themePlayer.stop()
        
        if CurrentHighScore.value(forKey: "ClassicHighScore") != nil {
            classicHighScore = CurrentHighScore.value(forKey: "ClassicHighScore") as! NSInteger
        } else {
            classicHighScore = 0
        }
        
        
        if CurrentHighScore.value(forKey: "ChallengeHighScore") != nil {
            challengeHighScore = CurrentHighScore.value(forKey: "ChallengeHighScore") as! NSInteger
        } else {
            challengeHighScore = 0
        }
        
        
        for var i in 1 ..< 3 {
            rocket1TextureArray.append(SKTexture(imageNamed: "Rocket1\(i)"))
            i += 1
        }
        for var i in 1 ..< 3 {
            rocket2TextureArray.append(SKTexture(imageNamed: "Rocket2\(i)"))
            i += 1
        }
        for var i in 1 ..< 3 {
            rocket3TextureArray.append(SKTexture(imageNamed: "Rocket3\(i)"))
            i += 1
        }
        for var i in 1 ..< 12 {
            explosionTextureArray.append(SKTexture(imageNamed: "Explosion\(i)"))
            i += 1
        }
        for var i in 1 ..< 3 {
            interiorExplosivesArray.append(SKTexture(imageNamed: "Interior_Explosives\(i)"))
            i += 1
        }
        
        //Fil Sound Arrays
        for var i in 1 ..< 12 {
            
            attackNoiseArray.append(SKAction.playSoundFileNamed("attack\(i).mp3", waitForCompletion: false))
            i += 1
            
        }
        for var i in 1 ..< 13 {
            
            goodArray.append(SKAction.playSoundFileNamed("good\(i).mp3", waitForCompletion: true))
            i += 1
            
        }
        for var i in 1 ..< 12 {
            
            badArray.append(SKAction.playSoundFileNamed("badd\(i).mp3", waitForCompletion: true))
            i += 1
            
        }
        
        let characterSkin = UserDefaults.standard.value(forKey: "characterSkin") as! String
        
        //Setup Character Skins
        if characterSkin == "DeeFu" {
            
            heroTexture = SKTexture(imageNamed: "Dee_Fu_Fend_Hero_breath1")
            jumpTexture = SKTexture(imageNamed: "Dee_Fu_Fend_Hero_Jump1")
            descendTexture = SKTexture(imageNamed: "Dee_Fu_Fend_Hero_Descend1")
            attackTexture = SKTexture(imageNamed: "Dee_Fu_Fend_Hero_SideKick1")
            
        } else if characterSkin == "RippedDeeFu" {
            
            heroTexture = SKTexture(imageNamed: "rippedDeeFu")
            jumpTexture = SKTexture(imageNamed: "rippedDeeFuJump")
            descendTexture = SKTexture(imageNamed: "rippedDeeFuDescend")
            attackTexture = SKTexture(imageNamed: "rippedDeeFuSideKick")
            
        } else if characterSkin == "DeeFuNinja" {
            
            heroTexture = SKTexture(imageNamed: "DeeFuNinja")
            jumpTexture = SKTexture(imageNamed: "deeFuNinjaJump")
            descendTexture = SKTexture(imageNamed: "deeFuNinjaDescend")
            attackTexture = SKTexture(imageNamed: "deeFuNinjaSideKick")
            
        }
        
        //Delay for ad to load
        
        
        //Setup Background
        background = SKSpriteNode(texture: backgroundTexture)
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.size.height = self.frame.size.height - 175
        background.size.width = self.frame.size.width
        background.zPosition = 0
        self.addChild(background)
        
        //Setup Castle
        castle = SKSpriteNode(texture: castleTexture1)
        castle.position = CGPoint(x: 0, y: 380)
        castle.zPosition = 3
        castle.zRotation = castle.zRotation - 0.1
        castle.setScale(0.6)
        self.addChild(castle)
        
        
        
        // Setup the ground
        ground.position = CGPoint(x: 0, y: 200)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        ground.physicsBody!.isDynamic = false
        ground.physicsBody?.restitution = 0.0
        ground.physicsBody?.categoryBitMask = groundGroup
        ground.zPosition = 10
        self.addChild(ground)
        
        // Setup the hero
        hero = SKSpriteNode(texture: heroTexture)
        hero.position = CGPoint(x: 350, y: 201)
        hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hero.size.width, height: 75))
        hero.physicsBody!.mass = 1
        hero.physicsBody?.restitution = 0.0
        hero.setScale(0.6)
        hero.physicsBody?.friction = 0.0
        hero.physicsBody?.categoryBitMask = heroGroup
        hero.physicsBody?.collisionBitMask = groundGroup
        hero.physicsBody?.contactTestBitMask = groundGroup
        hero.physicsBody?.allowsRotation = false
        hero.physicsBody!.isDynamic = true
        hero.zPosition = 10
        self.addChild(hero)
        
        //Setup Rocket 1
        flicker1 = SKAction.repeatForever(SKAction.animate(with: rocket1TextureArray, timePerFrame: 0.09))
        
        rocket1 = SKSpriteNode(texture: rocketTexture1)
        rocket1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rocket1.size.width / 3, height: 135))
        rocket1.position = CGPoint(x: rocket1X, y: rocket1Y)
        rocket1.setScale(0.1)
        rocket1.zRotation = -0.8
        rocket1.zPosition = 14
        rocket1.run(flicker1, withKey: "rocket1Flicker")
        rocket1.physicsBody?.categoryBitMask = rocketGroup
        rocket1.physicsBody?.contactTestBitMask = heroGroup
        rocket1.physicsBody?.collisionBitMask = heroGroup
        rocket1.physicsBody?.isDynamic = false
        rocket1.physicsBody?.affectedByGravity = false
        rocket1.name = "Rocket1"
        self.addChild(rocket1)
        
        //Setup Rocket 2
        flicker2 = SKAction.repeatForever(SKAction.animate(with: rocket2TextureArray, timePerFrame: 0.09))
        
        rocket2 = SKSpriteNode(texture: rocketTexture2)
        rocket2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rocket2.size.width / 3, height: rocket2.size.height))
        rocket2.position = CGPoint(x: rocket2X, y: rocket2Y)
        rocket2.setScale(0.1)
        rocket2.zRotation = -1
        rocket2.zPosition = 13
        rocket2.run(flicker2, withKey: "rocket2Flicker")
        rocket2.physicsBody?.categoryBitMask = rocketGroup
        rocket2.physicsBody?.contactTestBitMask = heroGroup
        rocket2.physicsBody?.collisionBitMask = heroGroup
        rocket2.physicsBody?.isDynamic = false
        rocket2.physicsBody?.affectedByGravity = false
        rocket2.name = "Rocket2"
        self.addChild(rocket2)
        
        //Setup Rocket 3
        flicker3 = SKAction.repeatForever(SKAction.animate(with: rocket3TextureArray, timePerFrame: 0.09))
        
        rocket3 = SKSpriteNode(texture: rocketTexture3)
        rocket3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rocket3.size.width / 4, height: rocket3.size.height))
        rocket3.position = CGPoint(x: rocket3X, y: rocket3Y)
        rocket3.setScale(0.1)
        rocket3.zRotation = -1
        rocket3.zPosition = 12
        rocket3.run(flicker3, withKey: "rocket3Flicker")
        rocket3.physicsBody?.categoryBitMask = rocketGroup
        rocket3.physicsBody?.contactTestBitMask = heroGroup
        rocket3.physicsBody?.collisionBitMask = heroGroup
        rocket3.physicsBody?.isDynamic = false
        rocket3.physicsBody?.affectedByGravity = false
        rocket3.name = "Rocket3"
        self.addChild(rocket3)
        
        //Setup Explosion 1
        explode1 = SKAction.animate(with: explosionTextureArray, timePerFrame: 0.085)
        
        explosion1 = SKSpriteNode(texture: explosionTexture1)
        explosion1.zPosition = 15
        explosion1.setScale(0.3)
        explosion1.physicsBody?.isDynamic = false
        explosion1.physicsBody?.affectedByGravity = false
        
        //Setup Explosion 2
        explode2 = SKAction.animate(with: explosionTextureArray, timePerFrame: 0.09)
        
        explosion2 = SKSpriteNode(texture: explosionTexture2)
        explosion2.zPosition = 15
        explosion2.setScale(0.3)
        explosion2.physicsBody?.isDynamic = false
        explosion2.physicsBody?.affectedByGravity = false
        
        //Setup Explosion 3
        explode3 = SKAction.animate(with: explosionTextureArray, timePerFrame: 0.09)
        
        explosion3 = SKSpriteNode(texture: explosionTexture3)
        explosion3.zPosition = 15
        explosion3.setScale(0.3)
        explosion3.physicsBody?.isDynamic = false
        explosion3.physicsBody?.affectedByGravity = false
        
        //Setup Explosion 4
        explode4 = SKAction.animate(with: explosionTextureArray, timePerFrame: 0.09)
        
        explosion4 = SKSpriteNode(texture: explosionTexture4)
        explosion4.zPosition = 15
        explosion4.setScale(0.3)
        explosion4.physicsBody?.isDynamic = false
        explosion4.physicsBody?.affectedByGravity = false
        
        //Setup render explode
        explode5 = SKAction.animate(with: explosionTextureArray, timePerFrame: 0.09)
        
        renderExplode.alpha = 0.0
        renderExplode = SKSpriteNode(texture: explosionTexture5)
        renderExplode.zPosition = 15
        renderExplode.setScale(0.3)
        renderExplode.physicsBody?.isDynamic = false
        renderExplode.physicsBody?.affectedByGravity = false
        renderExplode.position = CGPoint(x: self.frame.midX, y: (self.frame.midY))
        renderExplode.zPosition = -5
        self.addChild(renderExplode)
        renderExplode.run(explode5)
        
        //Setup Formatter
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        //Setup Score Label
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.frame.midX, y: (self.frame.midY + 200))
        scoreLabel.text = "0"
        scoreLabel.zPosition = 20
        self.addChild(scoreLabel)
        
        //Setup Combo Label
        comboLabel.fontName = "GillSans-UltraBold"
        comboLabel.fontSize = 45
        comboLabel.fontColor = SKColor.yellow
        comboLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 160)
        comboLabel.text = "X0"
        comboLabel.zPosition = 20
        
        //Setup Game Over Label
        gameOverLabel.fontName = "AmericanTypewriter-Bold"
        gameOverLabel.fontSize = 80
        gameOverLabel.fontColor = SKColor.red
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        gameOverLabel.text = "Game Over"
        gameOverLabel.zPosition = 20
        
        //Setup tapToStart Label
        tapToStart = SKSpriteNode(texture: tapToStartTexture)
        tapToStart.setScale(0.4)
        tapToStart.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 40)
        tapToStart.zPosition = 20
        
        //Setup loadingImage
        loadingImage = SKSpriteNode(texture: loadingImageTexture)
        loadingImage.setScale(0.4)
        loadingImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 40)
        loadingImage.zPosition = 20
        self.addChild(loadingImage)
        loadingTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(loadingTime), userInfo: nil, repeats: false)
        
        //Setup Interior Explosives
        interiorExplosives = SKSpriteNode(texture: interiorExplosivesTexture1)
        interiorFlicker = SKAction.repeatForever(SKAction.animate(with: interiorExplosivesArray, timePerFrame: 0.5))
        interiorExplosives.position = CGPoint(x: 138, y: 262)
        interiorExplosives.physicsBody?.isDynamic = false
        interiorExplosives.zPosition = 2
        interiorExplosives.setScale(0.13)
        self.addChild(interiorExplosives)
        interiorExplosives.run(interiorFlicker)
        
        //Setup Emitters
        smoke1 = SKEmitterNode(fileNamed: "SmokeParticles.sks")!
        smoke1.position = CGPoint(x: 90, y: 500)
        smoke1.zPosition = 1
        
        //Define Fire1
        fire1 = SKEmitterNode(fileNamed: "FireParticles1.sks")!
        fire1.position = CGPoint(x: 85, y: 565)
        fire1.zPosition = 2
        
        comboFire1 = SKEmitterNode(fileNamed: "comboParticles.sks")!
        comboFire1.position = comboLabel.position
        comboFire1.zPosition = 19
        
        //Setup rockbase 1
        rockBase1 = SKSpriteNode(texture: rockBaseTexture)
        rockBase1.zPosition = 15
        rockBase1.setScale(0.4)
        rockBase1.position = CGPoint(x: rocket1X + 9, y: rocket1Y + 5)
        self.addChild(rockBase1)
        
        //Setup rockbase 2
        rockBase2 = SKSpriteNode(texture: rockBaseTexture)
        rockBase2.zPosition = 14
        rockBase2.setScale(0.35)
        rockBase2.zRotation = 0.1
        rockBase2.position = CGPoint(x: rocket2X + 10, y: rocket2Y + 10)
        self.addChild(rockBase2)
        
        //Setup rockbase 3
        rockBase3 = SKSpriteNode(texture: rockBaseTexture)
        rockBase3.zPosition = 13
        rockBase3.setScale(0.3)
        rockBase3.zRotation = 0.1
        rockBase3.position = CGPoint(x: rocket3X + 10, y: rocket3Y + 10)
        self.addChild(rockBase3)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if numTouches == 1{
            
            numTouches = 2
            tapToStart.removeFromParent()
            run(returnButtonNoise)
            session = true
            gameOnTimer = Timer.scheduledTimer(timeInterval: TimeInterval(fireRocketInterval), target: self, selector: #selector(GameScene.fireARocket), userInfo: nil, repeats: true)
            
        }
        else if numTouches == 2 && canJump == true {
            canGrunt = true
            hero.removeAction(forKey: "panting")
            run(jumpNoise1)
            hero.texture = jumpTexture
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 1120)
            canJump = false
            canAttack = true
            
            
        }
        else if numTouches == 99 {
            
            numTouches = 2
            resetAll()
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let randAttackNoise = Int(arc4random_uniform(10))
        
        if canAttack == true && canGrunt == true {
            hero.texture = attackTexture
            
            run(attackNoiseArray[randAttackNoise])
            
             timer = Timer.scheduledTimer(timeInterval: 0.12, target: self, selector: #selector(GameScene.changeTexture), userInfo: nil, repeats: false)
            
        }
        
        
        if hero.physicsBody?.velocity.dy > 0 {
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0.5 * (hero.physicsBody?.velocity.dy)!)
        } else {
            
        }
        
        canAttack = false
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if castleIsShaking == false {
            castle.removeAllActions()
            castle.position = CGPoint(x: 0, y: 380)
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
            canJump = true
            hero.texture = heroTexture
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            
        }
        
        if contact.bodyA.node?.name == "Rocket1" || contact.bodyB.node?.name == "Rocket1" {
            
            //Destroy the rocket before it hits building
            if hero.texture == attackTexture {
        
                playerDestroyedRocket1()
                self.physicsWorld.gravity = CGVector(dx: 0, dy: -12)
            }
        }
        
        if contact.bodyA.node?.name == "Rocket2" || contact.bodyB.node?.name == "Rocket2" {
            
            //Destroy the rocket before it hits building
            if hero.texture == attackTexture {
                
                playerDestroyedRocket2()
                self.physicsWorld.gravity = CGVector(dx: 0, dy: -18)
                
            }
        }
        
        if contact.bodyA.node?.name == "Rocket3" || contact.bodyB.node?.name == "Rocket3" {
            
            //Destroy the rocket before it hits building
            if hero.texture == attackTexture {
                
                playerDestroyedRocket3()
                self.physicsWorld.gravity = CGVector(dx: 0, dy: -30)
                
            }
        }
        
    }
    
    func changeTexture() {
        
        hero.texture = descendTexture
    
    }
    
    //Fires Rocket1
    func fireRocket1() {
        
        redIsMoving = true
        didDestroyRocket1 = false
        let moveLeft = SKAction.moveBy(x: -730, y: -35, duration: TimeInterval(rocket1Speed))
        let resizeRocket1 = SKAction.scale(to: 0.35, duration: TimeInterval(rocket1Speed))
        let rotateRocket1 = SKAction.rotate(byAngle: 0.8, duration: TimeInterval(rocket1Speed))
        rocket1.run(moveLeft)
        rocket1.run(resizeRocket1)
        rocket1.run(rotateRocket1)
        rocket1Timer = Timer.scheduledTimer(timeInterval: TimeInterval(rocket1Speed), target: self, selector: #selector(GameScene.destroyRocket1), userInfo: nil, repeats: false)
        
        //Audio
        let randTakeOff = Int(arc4random_uniform(3) + 1)
        
        switch randTakeOff {
        case 1:
            run(takeOff1)
        case 2:
            run(takeOff2)
        default:
            run(takeOff3)
        }
    }
    
    func destroyRocket1() {
        
        
        if didDestroyRocket1 == false {
            //Add rocket
            rocket1.removeFromParent()
            rocket1.removeAllActions()
            rocket1.position = CGPoint(x: rocket1X, y: rocket1Y)
            rocket1.setScale(0.1)
            rocket1.zRotation = -0.8
            self.addChild(rocket1)
            rocket1.run(flicker1)
            //Animate Explosion
            rocketExplodedOnBuilidng(rocket1)
            
        }
        
        redIsMoving = false
    }
    
    func playerDestroyedRocket1() {
        
        didDestroyRocket1 = true
        rocket1Timer.invalidate()
        rocket1.removeFromParent()
        rocket1.removeAllActions()
        rocket1.position = CGPoint(x: rocket1X, y: rocket1Y)
        rocket1.setScale(0.1)
        rocket1.zRotation = -0.8
        self.addChild(rocket1)
        rocket1.run(flicker1)
        
        //Animate Explosion
        rocketExplodedOnHero(rocket1)
        
        //Add 1 to score and Combo
        if currentGameMode == "classic" {
            score += rocket1Points * comboScore
        } else {
            score += 1
        }
        changeScoreColor(score)
        scoreLabel.text = formatter.string(from: score as NSNumber)
        redIsMoving = false
    }
    
    func fireRocket2() {
        
        blueIsMoving = true
        didDestroyRocket2 = false
        let moveLeft = SKAction.moveBy(x: -715, y: 30, duration: TimeInterval(rocket2Speed))
        let resizeRocket2 = SKAction.scale(to: 0.35, duration: TimeInterval(rocket2Speed))
        let rotateRocket2 = SKAction.rotate(byAngle: 0.8, duration: TimeInterval(rocket2Speed))
        rocket2.run(moveLeft)
        rocket2.run(resizeRocket2)
        rocket2.run(rotateRocket2)
        rocket2Timer = Timer.scheduledTimer(timeInterval: TimeInterval(rocket2Speed), target: self, selector: #selector(GameScene.destroyRocket2), userInfo: nil, repeats: false)
        
        //Audio
        let randTakeOff = Int(arc4random_uniform(3) + 1)
        
        switch randTakeOff {
        case 1:
            run(takeOff1)
        case 2:
            run(takeOff2)
        default:
            run(takeOff3)
        }

        
    }
    
    func destroyRocket2() {
        
        if didDestroyRocket2 == false {
            rocket2.removeFromParent()
            rocket2.removeAllActions()
            rocket2.position = CGPoint(x: rocket2X, y: rocket2Y)
            rocket2.setScale(0.1)
            rocket2.zRotation = -1
            self.addChild(rocket2)
            rocket2.run(flicker2)
            
            //Animate Explosion
            rocketExplodedOnBuilidng(rocket2)
            
            //Reset Combo back to 0
        }
        blueIsMoving = false
    }
    
    func playerDestroyedRocket2() {
        
        didDestroyRocket2 = true
        rocket2Timer.invalidate()
        rocket2.removeFromParent()
        rocket2.removeAllActions()
        rocket2.position = CGPoint(x: rocket2X, y: rocket2Y)
        rocket2.setScale(0.1)
        rocket2.zRotation = -1
        self.addChild(rocket2)
        rocket2.run(flicker2)
        
        //Animate Explosion
        rocketExplodedOnHero(rocket2)
        
        //Add 1 to score and Combo
        if currentGameMode == "classic" {
            score += rocket2Points * comboScore
        } else {
            score += 1
        }
        changeScoreColor(score)
        scoreLabel.text = formatter.string(from: score as NSNumber)
        blueIsMoving = false
    }
    
    func fireRocket3() {
        
        let moveLeft = SKAction.moveBy(x: -550, y: 180, duration: 1.27)
        let resizeRocket3 = SKAction.scale(to: 0.35, duration: 1.27)
        let rotateRocket3 = SKAction.rotate(byAngle: 0.4, duration: 1.27)
        rocket3.run(moveLeft)
        rocket3.run(resizeRocket3)
        rocket3.run(rotateRocket3)
        rocket3Timer = Timer.scheduledTimer(timeInterval: 1.27, target: self, selector: #selector(GameScene.destroyRocket3), userInfo: nil, repeats: false)
        greenIsMoving = true
        
        
        //Audio
        let randTakeOff = Int(arc4random_uniform(3) + 1)
        
        switch randTakeOff {
        case 1:
            run(takeOff1)
        case 2:
            run(takeOff2)
        default:
            run(takeOff3)
        }

        
    }
    
    func destroyRocket3() {
        
        greenIsMoving = false
        rocket3.removeFromParent()
        rocket3.removeAllActions()
        rocket3.position = CGPoint(x: rocket3X, y: rocket3Y)
        rocket3.setScale(0.1)
        rocket3.zRotation = -1
        self.addChild(rocket3)
        rocket3.run(flicker3)
        
        //Animate Explosion
        rocketExplodedOnBuilidng(rocket3)
        
        //Reset Combo back to 0
        
    }
    
    func playerDestroyedRocket3() {
        
        rocket3Timer.invalidate()
        greenIsMoving = false
        rocket3.removeFromParent()
        rocket3.removeAllActions()
        rocket3.position = CGPoint(x: rocket3X, y: rocket3Y)
        rocket3.setScale(0.1)
        rocket3.zRotation = -1
        self.addChild(rocket3)
        rocket3.run(flicker3)
        
        //Animate Explosion
        rocketExplodedOnHero(rocket3)
        
        //Reset Combo back to 0
        if currentGameMode == "classic" {
            score += rocket3Points * comboScore
        } else {
            score += 1
        }
        changeScoreColor(score)
        scoreLabel.text = formatter.string(from: score as NSNumber)
    }
    
    func fireARocket() {
        
        let randRocket = Int(arc4random_uniform(3) + 1)
        let anotherRandRocket = Int(arc4random_uniform(2) + 1)
        
        if greenIsMoving == false {
            switch randRocket {
            case 1:
                fireRocket1()
            case 2:
                fireRocket2()
            case 3:
                fireRocket3()
            default:
                print("")
            }
        } else {
            switch randRocket {
            case 1:
                fireRocket1()
            case 2:
                fireRocket2()
            case 3:
                if anotherRandRocket == 1 {
                    fireRocket1()
                } else {
                    fireRocket2()
                }
            default:
                print("")
            }
        }
        
    }
    
    func rocketExplodedOnBuilidng(_ rocket : SKSpriteNode) {
        
        let randExplosionSound = Int(arc4random_uniform(3) + 1)
        
        if rocket.name == "Rocket1" {
            
            self.addChild(explosion1)
            explosion1.position = CGPoint(x: 175, y: 185)
            explosion1.run(explode1)
            explodeTimer1 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(GameScene.removeExplosion1), userInfo: nil, repeats: false)
            explosion1.run(SKAction.fadeOut(withDuration: 0.86))
            shakeCastleTimer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(GameScene.shakeCastle), userInfo: nil, repeats: true)
            
            castleHealth -= 60
            
            //Reset Combo
            comboLabel.removeFromParent()
            comboFire1.removeFromParent()
            comboScore = 0
            comboLabel.text = "X0"
            comboVisible = false
            comboFireVisible = false
            
            switch randExplosionSound {
            case 1:
                run(buildingExplosion1)
            case 2:
                run(buildingExplosion2)
            default:
                run(buildingExplosion3)
            }
            
            if currentGameMode == "challenge"  {
                if score > bestCombo {
                    bestCombo = score
                }
                score = 0
                scoreLabel.text = "0"
                
                good2000 = true
                good5000 = true
                good7500 = true
                good10000 = true
                good20000 = true
                good30000 = true
                good40000 = true
                good50000 = true
            } 
            
        }
        
        if rocket.name == "Rocket2" {
            
            self.addChild(explosion4)
            explosion4.position = CGPoint(x: 100, y: 290)
            explosion4.run(explode4)
            explodeTimer4 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(GameScene.removeExplosion4), userInfo: nil, repeats: false)
            explosion4.run(SKAction.fadeOut(withDuration: 0.86))
            shakeCastleTimer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(GameScene.shakeCastle), userInfo: nil, repeats: true)
            
            castleHealth -= 30
            
            //Reset Combo
            comboLabel.removeFromParent()
            comboFire1.removeFromParent()
            comboScore = 0
            comboLabel.text = "X0"
            comboVisible = false
            comboFireVisible = false
            
            switch randExplosionSound {
            case 1:
                run(buildingExplosion1)
            case 2:
                run(buildingExplosion2)
            default:
                run(buildingExplosion3)
            }
            
            if currentGameMode == "challenge"  {
                if score > bestCombo {
                    bestCombo = score
                }
                score = 0
                scoreLabel.text = "0"
                
                good2000 = true
                good5000 = true
                good7500 = true
                good10000 = true
                good20000 = true
                good30000 = true
                good40000 = true
                good50000 = true
            }
        }
        
        if rocket.name == "Rocket3" {
            
            self.addChild(explosion3)
            explosion3.position = CGPoint(x: 100, y: 450)
            explosion3.run(explode3)
            explodeTimer3 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(GameScene.removeExplosion3), userInfo: nil, repeats: false)
            explosion3.run(SKAction.fadeOut(withDuration: 0.86))
            shakeCastleTimer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(GameScene.shakeCastle), userInfo: nil, repeats: true)
            
            castleHealth -= 15
            
            //Reset Combo
            comboLabel.removeFromParent()
            comboFire1.removeFromParent()
            comboScore = 0
            comboLabel.text = "X0"
            comboVisible = false
            comboFireVisible = false
            
            switch randExplosionSound {
            case 1:
                run(buildingExplosion1)
            case 2:
                run(buildingExplosion2)
            default:
                run(buildingExplosion3)
            }
            
            if currentGameMode == "challenge"  {
                if score > bestCombo {
                    bestCombo = score
                }
                score = 0
                scoreLabel.text = "0"
                
                good2000 = true
                good5000 = true
                good7500 = true
                good10000 = true
                good20000 = true
                good30000 = true
                good40000 = true
                good50000 = true
                
            }
            
        }
        
        castleImage()
        
        if castleHealth <= 0 && session == true {
            gameOver()
        }
        
        
    }
    func rocketExplodedOnHero(_ rocket : SKSpriteNode) {
        
        let randHit = Int(arc4random_uniform(3) + 1)
        
        if rocket.name == "Rocket1" {
            
            self.addChild(explosion2)
            explosion2.position = CGPoint(x: 380, y: 200)
            explosion2.run(explode2)
            explodeTimer2 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(GameScene.removeExplosion2), userInfo: nil, repeats: false)
            explosion2.run(SKAction.fadeOut(withDuration: 0.86))
            
            if currentGameMode == "classic" {
                updateCombo()
            }
            
            switch randHit {
            case 1:
                run(hit1)
            case 2:
                run(hit2)
            default:
                run(hit3)
            }
            
        }
        
        if rocket.name == "Rocket2" {
            
            self.addChild(explosion2)
            explosion2.position = CGPoint(x: 395, y: 300)
            explosion2.run(explode2)
            explodeTimer2 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(GameScene.removeExplosion2), userInfo: nil, repeats: false)
            explosion2.run(SKAction.fadeOut(withDuration: 0.86))
            
            if currentGameMode == "classic" {
                updateCombo()
            }
            
            switch randHit {
            case 1:
                run(hit1)
            case 2:
                run(hit2)
            default:
                run(hit3)
            }

        }
        
        if rocket.name == "Rocket3" {
            
            self.addChild(explosion3)
            explosion3.position = CGPoint(x: 380, y: 400)
            explosion3.run(explode3)
            explodeTimer3 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(GameScene.removeExplosion3), userInfo: nil, repeats: false)
            explosion3.run(SKAction.fadeOut(withDuration: 0.86))
            
            if currentGameMode == "classic" {
                updateCombo()
            }
            
        }
        
        switch randHit {
        case 1:
            run(hit1)
        case 2:
            run(hit2)
        default:
            run(hit3)
        }

        
    }
    
    func removeExplosion1() {
        
        explosion1.removeFromParent()
        explosion1.alpha = 1
        explosion1.texture = explosionTexture1
        
    }
    
    func removeExplosion2() {
        
        explosion2.removeFromParent()
        explosion2.alpha = 1
        explosion2.texture = explosionTexture2
        
    }
    
    func removeExplosion3() {
        
        explosion3.removeFromParent()
        explosion3.alpha = 1
        explosion3.texture = explosionTexture3
        
    }
    
    func removeExplosion4() {
        
        explosion4.removeFromParent()
        explosion4.alpha = 1
        explosion4.texture = explosionTexture4
        
    }
    
    func shakeCastle() {
        
        castleIsShaking = true
        
        let shiftLeft = SKAction.moveBy(x: -3, y: 0, duration: 0.005)
        let shiftRight = SKAction.moveBy(x: 3, y: 0, duration: 0.005)
            
        if jShake % 2 == 0 {
            
            castle.removeAction(forKey: "shiftRight")
            castle.run(shiftLeft, withKey: "shiftLeft")
            
        }
        if jShake % 2 == 1 {
            
            castle.removeAction(forKey: "shiftLeft")
            castle.run(shiftRight, withKey: "shiftRight")
            
        }
        jShake += 1
        
        if jShake > 5 {
            
            jShake = 0
            shakeCastleTimer.invalidate()
            castleIsShaking = false
        }
    }
    
    func changeScoreColor(_ scoreAmount : Int) {
        
        let goodRemark = Int(arc4random_uniform(11) + 1)
        let randFastRemark = Int(arc4random_uniform(2) + 1)
        
        if currentGameMode == "classic" {
            if scoreAmount >= 50000 {
                scoreLabel.fontColor = SKColor.yellow
                if good50000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good50000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 40000 {
                if good40000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good40000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 30000 {
                scoreLabel.fontColor = SKColor.orange
                if good30000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good30000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 20000 {
                if good20000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good20000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 10000 {
                scoreLabel.fontColor = SKColor.red
                if good10000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good10000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
                
            }
            else if scoreAmount >= 7500 {
                scoreLabel.fontColor = SKColor.green
                rocket1Speed = 0.8
                rocket2Speed = 0.92
                fireRocketInterval = 1.05
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                
                rocket1Points = 150
                rocket2Points = 240
                rocket3Points = 350
                
                if good7500 == true && isSpeaking == false {
                    switch randFastRemark {
                    case 1:
                        run(faster1)
                    default:
                        run(faster2)
                    }
                    good7500 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 5000{
                scoreLabel.fontColor = SKColor.blue
                if good5000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good5000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
                
            }
            else if scoreAmount >= 2000 {
                scoreLabel.fontColor = SKColor.darkGray
                if good2000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good2000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            

            
        }
        else if currentGameMode == "challenge" {
            
            if scoreAmount >= 100 {
                scoreLabel.fontColor = SKColor.yellow
                if good50000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good50000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 75 {
                scoreLabel.fontColor = SKColor.orange
                if good40000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good40000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 50 {
                scoreLabel.fontColor = SKColor.red
                if good30000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good30000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 30 {
                scoreLabel.fontColor = SKColor.green
                rocket1Speed = 0.8
                rocket2Speed = 0.92
                fireRocketInterval = 1.05
                
                if good7500 == true && isSpeaking == false {
                    switch randFastRemark {
                    case 1:
                        run(faster1)
                    default:
                        run(faster2)
                    }
                    good7500 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
                
            }
            else if scoreAmount >= 15{
                scoreLabel.fontColor = SKColor.blue
                if good5000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good5000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
            else if scoreAmount >= 10 {
                scoreLabel.fontColor = SKColor.darkGray
                if good2000 == true && isSpeaking == false {
                    run(goodArray[goodRemark])
                    good2000 = false
                    isSpeaking = true
                    checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
                }
            }
        }
    }
    
    func castleImage() {
        
        let randBadRemark = Int(arc4random_uniform(7) + 1)
        
        if castleHealth <= 60 {
            castle.texture = castleTexture7
        }
        else if castleHealth <= 100 {
            castle.texture = castleTexture6
        }
        else if castleHealth <= 150 {
            castle.texture = castleTexture5
            
            if fire1Running == false {
                self.addChild(fire1)
                fire1Running = true
            }
            if smoke1Running == false {
                self.addChild(smoke1)
                smoke1Running = true
            }
            if health150 == true && isSpeaking == false {
                // 3 6 7 10
                switch randBadRemark {
                case 1:
                    run(badArray[0])
                case 2:
                    run(badArray[1])
                case 3:
                    run(badArray[2])
                case 4:
                    run(badArray[4])
                case 5:
                    run(badArray[5])
                case 6:
                    run(badArray[8])
                case 7:
                    run(badArray[9])
                default:
                    print("")
                }
                
                isSpeaking = true
                health150 = false
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
            }
            
        }
        else if castleHealth <= 200 {
            castle.texture = castleTexture4
            if smoke1Running == false {
                self.addChild(smoke1)
                smoke1Running = true
            }
        }
        else if castleHealth <= 230 {
            castle.texture = castleTexture3
            if smoke1Running == false {
                self.addChild(smoke1)
                smoke1Running = true
            }
        }
        else if castleHealth <= 285 {
            castle.texture = castleTexture2
            
            if health285 == true && isSpeaking == false {
                // 3 6 7 10
                switch randBadRemark {
                case 1:
                    run(badArray[0])
                case 2:
                    run(badArray[1])
                case 3:
                    run(badArray[2])
                case 4:
                    run(badArray[4])
                case 5:
                    run(badArray[5])
                case 6:
                    run(badArray[8])
                case 7:
                    run(badArray[9])
                default:
                    print("")
                }
                
                isSpeaking = true
                health285 = false
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
            }
        }
        
        
    }
    
    func gameOver() {
        //4 7 8 11
        let randBadRemark = Int(arc4random_uniform(4) + 1)
        
        if isSpeaking == false {
            switch randBadRemark {
            case 1:
                run(badArray[3])
                isSpeaking = true
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
            case 2:
                run(badArray[6])
                isSpeaking = true
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
            case 3:
                run(badArray[7])
                isSpeaking = true
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
            default:
                run(badArray[10])
                isSpeaking = true
                checkSpeakingTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(GameScene.checkSpeaking), userInfo: nil, repeats: false)
            }
        }
        
        //Define final smoke and fire
        finalSmoke = SKEmitterNode(fileNamed: "finalSmoke.sks")!
        finalSmoke.position = CGPoint(x: 138, y: 262)
        finalSmoke.zPosition = 21
        
        finalFire = SKEmitterNode(fileNamed: "finalFire.sks")!
        finalFire.position = CGPoint(x: 130, y: 258)
        finalFire.zPosition = 22
        
        
        finalExplode = SKEmitterNode(fileNamed: "finalExplode.sks")!
        finalExplode.position = CGPoint(x: 138, y: 262)
        finalExplode.zPosition = 22
        finalExplode.setScale(1.4)
        self.addChild(finalExplode)
        self.addChild(finalSmoke)
        self.addChild(finalFire)
        run(fireCrackle)
        fireCrackleTimer = Timer.scheduledTimer(timeInterval: 1.9, target: self, selector: #selector(loopFireCrackle), userInfo: nil, repeats: true)
        
        interiorExplosives.removeAllActions()
        interiorExplosives.texture = interiorExplosivesArray[0]
        session = false
        numTouches = 98
        breakTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(interactionEnabled), userInfo: nil, repeats: false)
        
        
        //Reset positions
        explosion1.removeFromParent()
        explosion2.removeFromParent()
        explosion3.removeFromParent()
        explosion4.removeFromParent()
        
        //Invalidate Timers
        gameOnTimer.invalidate()
        
        //Display GAME OVER
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.fontColor = SKColor.red
        self.addChild(gameOverLabel)
        
        
        if currentGameMode == "classic" {
            if score > classicHighScore {
                
                classicHighScore = score
                
                let CurrentHighScore = UserDefaults.standard
                CurrentHighScore.setValue(classicHighScore, forKey: "ClassicHighScore")
                CurrentHighScore.synchronize()
                
                HighScoreView().saveHighScore(classicHighScore)
                
            }
        }
        
        if currentGameMode == "challenge" {
            if bestCombo > challengeHighScore {
                
                challengeHighScore = bestCombo
                
                let CurrentHighScore = UserDefaults.standard
                CurrentHighScore.setValue(challengeHighScore, forKey: "ChallengeHighScore")
                CurrentHighScore.synchronize()
                
            }
        }
    }
    
    func updateCombo() {
        
        if comboVisible == false && comboScore < 4 {
            
            comboLabel.fontColor = SKColor.yellow
            comboVisible = true
            comboScore += 1
            comboLabel.text = "X\(comboScore)"
            self.addChild(comboLabel)
            
        }
        else if comboVisible == true && comboScore < 4 {
            
            comboScore += 1
            comboLabel.text = "X\(comboScore)"
            
        }
        
        if comboScore == 4 && comboFireVisible == false {
            
            run(multiplierNoise)
            comboLabel.fontColor = SKColor.black
            comboFireVisible = true
            self.addChild(comboFire1)
        }
        
    }
    
    internal func resetAll() {
    
        session = true
        numTouches = 2
        
        run(beginNoise)
        
        //Reset Caslte
        castleHealth = 300
        castle.texture = castleTexture1
        finalExplode.removeFromParent()
        finalSmoke.removeFromParent()
        finalFire.removeFromParent()
        fireCrackleTimer.invalidate()
        removeAction(forKey: "fireCrackle")
        
        
        
        //Reset Hero
        hero.position = CGPoint(x: 350, y: 210)
        
        //Reset Score
        score = 0
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.black
        comboScore = 0
        comboLabel.text = "X0"
        comboLabel.fontColor = SKColor.black
        comboVisible = false
        
        //Remove Emitters
        fire1Running = false
        smoke1.removeFromParent()
        fire1.removeFromParent()
        smoke1Running = false
        
        //Remove Labels
        gameOverLabel.removeFromParent()
        tapToStart.removeFromParent()
        run(returnButtonNoise)
        
        rocket1Speed = 0.92
        rocket2Speed = 1
        fireRocketInterval = 1.2
        
        //Audio
        good2000 = true
        good5000 = true
        good7500 = true
        good10000 = true
        good20000 = true
        good30000 = true
        good40000 = true
        good50000 = true
        health150 = true
        health285 = true
        
        
        rocket1Points = 75
        rocket2Points = 120
        rocket3Points = 175
    
    
        gameOnTimer = Timer.scheduledTimer(timeInterval: 1.15, target: self, selector: #selector(GameScene.fireARocket), userInfo: nil, repeats: true)
        
    }
    
    func loopFireCrackle() {
        
        fireCrackleCount += 1
        
        if fireCrackleCount % 2 == 0 {
        run(fireCrackle2, withKey: "fireCrackle")
            
        }
        else if fireCrackleCount % 2 == 1 {
            run(fireCrackle2, withKey: "fireCrackle")
        }
        
    }
    
    func checkSpeaking() {
        
        isSpeaking = false
        
    }
    
    func interactionEnabled() {
        
        numTouches = 99
        //Display Tap to try again
        self.addChild(tapToStart)
        
    }
    
    func loadingTime() {
        
        loadingImage.removeFromParent()
        run(beginNoise)
        self.addChild(tapToStart)
        numTouches = 1
        
    }
    
    
}






