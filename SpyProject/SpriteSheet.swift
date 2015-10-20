//
//  SpriteSheet.swift
//  spyGame
//
//  Created by Avelina Kim on 10/6/15.
//  Copyright (c) 2015 SMC_CPC. All rights reserved.
//

import SpriteKit

//Utility class for turning a single spritesheet image into multiple sprites
//because the built in 'texture atlases' suck and most placeholder art is
//in the form of one single spritesheet.
class SpriteSheet {
    
    ///TODO: allow setting of margins/spacing between cells
    var sheetTexture : SKTexture
    var rows : Int
    var cols : Int
    var width : CGFloat = 0
    var height : CGFloat = 0
    
    init(texture: SKTexture, rows: Int, cols: Int){
        self.sheetTexture = texture
        self.rows = rows
        self.cols = cols
        setWidthAndHeight()
    }
    
    init(imageName: String, rows: Int, cols: Int){
        self.sheetTexture = SKTexture(imageNamed: imageName)
        self.rows = rows
        self.cols = cols
        setWidthAndHeight()
    }
    
    func setWidthAndHeight(){
        self.width = 1.0/CGFloat(cols)
        self.height = 1.0/CGFloat(rows)
    }
    
    func getSprite(x: Int, _ y: Int) -> SKTexture?{
        if x >= cols || y >= rows {
            return nil
        }else{
            let startX = CGFloat(x) * width
            let startY = CGFloat(y) * height
            return SKTexture(rect:CGRectMake(startX, startY, width, height), inTexture:sheetTexture)
        }
    }
}

