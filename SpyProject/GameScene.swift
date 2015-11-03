//
//  GameScene.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/10/15.
//  Copyright (c) 2015 SMC_CPC. All rights reserved.
//

import SpriteKit

//Used to define values for the collision/category bit masks
//Must be power-of-two values
enum BodyType:UInt32 {
    
    case player = 1
    case ground = 2
    case enemy = 4
    case laser = 8
    case anotherBody3 = 16
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var timeAtLastUpdate : NSTimeInterval = 0
    var deltaTime : NSTimeInterval = 0.0
    let player = PlayerNode()
    
    let badGuy1 : EnemyNode = EnemyNode(target: nil, position: CGPointMake(700, 900))
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        badGuy1.target = player
        
        physicsWorld.contactDelegate = self
        
        //Camera Stuff
        let cam = SKCameraNode()
        cam.setScale(CGFloat(2.0))
        
        self.scene!.camera = cam
        
        //Background Stuff
        let bg = SKSpriteNode(imageNamed: "city")
        bg.position = CGPointMake(2295.274, 149.994)
        bg.size = CGSize(width: 5039.999, height: 1260)
        bg.zPosition = -5
        bg.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        //Player Stuff
        //player.position = CGPointMake(self.size.width/2, self.size.height)
        if let playerSpawn = self.childNodeWithName("playerSpawn") {
            player.position = playerSpawn.position
        }
        
        //Button stuff
        
        
        let btnLeft = ButtonNode(defaultButtonImage: "btn_left_circle_dark",
                                 activeButtonImage: "btn_left_circle_light",
                                 downAction: { () in self.player.setFacingRight(false);
                                                     self.player.actorStateMachine.enterState(RunningState)},
                                 upAction: { () in self.player.actorStateMachine.enterState(IdleState)})
        btnLeft.position = scaledScreenPosition(x: 0.1, y: 0.1)
        
        
        let btnRight = ButtonNode(defaultButtonImage: "btn_right_circle_dark",
                                  activeButtonImage: "btn_right_circle_light",
                                  downAction: { () in self.player.setFacingRight(true);
                                                      self.player.actorStateMachine.enterState(RunningState)},
                                  upAction: { () in self.player.actorStateMachine.enterState(IdleState)})
        btnRight.position = scaledScreenPosition(x: 0.25, y: 0.1)
        
        let btnUp = ButtonNode(defaultButtonImage: "btn_up_circle_dark",
            activeButtonImage: "btn_up_circle_light",
            downAction: { () in self.player.jump()},
            upAction: {})
        btnUp.position = scaledScreenPosition(x: 0.9, y: 0.1)
        
        let btnReset = ButtonNode(defaultButtonImage: "btn_cancel_circle_dark",
            activeButtonImage: "btn_cancel_circle_light",
            downAction: { () in self.resetScene()},
            upAction: {})
        btnReset.position = scaledScreenPosition(x: 0.9, y: 0.9)
        
        let btnGadget = ButtonNode(defaultButtonTexture: (player.currentGadget?.icon)!, activeButtonTexture: (player.currentGadget?.icon)!, downAction: { () in self.player.useGadget() }, upAction: {} )
        btnGadget.position = scaledScreenPosition(x: 0.9, y: 0.3)
        btnGadget.setScale(CGFloat(2.0))
        btnGadget.zPosition = 5.0
        
        
        //End Button Stuff
        
        self.addChild(bg)
        self.addChild(player)
        player.addChild(cam)
        cam.addChild(btnLeft)
        cam.addChild(btnRight)
        cam.addChild(btnUp)
        cam.addChild(btnReset)
        cam.addChild(btnGadget)
        
        
        
        //Enemies
        
        badGuy1.position = CGPointMake(700, 900)
        self.addChild(badGuy1)
        self.badGuy1.actorStateMachine.enterState(PatrollingState)
        
}
    
    func scaledScreenPosition(x x : CGFloat, y : CGFloat) -> CGPoint {
        let scaledX = (x * self.frame.width) - (self.frame.midX)
        let scaledY = (y * self.frame.height) - (self.frame.midY)
        
        return CGPointMake(scaledX, scaledY)
    }
    
    //This gets called automatically when two objects begin contact with eachother
    func didBeginContact(contact: SKPhysicsContact) {
        //If one of the bodies implements the CollisionHandler protocol,
        //pass the contact event down to it.
        if let handler = contact.bodyA.node! as? CollisionHandler {
            handler.didBeginContact(contact.bodyB, contact: contact)
        }
        if let handler = contact.bodyB.node! as? CollisionHandler {
            handler.didBeginContact(contact.bodyA, contact: contact)
        }
    }
    
    //This gets called automatically when two objects end contact with eachother
    func didEndContact(contact: SKPhysicsContact) {
        //If one of the bodies implements the CollisionHandler protocol,
        //pass the contact event down to it.
        if let handler = contact.bodyA.node! as? CollisionHandler {
            handler.didEndContact(contact.bodyB, contact: contact)
        }
        if let handler = contact.bodyB.node! as? CollisionHandler {
            handler.didEndContact(contact.bodyA, contact: contact)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        //The time in seconds since the last time this function was called.
        deltaTime = currentTime - timeAtLastUpdate
        timeAtLastUpdate = currentTime
        
        /* Called before each frame is rendered */
        player.updateWithDeltaTime(deltaTime)
        badGuy1.updateWithDeltaTime(deltaTime)
    }
    
    func resetScene(){
        self.scene?.removeAllChildren()
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            if let skView = self.scene?.view {
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFill
                
                skView.presentScene(scene)
            }
        }
    }
    
}
