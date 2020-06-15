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
            if let scene = SKScene(fileNamed: "GameScene"){
                scene.scaleMode = scaleMode
                view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
            }
        }
        else if homeNode.frame.contains(touch.location(in: self)){
            if let scene = SKScene(fileNamed: "MainMenu"){
                scene.scaleMode = scaleMode
                view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
            }
        }
    }
}
