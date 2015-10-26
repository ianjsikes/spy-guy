//
//  LaserGadget.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/25/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit

class LaserGadget: Gadget {
    var player: PlayerNode
    var icon: SKTexture
    
    init(player: PlayerNode) {
        self.player = player
        self.icon = SKTexture(imageNamed: "laser-watch-icon")
        self.icon.filteringMode = SKTextureFilteringMode.Nearest
    }
    
    func activate() {
        print("pew")
        let tex = SKTexture(imageNamed: "laser-blast")
        let laser = SKSpriteNode(texture: tex)
        laser.position = player.position
        let laserBody = SKPhysicsBody(rectangleOfSize: tex.size())
        laserBody.affectedByGravity = false
        laserBody.allowsRotation = false
        laserBody.categoryBitMask = BodyType.laser.rawValue
        laserBody.contactTestBitMask = BodyType.enemy.rawValue
        
        laser.physicsBody = laserBody
        player.parent!.addChild(laser)
        laser.runAction(SKAction.repeatActionForever(SKAction.moveByX(CGFloat(100.0), y: CGFloat(0.0), duration: 0.1)))
    }
}
