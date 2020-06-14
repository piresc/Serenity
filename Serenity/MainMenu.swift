//
//  MainMenu.swift
//  Serenity
//
//  Created by Pires Cerullo on 15/06/20.
//  Copyright © 2020 Pires Cerullo. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene{
    var ground = SKSpriteNode()
    var awan = SKSpriteNode()
    var coral = SKSpriteNode()
    var coral2 = SKSpriteNode()
    var coin = SKSpriteNode()
    let randCCoor = CGFloat.random(in: 300...750)
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createBackground()
    }
    override func update(_ currentTime: CFTimeInterval){
        moveBackground()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
            
        let startNode = childNode(withName: "Start") as! SKSpriteNode
        if startNode.frame.contains(touch.location(in: self)){
            if let scene = SKScene(fileNamed: "GameScene"){
                scene.scaleMode = scaleMode
                view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
            }
        }
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
            coral.position = CGPoint(x:randCCoor, y: -(self.frame.size.height/2))
            coral.zPosition = 4
            self.addChild(coral)
            
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
        ikan.size=CGSize(width: 150, height: 150)
        ikan.anchorPoint = CGPoint(x: -1.5, y: 0.5)
        ikan.position = CGPoint(x: 0, y: 0)
        ikan.zPosition = 4
        self.addChild(ikan)
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
        self.enumerateChildNodes(withName: "Ikan", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -(1000) {
                node.position.x += 1000 * 3
                node.position.y = CGFloat.random(in: -200...100)
            }
        }))
    }
}
