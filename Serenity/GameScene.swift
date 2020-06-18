//
//  GameScene.swift
//  Serenity
//
//  Created by Pires Cerullo on 09/06/20.
//  Copyright © 2020 Pires Cerullo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct PhysicalBodyCategory{
    static let char : UInt32 = 0b1
    static let coral : UInt32 = 0b10
    static let coin : UInt32 = 0b100
}

class GameScene: SKScene {
    var ground = SKSpriteNode()
    var awan = SKSpriteNode()
    var coral = SKSpriteNode()
    var coral2 = SKSpriteNode()
    var char = SKSpriteNode()
    var coin = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var coinViewLabel = SKLabelNode()
    var touchtimeCoin = -150
    var touchtimeCoral = -150
    var breath = 0
    var health = 0
    var test = 0
    var breathTimer = 0
    var score = 0 {
        didSet{
            scoreLabel.text = "\(score) M"
        }
    }
    var coinView = 0 {
        didSet{
            coinViewLabel.text = "\(coinView)"
        }
    }
    let randCCoor = CGFloat.random(in: 300...750)
    var charPosition: CGFloat = 0
    var SwimAction: SKAction!
    var DrownAction: SKAction!
    
    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let BgmNode = SKAudioNode(fileNamed: "Bgm.mp3")
        BgmNode.autoplayLooped = true
        let volumeAction = SKAction.changeVolume(to: 2, duration: 0)
        BgmNode.run(SKAction.group([volumeAction, SKAction.play()]) )
        self.addChild(BgmNode)
        
        breath = 1800
        health = 3
        createBackground()
        createChar()
        setupSwimAction()
        setupDrownAction()
        char.run(SwimAction,withKey: "SwimAnimation")
        createCoral()
        createCoin()
        
