//
//  CollisionHandler.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/19/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit

protocol CollisionHandler {
    func didBeginContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact)
    
    func didEndContact(otherBody: SKPhysicsBody, contact: SKPhysicsContact)
}