//
//  Game.swift
//  BrainBlast
//
//  Created by Jason Scott on 4/12/24.
//


import SpriteKit
import GameplayKit

var money = 0



class Game: SKScene {
    
    //types of defense stuff
    let dartM = SKSpriteNode()
    let spikeM = SKSpriteNode()
    let superM = SKSpriteNode()
    
    
    //labels
    var moneyLabel = SKLabelNode(fontNamed: "Copperplate")
    var roundLabel = SKLabelNode(fontNamed: "Copperplate")
    var livesLabel = SKLabelNode(fontNamed: "Copperplate")

   
    
    //stuff that happens once at launch
    override func sceneDidLoad() {
        
        makeBackground()
        makeButtonNode()
        makeMenu()
        
        
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
        let bg = SKSpriteNode(imageNamed: "3")
        bg.position = CGPoint(x: size.width * 0.5 , y: size.height  * 0.5) //where its at
        bg.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        bg.xScale = (size.height/size.width * 1.48) //prefer scaling doing like this so it i think would scale properly to other devices
        bg.yScale = (size.height/size.width * 0.91)
        addChild(bg) // adds it as a child of the scene
    }
    
    func makeMenu(){
        let menu = SKSpriteNode(imageNamed: "plank360x360")
        menu.position = CGPoint(x: size.width * 0.85 , y: size.height * 0.5)
        menu.zPosition = 4
        menu.zRotation = .pi / 2 //rotating with pi /2 and whatever
       // menu.setScale(size.height/size.width * 2.55)
        menu.xScale = (size.height/size.width * 2.55)
        menu.yScale = (size.height/size.width * 3)
        //menu.xScale = (size.height/size.width * 1.1)
        addChild(menu)
        
        moneyLabel.text = "Money = \(money)"
        moneyLabel.zPosition = 5
        moneyLabel.position = CGPoint(x: size.width * 0.85 , y: size.height * 0.83)
        addChild(moneyLabel)
        
        roundLabel.text = "Round = \(money)"
        roundLabel.zPosition = 5
        roundLabel.position = CGPoint(x: size.width * 0.85 , y: size.height * 0.74)
        addChild(roundLabel)
        
        livesLabel.text = "Lives = \(money)"
        livesLabel.zPosition = 5
        livesLabel.position = CGPoint(x: size.width * 0.85 , y: size.height * 0.65)
        addChild(livesLabel)
        //add more to this menu icons etc
        //uhh then do rough draft of first dart moneky
    }
    
    func makeButtonNode(){
        let button = SKSpriteNode(imageNamed: "real")
        button.position = CGPoint(x:size.width * 0.8, y: size.height * 0.2)
        button.zPosition = 3
        button.setScale(size.height/size.width * 0.2)
        addChild(button)
        
        // make code that makes a button to toggle a monkey menu of sorts
        //thing to the right of bloons where you can buy and hover over stuff.
    }
    
    
    
}