        createScore()
        createCoinView()
        createBubble()
        createHealth()
        
    }
    
    override func update(_ currentTime: CFTimeInterval){
        score += 1
        moveBackground()
        moveChar()
        updateBubble()
        updateHealth()
        if touchtimeCoin + 60 == score{
            CoinSoundNode.removeFromParent()
        }
        if touchtimeCoral + 60 == score{
            CoralSoundNode.removeFromParent()
        }
        if health == 0{
            test -= 1
        }
        if test == -5{
            char.removeAction(forKey: "SwimAnimation")
            char.run(DrownAction,withKey: "DrownAnimation")
            setupDyingAction()
        }
    }

    func createChar(){
        char = (childNode(withName: "Char")as! SKSpriteNode)
        char.name = "Char"
        char .zPosition = 5
        charPosition = -1
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 180, height: 100))
        physicsBody.categoryBitMask = PhysicalBodyCategory.char
        physicsBody.contactTestBitMask = PhysicalBodyCategory.coral
        physicsBody.collisionBitMask = 0
        char.physicsBody = physicsBody
        char.physicsBody?.affectedByGravity = false
    }
    
    func setupSwimAction() {
        var textures = [SKTexture]()
        for i in 1...6 {
            textures.append(SKTexture(imageNamed: "Swim\(i)"))
        }
        SwimAction = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.2))
    }
    
    func setupDrownAction() {
        var textures = [SKTexture]()
        for i in 1...6 {
            textures.append(SKTexture(imageNamed: "Drowned\(i)"))
        }
        DrownAction = SKAction.animate(with: textures, timePerFrame: 0.2)
    }
    
    func setupDyingAction() {
        let DeadSoundNode = SKAudioNode(fileNamed: "Dead.mp3")
        DeadSoundNode.autoplayLooped = false
        self.addChild(DeadSoundNode)

        let volumeAction = SKAction.changeVolume(to: 1, duration: 0)
        DeadSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
        let totalscore = score + (coinView * 600)
        UserDefaults.standard.set(totalscore, forKey: "score")
        
        let scene = SKScene(fileNamed: "GameOver")
        scene!.scaleMode = scaleMode
        
        
        let transition = SKTransition.fade(with: .white, duration: 1)
        
        let gameOverAction = SKAction.run {
            self.view?.presentScene(scene!, transition: transition)
        }
        run(SKAction.sequence([SKAction.wait(forDuration: 4), gameOverAction]))
    }
    func createBackground(){
        for i in 0...3{
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = "Ground"
            ground.size=CGSize(width: 3000, height: 450)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0)
            ground.position = CGPoint(x:CGFloat(i) * ground.size.width, y: -(self.frame.size.height/2))
            ground.zPosition = -5
            self.addChild(ground)
            
            let awan = SKSpriteNode(imageNamed: "Awan")
            awan.name = "Awan"
            awan.size=CGSize(width: 750, height: 500)
            awan.anchorPoint = CGPoint(x: 0.5, y: -0.5)
            awan.position = CGPoint(x:CGFloat(i) * awan.size.width, y: -(self.frame.size.height/2))
            self.addChild(awan)
            
            let coral2 = SKSpriteNode(imageNamed: "Coral2")
            coral2.name = "Coral2"
            coral2.size = CGSize(width: 150, height: 150)
            coral2.anchorPoint = CGPoint(x: 0.5, y: 0)
            coral2.position = CGPoint(x:CGFloat(i) * (randCCoor+CGFloat.random(in: -150...150)), y: -(self.frame.size.height/2))
            coral2.xScale = 0.7
            coral2.yScale = 0.7
            self.addChild(coral2)
        }
        let ikan = SKSpriteNode(imageNamed: "Ikan")
        ikan.name = "Ikan"
        ikan.size=CGSize(width: 120, height: 120)
        ikan.anchorPoint = CGPoint(x: -1.5, y: 0.5)
        ikan.position = CGPoint(x: 0, y: 0)
        ikan.zPosition = 4
        self.addChild(ikan)
    }
    
    func createCoral(){
        let coral = SKSpriteNode(imageNamed: "Coral")
        coral.name = "Coral"
        coral.size = CGSize(width: 150, height: 150)
        coral.anchorPoint = CGPoint(x: 0.5, y: -0.1)
        coral.position = CGPoint(x:randCCoor, y: -(self.frame.size.height/2))
        coral .zPosition = 5
        let physicsBody = SKPhysicsBody(rectangleOf: coral.size)
        physicsBody.categoryBitMask = PhysicalBodyCategory.coral
        physicsBody.contactTestBitMask = PhysicalBodyCategory.char
        coral.physicsBody = physicsBody
        coral.physicsBody?.isDynamic = false
        coral.physicsBody?.affectedByGravity = false
        self.addChild(coral)
    }
    
    func createCoin(){
            let coin = SKSpriteNode(imageNamed: "Coin")
            coin.name = "Coin"
            coin.size = CGSize(width: 50, height: 50)
            coin.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            coin.position = CGPoint(x:randCCoor, y: CGFloat.random(in: -250...160))
            coin.zPosition = 5
            let physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width/2)
            physicsBody.categoryBitMask = PhysicalBodyCategory.coin
            physicsBody.contactTestBitMask = PhysicalBodyCategory.char
            coin.physicsBody = physicsBody
            coin.physicsBody?.isDynamic = false
            coin.physicsBody?.affectedByGravity = false
            self.addChild(coin)
    }
    
    func createCoinView(){
        coinViewLabel.text = "\(coinView)"
        coinViewLabel.fontColor = SKColor.black
        coinViewLabel.horizontalAlignmentMode = .right
        coinViewLabel.position = CGPoint(x: 120, y: 255)
        coinViewLabel.zPosition = 5
        addChild(coinViewLabel)
        let coinLG = SKSpriteNode(imageNamed: "Coin")
        coinLG.name = "CoinLG"
        coinLG.size = CGSize(width: 25, height: 25)
        coinLG.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        coinLG.position = CGPoint(x: 140, y: 265)
        coinLG.zPosition = 5
        self.addChild(coinLG)
    }
    
    func moveBackground(){
        self.enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(3000) {
                node.position.x += 3000 * 3
            }
        }))
        self.enumerateChildNodes(withName: "Awan", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(750) {
                node.position.x += 750 * 3
            }
        }))
        self.enumerateChildNodes(withName: "Coral", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(750) {
                node.position.x += 750 * 3
            }
        }))
        self.enumerateChildNodes(withName: "Coral2", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(750) {
                node.position.x += 750 * 3
            }
        }))
        self.enumerateChildNodes(withName: "Coin", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(175) {
                node.position.x += 175 * 3
                node.position.y = CGFloat.random(in: -250...160)
            }
        }))
        self.enumerateChildNodes(withName: "Ikan", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(1000) {
                node.position.x += 1000 * 3
                node.position.y = CGFloat.random(in: -200...100)
            }
        }))
    }

    func moveChar(){
        if char.position.y < -300{
            char.position.y = -300
        }
        if char.position.y>160{
            char.position.y = 160
            breath = 1800
        }
        char.position.y = char.position.y + (charPosition*3)
            breath -= 1
    }

    func createScore(){
        scoreLabel.text = "\(score) M"
        scoreLabel.fontColor = SKColor.black
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 150, y: 285)
        scoreLabel.zPosition = 5
        addChild(scoreLabel)
    }
    
   func createBubble(){
        let bubble1 = SKSpriteNode(imageNamed: "Bubble")
        bubble1.name = "Bubble1"
        bubble1.size=CGSize(width: 25, height: 25)
        bubble1.position = CGPoint(x: -80, y: 255)
        bubble1.zPosition = 5
        self.addChild(bubble1)
            
        let bubble2 = SKSpriteNode(imageNamed: "Bubble")
        bubble2.name = "Bubble2"
        bubble2.size=CGSize(width: 25, height: 25)
        bubble2.position = CGPoint(x: -110, y: 255)
        bubble2.zPosition = 5
        self.addChild(bubble2)
            
        let bubble3 = SKSpriteNode(imageNamed: "Bubble")
        bubble3.name = "Bubble3"
        bubble3.size=CGSize(width: 25, height: 25)
        bubble3.position = CGPoint(x: -140, y: 255)
        bubble3.zPosition = 5
        self.addChild(bubble3)
}
    
    func updateBubble(){
        self.enumerateChildNodes(withName: "Bubble1", using: ({
            (node, error) in
            node.isHidden = true
            if self.breath > 1200 && self.breath < 1800  {
                node.isHidden = false
            }
            if self.breath == 1200{
                self.BubbleSound()
            }
            if self.breath == 1100 || self.breath == 1800{
                self.BubbleSoundNode.removeFromParent()
            }
        }))
        
        self.enumerateChildNodes(withName: "Bubble2", using: ({
            (node, error) in
            node.isHidden = true
            if self.breath > 600 && self.breath < 1800  {
                node.isHidden = false
            }
            if self.breath == 600{
                self.BubbleSound()
            }
            if self.breath == 500 || self.breath == 1800{
                self.BubbleSoundNode.removeFromParent()
            }
        }))
        
        self.enumerateChildNodes(withName: "Bubble3", using: ({
            (node, error) in
            node.isHidden = true
           if self.breath > 0 && self.breath < 1800  {
                node.isHidden = false
            }
            if self.breath == 0{
                self.BubbleSound()
            }
            if self.breath == -100 || self.breath == 1800{
                self.BubbleSoundNode.removeFromParent()
            }
        }))
        if breath < 0{
            breathTimer += 1
        }
        if breath == 1800{
            breathTimer = 0
        }
    }
       func createHealth(){
            let health1 = SKSpriteNode(imageNamed: "Health")
            health1.name = "Health1"
            health1.size=CGSize(width: 25, height: 25)
            health1.position = CGPoint(x: -80, y: 295)
            health1.zPosition = 5
            health1.color = .red
            self.addChild(health1)
                
            let health2 = SKSpriteNode(imageNamed: "Health")
            health2.name = "Health2"
            health2.size=CGSize(width: 25, height: 25)
            health2.position = CGPoint(x: -110, y: 295)
            health2.zPosition = 5
            self.addChild(health2)
                
            let health3 = SKSpriteNode(imageNamed: "Health")
            health3.name = "Health3"
            health3.size=CGSize(width: 25, height: 25)
            health3.position = CGPoint(x: -140, y: 295)
            health3.zPosition = 5
            self.addChild(health3)
    }
    func updateHealth(){
        self.enumerateChildNodes(withName: "Health1", using: ({
            (node, error) in
            node.isHidden = true
            if self.health > 2 {
                node.isHidden = false
            }
        }))
        
        self.enumerateChildNodes(withName: "Health2", using: ({
            (node, error) in
            node.isHidden = true
            if self.health > 1 {
                node.isHidden = false
            }
        }))
    
        self.enumerateChildNodes(withName: "Health3", using: ({
            (node, error) in
            node.isHidden = true
           if self.health > 0  {
                node.isHidden = false
            }
        }))
        if breathTimer == 600{
            health -= 1
        }
        if breathTimer == 1200{
            health -= 1
        }
        if breathTimer == 1800{
            health -= 1
        }
    }

    
