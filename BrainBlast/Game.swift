//
//  Game.swift
//  BrainBlast
//
//  Created by Jason Scott on 4/12/24.
//


//adds to that library

extension CGPoint {
    // Calculate the angle between two points
    func angle(to point: CGPoint) -> CGFloat {
        return atan2(point.y - self.y, point.x - self.x)
    }
}

extension SKNode {
    // Rotate the node to look at another node
    func lookAtNode(_ node: SKNode) {
        let angle = position.angle(to: node.position)
        zRotation = angle - CGFloat.pi / 2  // Adjust for sprite's initial rotation
    }
}

import SpriteKit
import GameplayKit

var gameTime = 0
var moneyAmt = 0
var roundNum = 1
var livess = 40
var spriteSpeed = 250.0
var spawnNum = 0


//whether current obj is placed or not
var numPlaced = 0
var placed = true
var active = false



class Game: SKScene {
    var ball = SKSpriteNode(imageNamed: "ball")
    var pathing = SKAction()
    //types of defense stuff
    var mokey = SKSpriteNode()
    var newMokey = SKSpriteNode()
    var zone = SKSpriteNode()
    let spikeM = SKSpriteNode()
    let superM = SKSpriteNode()
    var clonedNode: SKSpriteNode?
    var lastNode = SKSpriteNode()
    
   
    
    //labels
    var moneyLabel = SKLabelNode(fontNamed: "Copperplate")
    var roundLabel = SKLabelNode(fontNamed: "Copperplate")
    var livesLabel = SKLabelNode(fontNamed: "Copperplate")

    let blimbleeTexture: [SKTexture] = [
        SKTexture(imageNamed: "b1"),
        SKTexture(imageNamed: "b2")
      ]
    
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
            
            if touchedNode.name == "other"{
                active = false
                print("BRUH")
                for balloon in self.children {
                    if let balloonNode = balloon as? SKSpriteNode, balloonNode.name == "myZone"{
                        balloonNode.alpha = 0.001
                    }
                }
            }
            
            //how many bloons spawn depending on what round it is!
            if touchedNode.name == "tower" {
                active = true
                touchedNode.xScale = 0.2
                let touchedNodes = nodes(at: location)
                for node in touchedNodes {
                    if(node.name == "myZone"){
                        node.alpha = 0.5
                        //print("JRFIREF")
                    }
                  //  print("Found the target node:", node)
                }
               
            }
           
            if touchedNode.name == "mokey" {
                print("pick up mokey")
                
                newMokey = SKSpriteNode(imageNamed: "pim")
                newMokey.zPosition = 5
                newMokey.position = location
                newMokey.xScale = (size.height/size.width * 1)
                newMokey.yScale = (size.height/size.width * 1)
                newMokey.name = "tower"
                addChild(newMokey)
                zone = SKSpriteNode(imageNamed: "zone")
                zone.zPosition = 4
                
                zone.position = location
                zone.xScale = (size.height/size.width * 0.4)
                zone.yScale = (size.height/size.width * 0.4)
                zone.name = "myZone"
                zone.alpha = 0.5
                addChild(zone)
                
                placed = false
                            
            }
            
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
           for touch in touches {
               let location = touch.location(in: self)
               
               // Update the position of the cloned node to follow the touch
               if(placed == false){
                   newMokey.position = location
                   zone.position = location
                   print(newMokey.position.x)
               }
           }
       }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //   clonedNode?.removeFromParent()
      //  zone.alpha = 0.001
        if(placed == false){
            zone.alpha = 0.001
        }
        placed = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    //where balloons spawn and despawn
    override func update(_ currentTime: TimeInterval) {
        gameTime += 1
        
        /*
        if(placed == false){
            for balloon in self.children {
                if let balloonNode = balloon as? SKSpriteNode, balloonNode.name == String(numPlaced - 1){
                    balloonNode.position = CGPOINT
            
        } */
        
        if(spawnNum > 0 && gameTime % 30 == 0){
            makeBalloon()
            spawnNum -= 1
        }
        
        // ballons getting to the end, scans children in the node and if their height less than certiain value deletes from scene and decrements lives.
        //shouldnt have named these variables so similar sorry!
        //basically going through each enemy and seeing if it intersects with a tower
        for balloon in self.children {
            if let balloonNode = balloon as? SKSpriteNode, balloonNode.name == "enemy"{
                for node in self.children {
                    if node.name == "myZone" {
                        if let zoneNode = node as? SKSpriteNode, balloonNode.intersects(zoneNode) {
                            for node in self.children {
                                if let tower = node as? SKSpriteNode, tower.name == "tower"{
                                    tower.lookAtNode(balloonNode)
                                }
                            }
                           // make this tower towerNode.lookAtNode(balloonNode)
                           // balloonNode.removeFromParent()
                            //inside the zone
                        }
                    }
                }
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
        let monkeyTest = SKSpriteNode(imageNamed: "pim")
        monkeyTest.name = "mokey"
        monkeyTest.position = CGPoint(x:size.width * 0.81, y: size.height * 0.55)
        monkeyTest.zPosition = 5
        monkeyTest.xScale = (size.height/size.width * 1)
        monkeyTest.yScale = (size.height/size.width * 1)
        
        addChild(monkeyTest)
    }
    
    func makeButtonNode(){
        let button = SKSpriteNode(imageNamed: "real")
        button.position = CGPoint(x:size.width * 0.8, y: size.height * 0.2)
        button.zPosition = 5
        button.name = "other"
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
        
        ball = SKSpriteNode(texture: blimbleeTexture[0])
       // let cycleTime = SKAction.animate(with:blimbleeTexture, timePerFrame: 0.2)
       // let repeatForever = SKAction.repeatForever(cycleTime)
        
        ball.name = "enemy"
        // negative 0.1
        ball.position = CGPoint(x: size.width * 0.1 , y: size.height * 0.6)
        ball.zPosition = 5
        ball.xScale = (size.height/size.width * 0.6)
        ball.yScale = (size.height/size.width * 0.6)
        addChild(ball)
        let cycleTime = SKAction.animate(with:blimbleeTexture, timePerFrame: 0.1)
        let repeatForever = SKAction.repeatForever(cycleTime)
        let group = SKAction.group([pathing, repeatForever])
        ball.run(group)
        
        
    }
    
    func placeSomething(){
        mokey = SKSpriteNode(imageNamed: "pim")
        mokey.name = String(numPlaced)
        
    }
  
    
    
}
