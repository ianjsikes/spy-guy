//
//  PlayerNode.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/11/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

///Acts as the parent node for the actor
class ActorNode: SKNode, CollisionHandler {
    let spriteSheet = SpriteSheet(imageName: "spritesheet_players", rows: 8, cols: 8)
    //The state machine that manages the actor's behaviors
    var actorStateMachine : GKStateMachine
    var actorSprite : SKSpriteNode
    var actorBody : SKPhysicsBody
    
    //Actor keeps track of it's own physics-independent velocity
    //Used for precise actor movement
    var actorVelocity : CGVector = CGVectorMake(0.0, 0.0)
    var isGrounded : Bool = false
    var isFacingRight : Bool = true
    
    //DEBUG SETTINGS
    //State machine will print all state changes to console
    var stateDebug : Bool = false
    
    override init() {
        actorStateMachine = GKStateMachine(states: [])
        actorSprite = SKSpriteNode(texture: spriteSheet.getSprite(0, 0))
        
        //Initialize actor's physics body
        //Just plugged in random values until something worked
        //Going to be a nightmare to change when we change the actor's sprite
        actorBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 75), center: CGPointMake(0.0, -25.0))
        actorBody.mass = CGFloat(0.3)
        actorBody.allowsRotation = false
        
        //The actor and everything else need to have 'restitution' set to 0.0
        //otherwise the actor will bounce off of things and not behave properly
        actorBody.restitution = CGFloat(0.0)
        actorBody.categoryBitMask = BodyType.player.rawValue
        
        //Sets the actor to trigger the "contactBegin" and "contactEnd" functions
        //When colliding with an object of the 'ground' type
        actorBody.contactTestBitMask = BodyType.ground.rawValue | BodyType.enemy.rawValue
        super.init()
        
        //Make the actor smaller
        self.setScale(CGFloat(0.5))
        
        self.physicsBody = actorBody;

        //Instantiate the actor's state machine, using an array of all possible states
        actorStateMachine = GKStateMachine(states: [IdleState(actor: self),
                                                RunningState(actor: self,
                                                             animation:[spriteSheet.getSprite(0, 6)!,
                                                                        spriteSheet.getSprite(0, 5)!,
                                                                        spriteSheet.getSprite(0, 7)!,
                                                                        spriteSheet.getSprite(0, 4)!])])
        actorStateMachine.enterState(IdleState)
        
        
        
        self.addChild(actorSprite)
    }
    
    //Is called every frame
    func updateWithDeltaTime(seconds: NSTimeInterval) {
        
        //The state machine lets the actor's current state handle updates
        actorStateMachine.updateWithDeltaTime(seconds)
        
        self.position.x += actorVelocity.dx
        //self.position.y += pVelocity.dy
    }
    
    func didBeginContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        
        switch(otherBody.categoryBitMask){
        case BodyType.ground.rawValue:
            if contact.contactNormal.dy > CGFloat(0.8) {
                self.isGrounded = true
            }
        case BodyType.enemy.rawValue:
            if let gameScene = self.scene as? GameScene {
                gameScene.resetScene()
            }
        default:
            return
        }
        
    }
    func didEndContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact) {
        
//        switch(otherBody.categoryBitMask){
//        case BodyType.ground.rawValue:
//            print("Left the ground")
//        default:
//            return
//        }
    }
    
    //Flips the orientation of the sprite if the actor turns around.
    func setFacingRight(val: Bool) {
        if val != isFacingRight {
            self.actorSprite.xScale *= CGFloat(-1.0)
        }
        isFacingRight = val
    }
    
    //Applies a physics impulse upwards
    func jump() {
        if isGrounded {
            //print("Jumping")
            actorBody.applyImpulse(CGVector(dx: 0.0, dy: 200.0))
            isGrounded = false
        }
    }

    
    //Stupid required initializer, please ignore
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}