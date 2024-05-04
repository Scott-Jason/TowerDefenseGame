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
        var boomerang = SKSpriteNode()
        var boomAllowed = true
        var bulletAllowed = true
        var tower = SKSpriteNode()
        var range = SKSpriteNode()
        var bulletSpeed = 0.28
       
        
        let blimTex2: [SKTexture] = [
            SKTexture(imageNamed: "a1"),
            SKTexture(imageNamed: "a2")
        ]
        
        let blimTex3: [SKTexture] = [
            SKTexture(imageNamed: "b4"),
            SKTexture(imageNamed: "b5")
        ]
        
        init(){
            tower = SKSpriteNode()
            range = SKSpriteNode()
        }
        
        
        func throwBoomerang(enemy: SKSpriteNode, scene: SKScene){
            if(boomAllowed)
            {
                boomAllowed = false
                boomerang = SKSpriteNode(imageNamed: "BOOMERANG")
                let pos = enemy.position
                let move1 = SKAction.move(to:pos, duration: bulletSpeed)
                let move2 = SKAction.move(to: tower.position, duration: bulletSpeed)
                scene.addChild(boomerang)
                let theWay = SKAction.sequence([move1, move2])
                //NOT FINISHED
                
            }
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
        func bulletWork(enemy: SKSpriteNode, valToSubtract: Double){
            if(lock){
                if(enemy.intersects(bullet)){
                    lock = false
                    moneyAmt += 1
                    enemy.alpha -= CGFloat(valToSubtract) //can now control how many hits it takes to kill balloons 
                    print(enemy.alpha)
                    if(enemy.alpha < 1.0 && enemy.alpha > 0.99){
                        let cycleTime = SKAction.animate(with:blimTex3, timePerFrame: 0.1)
                        let repeatForever = SKAction.repeatForever(cycleTime)
                        enemy.run(repeatForever)
                    }
                    if(enemy.alpha <= 0.99){
                        let cycleTime = SKAction.animate(with:blimTex2, timePerFrame: 0.1)
                        let repeatForever = SKAction.repeatForever(cycleTime)
                        enemy.run(repeatForever)
                    }
                    if(enemy.alpha <= 0.98){
                        enemy.removeFromParent()
                    }
                    
                  
                }
            }
           
        }
    }

