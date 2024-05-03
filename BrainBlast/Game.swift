//
//  Game.swift
//  BrainBlast
//
//  Created by Jason Scott on 4/12/24.
//


//two functions for how the towers look at the enemies

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

    //self explanatory things sprite speed is how fast, spawn num how many enemies
var gameTime = 0
var moneyAmt = 25
var roundNum = 0
var livess = 40
var spriteSpeed = 250.0
var spawnNum = 0



//whether current obj is placed or not delete maybe
var numPlaced = 0
var placed = true
var active = false

class Game: SKScene {
    
    
    var towerArr = [towers]()
    var ball = SKSpriteNode(imageNamed: "ball")
    var pathing = SKAction()
    //types of defense stuff
    var mokey = SKSpriteNode()
    var newTower = towers()
    var currentTower: towers?
    var zone = SKSpriteNode()
    let spikeM = SKSpriteNode()
    let superM = SKSpriteNode()
  
    var button = SKSpriteNode()
    var startButton = SKSpriteNode()
    
    //labels
    var moneyLabel = SKLabelNode(fontNamed: "Chalkduster")
    var roundLabel = SKLabelNode(fontNamed: "Copperplate")
    var livesLabel = SKLabelNode(fontNamed: "Copperplate")

    
    
    let blimTex2: [SKTexture] = [
        SKTexture(imageNamed: "a1"),
        SKTexture(imageNamed: "a2")
    ]
    
    //blimblee running loop
    let blimbleeTexture: [SKTexture] = [
        SKTexture(imageNamed: "b1"),
        SKTexture(imageNamed: "b2")
      ]
    
