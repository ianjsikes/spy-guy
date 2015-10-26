//
//  LaserBlast.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/25/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit

class LaserBlast : SKSpriteNode {
    
    let movingRight : Bool = true
    
    init() {
        //No image named laser-blast yet
        let tex = SKTexture(imageNamed: "laser-blast")
        super.init(texture: tex, color: UIColor.whiteColor(), size: tex.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}