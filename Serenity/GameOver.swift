//
//  GameOver.swift
//  Serenity
//
//  Created by Pires Cerullo on 15/06/20.
//  Copyright © 2020 Pires Cerullo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameOver: SKScene{
    var scoreLabel = SKLabelNode()
    var test = 0
    
    override func didMove(to view: SKView) {
        let Finalscore = UserDefaults.standard.integer(forKey: "score")
        print(Finalscore)
        if let label = self.childNode(withName: "Score") as? SKLabelNode {
            label.text = "\(Finalscore)"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
            
        let startNode = childNode(withName: "PlayAgain") as! SKSpriteNode
        let homeNode = childNode(withName: "Quit") as! SKSpriteNode
        
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
            
        else if homeNode.frame.contains(touch.location(in: self)){
                let BtnSoundNode = SKAudioNode(fileNamed: "Btn.wav")
                BtnSoundNode.autoplayLooped = false
                self.addChild(BtnSoundNode)

                let volumeAction = SKAction.changeVolume(to: 1, duration: 1)
                BtnSoundNode.run(SKAction.group([volumeAction, SKAction.play()]) )
                
                
                let scene = SKScene(fileNamed: "MainMenu")
                scene!.scaleMode = scaleMode
                
                let transition = SKTransition.fade(with: .white, duration: 1)
                
                let GameStartAction = SKAction.run {
                    self.view?.presentScene(scene!, transition: transition)
                }
            run(SKAction.sequence([SKAction.wait(forDuration: 0.7), GameStartAction]))
        }
    }
}