    //stuff that happens once at launch
    override func sceneDidLoad() {
        
        
     
        //fixed code for how the enemies move throughout the background
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
            //touchedNode gets access to the node that was just touched
            
            
            
            //how many bloons spawn depending on what round it is!
            for tower in towerArr{
                if touchedNode == tower.tower{
                    tower.range.alpha = 0.5
                    
                    //handle upgrades and shit here
                    print("YES!")
                }
            }
           
            if (touchedNode.name == "buyPim" && moneyAmt >= 10) {
                moneyAmt -= 10
                placed = false
                newTower = towers()
                
                newTower.tower = SKSpriteNode(imageNamed: "pim")
                newTower.tower.zPosition = 5
                newTower.tower.xScale = (size.height/size.width * 1)
                newTower.tower.yScale = (size.height/size.width * 1)
                addChild(newTower.tower)
                newTower.range = SKSpriteNode(imageNamed: "zone")
                newTower.range.zPosition = 4
                newTower.range.alpha = 0.5
                newTower.range.xScale = (size.height/size.width * 1.4)
                newTower.range.yScale = (size.height/size.width * 1.4)
                addChild(newTower.range)
                towerArr.append(newTower)
                
                
                
            }
            
            if (touchedNode.name == "buyBoss" && moneyAmt >= 10) {
                moneyAmt -= 10
                placed = false
                newTower = towers()
                newTower.bulletSpeed = 0.12
                newTower.tower = SKSpriteNode(imageNamed: "boss")
                newTower.tower.zPosition = 5
                newTower.tower.xScale = (size.height/size.width * 1)
                newTower.tower.yScale = (size.height/size.width * 1)
                addChild(newTower.tower)
                newTower.range = SKSpriteNode(imageNamed: "zone")
                newTower.range.zPosition = 4
                newTower.range.alpha = 0.5
                newTower.range.xScale = (size.height/size.width * 1.4)
                newTower.range.yScale = (size.height/size.width * 1.4)
                addChild(newTower.range)
                towerArr.append(newTower)
                
                
                
            }
            
            
            if touchedNode == startButton { //User pressed start roudnd button
                roundNum += 1
                print("test")
                switch roundNum{
                case 1:
                    spawnNum = 5
                case 2:
                    spawnNum = 10
                case 3:
                    spawnNum = 20
                case 4:
                    spawnNum = 40
                default:
                    print("yipee")
                }
            }
            if touchedNode == button{
                for tower in towerArr{
                    tower.range.alpha = 0.001
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           for touch in touches {
               let location = touch.location(in: self)
               
               // Update the position of the cloned node to follow the touch
               if(placed == false){
                   newTower.tower.position = location
                   newTower.range.position = location
                   print(newTower.tower.position.x)
               }
           }
       }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        if(placed == false){
            newTower.range.alpha = 0.001
        }
        placed = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    //where balloons spawn and despawn
    override func update(_ currentTime: TimeInterval) {
        gameTime += 1
        //labels updating
        moneyLabel.text = "Money = \(moneyAmt)"
        roundLabel.text = "Round = \(roundNum)"
        livesLabel.text = "Lives = \(livess)"
        
     
        
        if(spawnNum > 0 && gameTime % 15 == 0){
            makeBalloon()
            spawnNum -= 1
        }
        
        // ballons getting to the end, scans children in the node and if their height less than certiain value deletes from scene and decrements lives.
        //shouldnt have named these variables so similar sorry!
        //basically going through each enemy and seeing if it intersects with a tower
        for nodes in self.children {
            if let balloonNode = nodes as? SKSpriteNode, balloonNode.name == "enemy"{
                
                for tower in towerArr{
                    
                    
                    if(balloonNode.intersects(tower.range)){
                        tower.tower.lookAtNode(balloonNode)
                        tower.shoot(enemy: balloonNode, scene: self)
                       // balloonNode.removeFromParent()
                    }
                    if(tower.bulletAllowed == false){
                        tower.bulletWork(enemy: balloonNode)
                    }
                }
                
                
                if(balloonNode.position.y <= size.height * 0.01){
                    print("YES")
                    balloonNode.removeFromParent()
                    livess -= 1
                    
                    
                }
            }
        }
        
       
        
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
        
        //this was just for pathing, like how far each should move thing
        let g = SKSpriteNode(imageNamed:"grid")
        g.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        g.zPosition = 2
        g.xScale = 3.54
        g.yScale = 1.62
        g.alpha = 0.3
       // addChild(g) (not shown)
        
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
        
        // money label
        moneyLabel.text = "Money = \(moneyAmt)"
        moneyLabel.zPosition = 5
        moneyLabel.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.83)
        addChild(moneyLabel)
        
        // round label
        roundLabel.text = "Round = \(roundNum)"
        roundLabel.zPosition = 5
        roundLabel.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.74)
        addChild(roundLabel)
        
        // lives label
        livesLabel.text = "Lives = \(livess)"
        livesLabel.zPosition = 5
        livesLabel.position = CGPoint(x: size.width * 0.88 , y: size.height * 0.65)
        addChild(livesLabel)
        
        
        let pimTower = SKSpriteNode(imageNamed: "pim")
        pimTower.name = "buyPim"
        pimTower.position = CGPoint(x:size.width * 0.81, y: size.height * 0.55)
        pimTower.zPosition = 5
        pimTower.xScale = (size.height/size.width * 1)
        pimTower.yScale = (size.height/size.width * 1)
        addChild(pimTower)
        let pimLabel = SKLabelNode(text: "costs 10")
        pimLabel.zPosition = 5
        pimLabel.position = CGPoint(x:size.width * 0.81, y: size.height * 0.46)
        pimLabel.fontSize = 15
        pimLabel.fontName = "Times New Roman"
        addChild(pimLabel)
        
        let bossTower = SKSpriteNode(imageNamed: "boss")
        bossTower.name = "buyBoss"
        bossTower.position = CGPoint(x:size.width * 0.92, y: size.height * 0.55)
        bossTower.zPosition = 5
        bossTower.xScale = (size.height/size.width * 1)
        bossTower.yScale = (size.height/size.width * 1)
        addChild(bossTower)
        let bossLabel = SKLabelNode(text: "costs 30")
        bossLabel.zPosition = 5
        bossLabel.position = CGPoint(x:size.width * 0.92, y: size.height * 0.46)
        bossLabel.fontSize = 15
        bossLabel.fontName = "Times New Roman"
        addChild(bossLabel)
        
        
    }
    
    func makeButtonNode(){
        button = SKSpriteNode(imageNamed: "real")
        button.position = CGPoint(x:size.width * 0.8, y: size.height * 0.15)
        button.zPosition = 5
        button.name = "back"
        button.setScale(size.height/size.width * 0.2)
        addChild(button)
        
        // make code that makes a button to toggle a monkey menu of sorts
        //thing to the right of bloons where you can buy and hover over stuff.
    }
    
    func makeStartButtonNode(){
        startButton = SKSpriteNode(imageNamed: "start")
        startButton.zPosition = 5
        startButton.name = "start"
        startButton.position = CGPoint(x:size.width * 0.88, y: size.height * 0.15)
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
        ball.name = "enemy"
        ball.alpha = 1.0
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
    
  
}