//Sound
    let SwimSoundNode = SKAudioNode(fileNamed: "Diving.mp3")
    func SwimSound() {
        SwimSoundNode.autoplayLooped = false
        self.addChild(SwimSoundNode)

        let volumeAction = SKAction.changeVolume(to: 2, duration: 0)
        SwimSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
    }

    let CoralSoundNode = SKAudioNode(fileNamed: "Coral.mp3")
    func CoralSound(){
        CoralSoundNode.autoplayLooped = false
        self.addChild(CoralSoundNode)

        let volumeAction = SKAction.changeVolume(to: 0.4, duration: 0)
        CoralSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
    }
    let CoinSoundNode = SKAudioNode(fileNamed: "Coin.mp3")
    func CoinSound(){
        CoinSoundNode.autoplayLooped = false
        self.addChild(CoinSoundNode)

        let volumeAction = SKAction.changeVolume(to: 0.2, duration: 0)
        CoinSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
    }
    let BubbleSoundNode = SKAudioNode(fileNamed: "LostBubbles.mp3")
    func BubbleSound(){
        BubbleSoundNode.autoplayLooped = false
        self.addChild(BubbleSoundNode)
        let volumeAction = SKAction.changeVolume(to: 0.2, duration: 0)
        BubbleSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if health > 0 {
        charPosition = 1
        SwimSound()
        }
}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        charPosition = -1
        SwimSoundNode.removeFromParent()
        
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicalBodyCategory.coral | PhysicalBodyCategory.char {
            if score - 150 > touchtimeCoral {
                health -= 1
                CoralSound()
                self.enumerateChildNodes(withName: "Char", using: ({
                    (node, error) in
                    let wait = SKAction.wait(forDuration: 0.1)
                    let hide = SKAction.run {node.isHidden = true}
                    let unhide = SKAction.run {node.isHidden = false}
                    let sequence = SKAction.sequence([hide,wait,unhide,wait,hide,wait,unhide,wait,hide,wait,unhide,wait,hide,wait,unhide,wait,hide,wait,unhide,wait,hide,wait,unhide,wait])
                    if self.health > 0 {
                    node.run(sequence)
                        }
                    }
                ))
                if(health == 0){
                    setupDyingAction()
                }
                touchtimeCoral = score
            }
        }
        
        if contactMask == PhysicalBodyCategory.coin | PhysicalBodyCategory.char {
            if score - 150 > touchtimeCoin {
                if health > 0 {
                coinView += 1
                CoinSound()
                self.enumerateChildNodes(withName: "Coin", using: ({
                    (node, error) in
                    let wait = SKAction.wait(forDuration: 2.5)
                    let hide = SKAction.run {node.isHidden = true}
                    let unhide = SKAction.run {node.isHidden = false}
                    let sequence = SKAction.sequence([hide,wait,unhide])
                    node.run(sequence)
                    }
                ))
                touchtimeCoin = score
                }
            }
        }
    }
}
