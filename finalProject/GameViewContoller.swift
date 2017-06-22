//
//  GameViewContoller.swift
//  finalProject
//
//  Created by Pavel on 2016-04-03.
//  Copyright © 2016 cs2680. All rights reserved.
//

import Foundation
import SpriteKit



class GameViewContoller: UIViewController
{
    var level : Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let skView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        // Configure the view.
        //let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Initialize the Scene
        let scene = GameScene()
        scene.gameLevel = level
        scene.size = skView.bounds.size
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool
    {
        return true
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
}

