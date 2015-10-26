//
//  Gadget.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/25/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit

enum GadgetType {
    case Laser
    case GrapplingHook
}

protocol Gadget {
    var player: PlayerNode { get set }
    var icon: SKTexture { get set }
    func activate()
}