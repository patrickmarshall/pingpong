//
//  GameScene.swift
//  pingpong
//
//  Created by PATRICK MARSHALL on 7/3/17.
//  Copyright © 2017 patrickmarshall. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

var currentGameType = gameType.medium
class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var main = SKSpriteNode()
    var enemy = SKSpriteNode()
    var score = [Int]()
    var labelEnemy = SKLabelNode()
    var labelMain = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        labelMain = self.childNode(withName: "labelMain") as! SKLabelNode
        labelEnemy = self.childNode(withName: "labelEnemy") as! SKLabelNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    func startGame(){
        score = [0,0]
        labelMain.text = "\(score[1])"
        labelEnemy.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
    }
    func addScore(playerWon: SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWon == main{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerWon == enemy{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
        labelMain.text = "\(score[1])"
        labelEnemy.text = "\(score[0])"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if currentGameType == .player2{
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0))                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType{
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
            break
        case .player2:
            
            break
        }
        
        if ball.position.y <= main.position.y - 70{
            addScore(playerWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 70{
            addScore(playerWon: main)
        }
       
    }
}
