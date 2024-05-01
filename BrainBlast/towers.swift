//
//  towers.swift
//  BrainBlast
//
//  Created by Jason Scott on 5/1/24.
//
import SpriteKit
import GameplayKit
import Foundation

class towers{
    var lock = true
    var bullet = SKSpriteNode()
    var bulletAllowed = true
    var tower = SKSpriteNode()
    var range = SKSpriteNode()
    var bulletSpeed = 0.28
    
    init(){
        tower = SKSpriteNode()
        range = SKSpriteNode()
    }
    
    func shoot(enemy: SKSpriteNode, scene: SKScene){
        if(bulletAllowed){
            bulletAllowed = false
            bullet = SKSpriteNode(imageNamed: "bullet")
            let pos = enemy.position
            bullet.xScale = 2.0
            bullet.yScale = 2.0
            bullet.name = "bullet"
            bullet.zPosition = 20
            bullet.position = tower.position
            let moveAction = SKAction.move(to: pos, duration: bulletSpeed)
            scene.addChild(bullet)
            
            bullet.run(moveAction){
                self.bulletAllowed = true
                self.bullet.removeFromParent()
                self.lock = true
            }
        }
        
    }
    func bulletWork(enemy: SKSpriteNode){
        if(lock){
            if(enemy.intersects(bullet)){
                lock = false
                moneyAmt += 1
                enemy.removeFromParent()
              
            }
        }
       
        
    }
}

