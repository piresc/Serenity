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
    var score = 0 {
        didSet{
            scoreLabel.text = "\(score) M"
        }
    }
    var Char: SKSpriteNode!
    var UpBtn: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createGrounds()
        scoreLabel.text = "\(score) M"
        scoreLabel.fontColor = SKColor.black
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 150, y: 285)
        scoreLabel.zPosition = 5
        addChild(scoreLabel)
    }
    
    override func update(_ currentTime: CFTimeInterval){
        moveGrounds()
        score += 1
    }
    func createGrounds(){
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
    func moveGrounds(){
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
}
