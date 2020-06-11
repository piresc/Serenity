//
//  GameScene.swift
//  Serenity
//
//  Created by Pires Cerullo on 09/06/20.
//  Copyright © 2020 Pires Cerullo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
     var ground = SKSpriteNode()
     var awan = SKSpriteNode()
     var coral = SKSpriteNode()
     var coral2 = SKSpriteNode()
     var scoreLabel = SKLabelNode()
     var char = SKSpriteNode()
    var score = 0 {
        didSet{
            scoreLabel.text = "\(score) M"
        }
    }
    var charPosition: CGFloat = 0
    var breath = 0
    var health = 0
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        breath = 5400
        health = 3
        makeChar()
        createBackground()
        makeScore()
        makeBubble()
        
    }
    
    override func update(_ currentTime: CFTimeInterval){
        moveBackground()
        moveChar()
        score += 1
        updateBubble()
        print (breath)
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
            
            let coral = SKSpriteNode(imageNamed: "Coral")
            coral.name = "Coral"
            coral.size = CGSize(width: 150, height: 150)
            coral.anchorPoint = CGPoint(x: 0.5, y: -0.1)
            let randCoral = CGFloat.random(in: 3000...5000)
            coral.position = CGPoint(x:CGFloat(i) * randCoral, y: -(self.frame.size.height/2))
            
            
            let coral2 = SKSpriteNode(imageNamed: "Coral2")
            coral2.name = "Coral2"
            coral2.size = CGSize(width: 150, height: 150)
            coral2.anchorPoint = CGPoint(x: 0.5, y: 0)
            coral2.position = CGPoint(x:CGFloat(i) * randCoral+CGFloat.random(in: 150...450), y: -(self.frame.size.height/2))
            coral2.xScale = 0.7
            coral2.yScale = 0.7
            self.addChild(coral)
            self.addChild(coral2)
        }
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
    }
    
    func makeScore(){
        scoreLabel.text = "\(score) M"
        scoreLabel.fontColor = SKColor.black
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 150, y: 285)
        scoreLabel.zPosition = 5
        addChild(scoreLabel)
    }
    
    func makeChar(){
        char = (childNode(withName: "Char")as! SKSpriteNode)
        char .zPosition = 5
        charPosition = -1
    }
    
    func moveChar(){
        if char.position.y < -300{
            char.position.y = -300
        }
        if char.position.y>160{
            char.position.y = 160
            breath = 5400
        }
        char.position.y = char.position.y + (charPosition*3)
        if breath > 0{
            breath -= 1
        }else if breath == 0{
            health -= 1
        }
    }
    
   func makeBubble(){
            let bubble1 = SKSpriteNode(imageNamed: "Bubble")
            bubble1.name = "Bubble1"
            bubble1.size=CGSize(width: 25, height: 25)
            bubble1.position = CGPoint(x: 30+50, y: 250)
            bubble1.zPosition = 5
            self.addChild(bubble1)
            
            let bubble2 = SKSpriteNode(imageNamed: "Bubble")
            bubble2.name = "Bubble2"
            bubble2.size=CGSize(width: 25, height: 25)
            bubble2.position = CGPoint(x: 60+50, y: 250)
            bubble2.zPosition = 5
            self.addChild(bubble2)
            
            let bubble3 = SKSpriteNode(imageNamed: "Bubble")
            bubble3.name = "Bubble3"
            bubble3.size=CGSize(width: 25, height: 25)
            bubble3.position = CGPoint(x: 90+50, y: 250)
            bubble3.zPosition = 5
            self.addChild(bubble3)

}
    
    func updateBubble(){
        self.enumerateChildNodes(withName: "Bubble3", using: ({
            (node, error) in
            node.isHidden = true
            if self.breath > 3600 && self.breath < 5400  {
                node.isHidden = false
            }
        }))
        
        self.enumerateChildNodes(withName: "Bubble2", using: ({
            (node, error) in
            node.isHidden = true
            if self.breath > 1800 && self.breath < 5400  {
                node.isHidden = false
            }
        }))
        
        self.enumerateChildNodes(withName: "Bubble1", using: ({
            (node, error) in
            node.isHidden = true
           if self.breath > 0 && self.breath < 5400  {
                node.isHidden = false
            }
        }))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        charPosition = 1
}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        charPosition = -1
    }
}
