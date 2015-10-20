//
//  ButtonNode.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/11/15.
//  Copyright © 2015 SMC_CPC. All rights reserved.
//

import Foundation
import SpriteKit

//To be honest, I copied most of this from a tutorial
//So it might not make any sense
class ButtonNode: SKNode {
    //The image to display by default
    var defaultButton: SKSpriteNode
    //The image displayed when the button is pressed
    var activeButton: SKSpriteNode
    //Probably not necessary
    var currTouch: UITouch? = nil
    
    //The functions (or 'closures' or whatever swift calls them) the button will call
    //when pressed down and released, respectively
    var downAction: () -> Void
    var upAction: () -> Void
    
    init(defaultButtonImage: String, activeButtonImage: String, downAction: () -> Void, upAction: () -> Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.hidden = true
        self.downAction = downAction
        self.upAction = upAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    init(defaultButtonTexture: SKTexture, activeButtonTexture: SKTexture, downAction: () -> Void, upAction: () -> Void) {
        defaultButton = SKSpriteNode(texture: defaultButtonTexture)
        activeButton = SKSpriteNode(texture: activeButtonTexture)
        activeButton.hidden = true
        self.downAction = downAction
        self.upAction = upAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    
    //Calls the downAction method if the button is pressed
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if defaultButton.containsPoint(touch.locationInNode(self)) {
                currTouch = touch
                activeButton.hidden = false
                defaultButton.hidden = true
                downAction()
                return
            }
        }
    }
    
    //Calls the upAction method if the touch moves off of the button
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if touch == currTouch {
                if defaultButton.containsPoint(touch.locationInNode(self)) {
                    activeButton.hidden = false
                    defaultButton.hidden = true
                } else {
                    activeButton.hidden = true
                    defaultButton.hidden = false
                    upAction()
                    currTouch = nil
                }
                return
            }
            
        }
    }
    
    
    //Calls the upAction method if the touch is released off the button
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if touch == currTouch {
                if defaultButton.containsPoint(touch.locationInNode(self)) {
                    upAction()
                }
                
                activeButton.hidden = true
                defaultButton.hidden = false
                currTouch = nil
                return
            }
        }
        
        //I replaced this perfectly fine code with some hacky stuff to try to get multitouch to work
        //But it turns out multitouch worked fine before I changed anything
        //And now I'm scared to change it back in case it stops working for some reason.
        
//        let touch: UITouch = touches.first! as UITouch
//        let location: CGPoint = touch.locationInNode(self)
//        
//        if defaultButton.containsPoint(location) {
//            upAction()
//        }
//        
//        activeButton.hidden = true
//        defaultButton.hidden = false
        
    }
    
    /**
    Required to get rid of warnings
    */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}