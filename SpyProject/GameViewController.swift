//
//  GameViewController.swift
//  SpyProject
//
//  Created by Avelina Kim on 10/10/15.
//  Copyright (c) 2015 SMC_CPC. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Why isn't this default? QQ
        self.view.multipleTouchEnabled = true
        
        let sizeRect = UIScreen.mainScreen().bounds
        let width = sizeRect.size.width * UIScreen.mainScreen().scale
        let height = sizeRect.size.height * UIScreen.mainScreen().scale

        if let scene = GameScene(fileNamed:"GameScene") {
            //scene.anchorPoint = CGPointMake(0.0, 0.0)
            
            // Configure the view.
            let skView = self.view as! SKView
            
            //Set the scene's size to the size of the device
            scene.size = CGSizeMake(width, height)
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            //DEBUG
//            skView.showsPhysics = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
