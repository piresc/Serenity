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
    
    override func sceneDidLoad() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createBackground()
        let BgmNode = SKAudioNode(fileNamed: "BgmMenu.mp3")
        BgmNode.autoplayLooped = true
        let volumeAction = SKAction.changeVolume(to: 0.5, duration: 0)
        BgmNode.run(SKAction.group([volumeAction, SKAction.play()]) )
        self.addChild(BgmNode)
    }
    override func update(_ currentTime: CFTimeInterval){
        moveBackground()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
            
        let startNode = childNode(withName: "Start") as! SKSpriteNode
        if startNode.frame.contains(touch.location(in: self)){
            let BtnSoundNode = SKAudioNode(fileNamed: "Btn.wav")
            BtnSoundNode.autoplayLooped = false
            self.addChild(BtnSoundNode)

            let volumeAction = SKAction.changeVolume(to: 1, duration: 1)
            BtnSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
            
            
            let scene = SKScene(fileNamed: "GameScene")
            scene!.scaleMode = scaleMode
            
            let transition = SKTransition.fade(with: .white, duration: 1)
            
            let GameStartAction = SKAction.run {
                self.view?.presentScene(scene!, transition: transition)
            }
            
            run(SKAction.sequence([SKAction.wait(forDuration: 0.7), GameStartAction]))

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
