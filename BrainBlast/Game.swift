//
//  Game.swift
//  BrainBlast
//
//  Created by Jason Scott on 4/12/24.
//

import SpriteKit
import GameplayKit

class Game: SKScene {
    
    //stuff that happens once
    override func sceneDidLoad() {
        makeBackground()
    }
    
    override func didMove(to view: SKView) {
        
     
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
   
    func makeBackground(){
        let black = SKSpriteNode(imageNamed: "black")
        black.position = CGPoint(x: 430, y: 197) //where its at
        black.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        black.xScale = 3.9
        black.yScale = 1.95
        addChild(black)
    }
}
