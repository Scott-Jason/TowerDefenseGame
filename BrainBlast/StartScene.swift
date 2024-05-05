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
        
        // Start Game Button
        let startButton = SKSpriteNode(color: SKColor.green, size: CGSize(width: 200, height: 100))
        startButton.name = "startButton"
        startButton.position = CGPoint(x: size.width / 2, y: size.height * 0.3)
        addChild(startButton)
        
        let buttonText = SKLabelNode(fontNamed: "Invasion2000")
        buttonText.text = "Start Game"
        buttonText.fontColor = SKColor.white
        buttonText.position = CGPoint(x: 0, y: -15)
        startButton.addChild(buttonText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "startButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = Game(size: self.size)
                gameScene.scaleMode = .aspectFill
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}

