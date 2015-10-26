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
    case anotherBody2 = 8
    case anotherBody3 = 16
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var timeAtLastUpdate : NSTimeInterval = 0
    var deltaTime : NSTimeInterval = 0.0
    let player = PlayerNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.contactDelegate = self
        
        //Camera Stuff
        let cam = SKCameraNode()
        cam.setScale(CGFloat(2.0))
        
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
                                 upAction: { () in player.actorStateMachine.enterState(IdleState)})
        btnLeft.position = CGPointMake(-400, -200)
        
        
        let btnRight = ButtonNode(defaultButtonImage: "btn_right_circle_dark",
                                  activeButtonImage: "btn_right_circle_light",
                                  downAction: { () in self.player.setFacingRight(true);
                                                      self.player.actorStateMachine.enterState(RunningState)},
                                  upAction: { () in player.actorStateMachine.enterState(IdleState)})
        btnRight.position = CGPointMake(-200, -200)
        
        let btnUp = ButtonNode(defaultButtonImage: "btn_up_circle_dark",
            activeButtonImage: "btn_up_circle_light",
            downAction: { () in self.player.jump()},
            upAction: {})
        btnUp.position = CGPointMake(400, -200)
        
        let btnReset = ButtonNode(defaultButtonImage: "btn_cancel_circle_dark",
            activeButtonImage: "btn_cancel_circle_light",
            downAction: { () in self.resetScene()},
            upAction: {})
        btnReset.position = CGPointMake(400, 300)
        
        
        //End Button Stuff
                
        
        self.addChild(bg)
        self.addChild(player)
        player.addChild(cam)
        cam.addChild(btnLeft)
        cam.addChild(btnRight)
        cam.addChild(btnUp)
        cam.addChild(btnReset)
        
        self.scene!.camera = cam
        
        //Enemies
        let badGuy1 = EnemyNode()
        self.addChild(badGuy1)
        badGuy1.position = CGPointMake(700, 900)
        
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
