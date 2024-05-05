//
//  StartScene.swift
//  BrainBlast
//
//  Created by Mark McMahon on 5/5/24.
//

import SpriteKit

class StartScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        // Game Title
        let titleLabel = SKLabelNode(fontNamed: "Invasion2000")
        titleLabel.text = "Tower Defense Game"
        titleLabel.fontSize = 40
        titleLabel.fontColor = SKColor.black
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        addChild(titleLabel)
        
        let startButton = SKSpriteNode(imageNamed: "startButton2")
        startButton.name = "startButton2"
        startButton.position = CGPoint(x: size.width * 0.5 , y: size.height * 0.5)
        startButton.xScale = (size.height/size.width * 0.73)
        startButton.yScale = (size.height/size.width * 0.42)
        addChild(startButton)
        
        let review = SKLabelNode(fontNamed: "Invasion2000")
        review.text = "Real customer reviews:"
        review.fontSize = 20
        review.fontColor = SKColor.black
        review.position = CGPoint(x: size.width / 2, y: size.height * 0.3)
        addChild(review)
        
        
        let holy = SKLabelNode(fontNamed: "Invasion2000")
        holy.text = "Holy cow! This is so much fun! - Mike"
        holy.fontSize = 20
        holy.fontColor = SKColor.black
        holy.position = CGPoint(x: size.width / 2, y: size.height * 0.25)
        addChild(holy)
        
        
        let wow = SKLabelNode(fontNamed: "Invasion2000")
        wow.text = "Wow!!!!!! best game evrrrr - Mike"
        wow.fontSize = 20
        wow.fontColor = SKColor.black
        wow.position = CGPoint(x: size.width / 2, y: size.height * 0.2)
        addChild(wow)
        
        let bax = SKSpriteNode(imageNamed: "Baxter")
        bax.position = CGPoint(x: size.width * 0.85 , y: size.height * 0.5)
        bax.xScale = (size.height/size.width * 0.65)
        bax.yScale = (size.height/size.width * 0.25)
        addChild(bax)
        
        let bax2 = SKSpriteNode(imageNamed: "Baxter")
        bax2.position = CGPoint(x: size.width * 0.15 , y: size.height * 0.5)
        bax2.xScale = (size.height/size.width * 0.65)
        bax2.yScale = (size.height/size.width * 0.25)
        addChild(bax2)
        
        let review1 = SKSpriteNode(imageNamed: "review1")
        review1.position = CGPoint(x: size.width * 0.15 , y: size.height * 0.15)
        review1.xScale = (size.height/size.width * 0.65)
        review1.yScale = (size.height/size.width * 0.25)
        review1.xScale = (size.height/size.width * 0.73)
        review1.yScale = (size.height/size.width * 0.42)
        addChild(review1)
        
        let star = SKSpriteNode(imageNamed: "stars")
        star.position = CGPoint(x: size.width * 0.85 , y: size.height * 0.15)
        star.xScale = (size.height/size.width * 0.65)
        star.yScale = (size.height/size.width * 0.25)
        star.xScale = (size.height/size.width * 0.73)
        star.yScale = (size.height/size.width * 0.42)
        addChild(star)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if(touchedNode.name == "startButton2" || touchedNode.name == "Start Game Button") {
                let transition = SKTransition.flipHorizontal(withDuration: 1.0)
                let gameScene = Game(size: self.size)
                gameScene.scaleMode = .aspectFill
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}

