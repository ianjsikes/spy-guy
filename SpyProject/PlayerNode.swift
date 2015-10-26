//
//  PlayerNode.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/25/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerNode: ActorNode {
    var gadgets : [GadgetType:Gadget] = [:]
    var currentGadget : Gadget? = nil
    
    override init() {
        super.init()
        gadgets = [GadgetType.Laser : LaserGadget(player: self)]
        currentGadget = gadgets[GadgetType.Laser]!
    }
    
    func useGadget() {
        currentGadget!.activate()
    }
}