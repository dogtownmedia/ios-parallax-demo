//
//  ViewController.swift
//  ParallaxBackgroundSwift
//
//  Created by Justin Hall on 8/8/17.
//  Copyright © 2017 jhall. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    var scrollingDirection: ParallaxBackgroundDirection?
    
    override func viewWillLayoutSubviews() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        guard let direction = scrollingDirection else { return }
        
        let scene = ParallaxScene(
            size: skView.bounds.size,
            scrollingDirection: direction,
            startingSpeed: 4.0, // change this to increase/decrease overall speed
            speedDecreaseFactor: 2.2) // change this increase/decrease speed decrease between layers
        scene.scaleMode = .aspectFit
        
        skView.presentScene(scene)
    }
    
    override var shouldAutorotate: Bool { return true }
    override var prefersStatusBarHidden: Bool { return true }
    
}

