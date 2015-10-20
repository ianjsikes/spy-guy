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

///Acts as the parent node for the player
class PlayerNode: SKNode {
    let spriteSheet = SpriteSheet(imageName: "spritesheet_players", rows: 8, cols: 8)
    //The state machine that manages the player's behaviors
    var pStateMachine : GKStateMachine
    var pSprite : SKSpriteNode
    var pBody : SKPhysicsBody
    
    //Player keeps track of it's own physics-independent velocity
    //Used for precise player movement
    var pVelocity : CGVector = CGVectorMake(0.0, 0.0)
    var isGrounded : Bool = false
    var isFacingRight : Bool = true
    
    //DEBUG SETTINGS
    //State machine will print all state changes to console
    var stateDebug : Bool = false
    
    override init() {
        pStateMachine = GKStateMachine(states: [])
        pSprite = SKSpriteNode(texture: spriteSheet.getSprite(0, 0))
        
        //Initialize player's physics body
        pBody = SKPhysicsBody(rectangleOfSize: CGSize(width: pSprite.size.width/2.0, height: pSprite.size.height/2.0))
        pBody.allowsRotation = false
        
        //The player and everything else need to have 'restitution' set to 0.0
        //otherwise the player will bounce off of things and not behave properly
        pBody.restitution = CGFloat(0.0)
        pBody.categoryBitMask = BodyType.player.rawValue
        
        //Sets the player to trigger the "contactBegin" and "contactEnd" functions
        //When colliding with an object of the 'ground' type
        pBody.contactTestBitMask = BodyType.ground.rawValue
        super.init()
        
        //Make the player smaller
        self.setScale(CGFloat(0.5))
        
        self.physicsBody = pBody;
        //pBody.mass = CGFloat(1.0)

        //Instantiate the player's state machine, using an array of all possible states
        pStateMachine = GKStateMachine(states: [IdleState(player: self),
                                                RunningState(player: self,
                                                             animation:[spriteSheet.getSprite(0, 6)!,
                                                                        spriteSheet.getSprite(0, 5)!,
                                                                        spriteSheet.getSprite(0, 7)!,
                                                                        spriteSheet.getSprite(0, 4)!])])
        pStateMachine.enterState(IdleState)
        
        
        
        self.addChild(pSprite)
    }
    
    //Is called every frame
    func updateWithDeltaTime(seconds: NSTimeInterval) {
        
        //The state machine lets the player's current state handle updates
        pStateMachine.updateWithDeltaTime(seconds)
        
        self.position.x += pVelocity.dx
        //self.position.y += pVelocity.dy
    }
    
    //Flips the orientation of the sprite if the player turns around.
    func setFacingRight(val: Bool) {
        if val != isFacingRight {
            self.pSprite.xScale *= CGFloat(-1.0)
        }
        isFacingRight = val
    }
    
    //Applies a physics impulse upwards
    func jump() {
        if isGrounded {
            //print("Jumping")
            pBody.applyImpulse(CGVector(dx: 0.0, dy: 200.0))
            isGrounded = false
        }
    }

    
    //Stupid required initializer, please ignore
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}