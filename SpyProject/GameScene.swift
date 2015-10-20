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
    case anotherBody1 = 4
    case anotherBody2 = 8
    case anotherBody3 = 16
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var timeAtLastUpdate : NSTimeInterval = 0
    var deltaTime : NSTimeInterval = 0.0
    let player = ActorNode()
    
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
        player.position = CGPointMake(self.size.width/2, self.size.height)
        
        
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
        
        
        //End Button Stuff
        
        self.addChild(bg)
        self.addChild(player)
        player.addChild(cam)
        cam.addChild(btnLeft)
        cam.addChild(btnRight)
        cam.addChild(btnUp)
        
        self.scene!.camera = cam
        
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
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//       /* Called when a touch begins */
//        
//    }
   
    override func update(currentTime: CFTimeInterval) {
        //The time in seconds since the last time this function was called.
        deltaTime = currentTime - timeAtLastUpdate
        timeAtLastUpdate = currentTime
        
        /* Called before each frame is rendered */
        player.updateWithDeltaTime(deltaTime)
    }
}
