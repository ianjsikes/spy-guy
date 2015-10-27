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
        let lDir = player.isFacingRight ? LaserBlast.Direction.Right : LaserBlast.Direction.Left;
        let lPos = CGPoint(x: player.position.x + CGFloat(lDir.rawValue * 40), y: player.position.y - CGFloat(25))
        let laser = LaserBlast(dir: lDir,
                               velocity: CGFloat(100.0),
                               pos: lPos)
        player.parent!.addChild(laser)
    }
}
