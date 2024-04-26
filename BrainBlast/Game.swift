//
//  Game.swift
//  BrainBlast
//
//  Created by Jason Scott on 4/12/24.
//


import SpriteKit
import GameplayKit

var gameTime = 0
var moneyAmt = 0
var roundNum = 1
var livess = 40
var spriteSpeed = 380.0
var spawnNum = 0



class Game: SKScene {
    var ball = SKSpriteNode(imageNamed: "ball")
    var pathing = SKAction()
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
     //   ball.position = CGPoint(x: size.width * -0.1 , y: size.height * 0.6)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: size.width * -0.1 , y: size.height * 0.6))
        path.addLine(to: CGPoint(x: size.width * 0.44, y: size.height * 0.6))
        path.addLine(to: CGPoint(x: size.width * 0.44, y: size.height * 0.92))
        path.addLine(to: CGPoint(x: size.width * 0.27, y: size.height * 0.92))
        path.addLine(to: CGPoint(x: size.width * 0.27, y: size.height * 0.10))
        path.addLine(to: CGPoint(x: size.width * 0.11, y: size.height * 0.10))
        path.addLine(to: CGPoint(x: size.width * 0.11, y: size.height * 0.39))
        path.addLine(to: CGPoint(x: size.width * 0.58, y: size.height * 0.39))
        path.addLine(to: CGPoint(x: size.width * 0.58, y: size.height * 0.73))
        path.addLine(to: CGPoint(x: size.width * 0.70, y: size.height * 0.73))
        path.addLine(to: CGPoint(x: size.width * 0.70, y: size.height * 0.20))
        path.addLine(to: CGPoint(x: size.width * 0.39, y: size.height * 0.20))
        path.addLine(to: CGPoint(x: size.width * 0.39, y: size.height * -0.1))
        
        //can control speed here for the different bloons
        let followPath = SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: spriteSpeed)
        pathing = SKAction.sequence([followPath])
        
      
       // pathing = SKAction.sequence([action3, action4, action5, action6, action7,action8, action9, action10, action11])
        //.sequence lets you chain back to back SKactions, .group lets you do them simultaneously!
        

        
        makeBackground()
        makeButtonNode()
        makeMenu()
        makeStartButtonNode()
        
       // makeBalloon()
        
        
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
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            
            //how many bloons spawn depending on what round it is!
            if touchedNode.name == "start" { //User pressed start roudnd button
                print("test")
                switch roundNum{
                case 1:
                    spawnNum = 5
                case 2:
                    spawnNum = 10
                default:
                    print("yipee")
                }
           
                
                
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    //where balloons spawn and despawn
    override func update(_ currentTime: TimeInterval) {
        gameTime += 1
        
        
        if(spawnNum > 0 && gameTime % 30 == 0){
            makeBalloon()
            spawnNum -= 1
        }
        
        // ballons getting to the end, scans children in the node and if their height less than certiain value deletes from scene and decrements lives.
        for balloon in self.children {
            if let balloonNode = balloon as? SKSpriteNode, balloonNode.name == "enemy"{
                if(balloonNode.position.y <= size.height * 0.01){
                    print("YES")
                    balloonNode.removeFromParent()
                    livess -= 1
                    livesLabel.text = "Lives = \(livess)"
                    
                }
            }
        }
        /*
        for nodes in self.children{
            if let bloon = nodes as? SKSpriteNode, bloon.name == "ball"{
                print("i exist")
            }
        }
        */
        
        
        
        
        
        
        // Called before each frame is rendered
        if(gameTime % 90 == 0){
            //do something
        }
        
    }
   
    func makeBackground(){
        let bg = SKSpriteNode(imageNamed: "track")
        
        bg.position = CGPoint(x: size.width * 0.45 , y: size.height  * 0.5) //where its at
        bg.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        
        // Calculate the scale factors required to fill the screen
        let scaleFactorX = size.width / bg.size.width
        let scaleFactorY = size.height / bg.size.height
        let scaleFactor = max(scaleFactorX, scaleFactorY) // Ensure it covers the whole screen
        
        bg.xScale = scaleFactor
        bg.yScale = scaleFactor

        addChild(bg) // adds it as a child of the scene
        
        let g = SKSpriteNode(imageNamed:"grid")
        g.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        g.zPosition = 2
        g.xScale = 3.54
        g.yScale = 1.62
        g.alpha = 0.3
       // addChild(g)
        
    }
    
    func makeMenu(){
        let menu = SKSpriteNode(imageNamed: "plank360x360")
        menu.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.5)
        menu.zPosition = 4
        menu.zRotation = .pi / 2 //rotating with pi /2 and whatever
       // menu.setScale(size.height/size.width * 2.55)
        menu.xScale = (size.height/size.width * 2.55)
        menu.yScale = (size.height/size.width * 3)
        //menu.xScale = (size.height/size.width * 1.1)
        addChild(menu)
        
        moneyLabel.text = "Money = \(moneyAmt)"
        moneyLabel.zPosition = 5
        moneyLabel.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.83)
        addChild(moneyLabel)
        
        roundLabel.text = "Round = \(roundNum)"
        roundLabel.zPosition = 5
        roundLabel.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.74)
        addChild(roundLabel)
        
        livesLabel.text = "Lives = \(livess)"
        livesLabel.zPosition = 5
        livesLabel.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.65)
        addChild(livesLabel)
        //add more to this menu icons etc
        //uhh then do rough draft of first dart moneky
    }
    
    func makeButtonNode(){
        let button = SKSpriteNode(imageNamed: "real")
        button.position = CGPoint(x:size.width * 0.8, y: size.height * 0.2)
        button.zPosition = 5
        button.setScale(size.height/size.width * 0.2)
        addChild(button)
        
        // make code that makes a button to toggle a monkey menu of sorts
        //thing to the right of bloons where you can buy and hover over stuff.
    }
    
    func makeStartButtonNode(){
        let startButton = SKSpriteNode(imageNamed: "start")
        startButton.zPosition = 5
        startButton.name = "start"
        startButton.position = CGPoint(x:size.width * 0.9, y: size.height * 0.2)
        startButton.setScale(size.height/size.width * 0.2)
        self.addChild(startButton)
        
        let startText = SKLabelNode(text: "Start Round")
        startText.fontColor = UIColor.white
        startText.position = CGPoint(x: 0, y: 0)
        startText.fontSize = 110
        startText.fontName = "Copperplate"
        startText.verticalAlignmentMode = .center  // Align vertically at center
        startText.horizontalAlignmentMode = .center  // Align horizontally at center
        startText.zPosition = 6
        startText.name = "start Round text"
        startButton.addChild(startText)
    }
    
    func makeBalloon(){
        
        ball = SKSpriteNode(imageNamed: "ball")
        ball.name = "enemy"
        ball.position = CGPoint(x: size.width * -0.1 , y: size.height * 0.6)
        ball.zPosition = 5
        ball.xScale = (size.height/size.width * 0.05)
        ball.yScale = (size.height/size.width * 0.05)
        addChild(ball)
        ball.run(pathing)
        
    }
    
    
    
}
