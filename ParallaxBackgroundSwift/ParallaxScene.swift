//
//  PBMyScene.swift
//  ParallaxBackgroundSwift
//
//  Created by Justin Hall on 8/8/17.
//  Copyright © 2017 jhall. All rights reserved.
//

import UIKit
import SpriteKit

class ParallaxScene: SKScene {
    
    var parallaxBackground: ParallaxScrolling
    
    init(size: CGSize, scrollingDirection: ParallaxBackgroundDirection, startingSpeed: CGFloat, speedDecreaseFactor: CGFloat) {
        var images = [UIImage]()
        if scrollingDirection == .up || scrollingDirection == .down {
            images = [#imageLiteral(resourceName: "pForegroundVertical.png"), #imageLiteral(resourceName: "pMiddleVertical.png"), #imageLiteral(resourceName: "pBackgroundVertical.png")]
        } else {
            images = [#imageLiteral(resourceName: "pGraph.png"),#imageLiteral(resourceName: "pForegroundHorizontal.png"), #imageLiteral(resourceName: "pMiddleHorizontal.png"), #imageLiteral(resourceName: "pBackgroundHorizontal.png")]
        }
        
        self.parallaxBackground = ParallaxScrolling(
            backgroundImages: images,
            size: size,
            scrollingDirection: scrollingDirection,
            startingSpeed:startingSpeed,
            speedDecreaseFactor: speedDecreaseFactor)!
        
        super.init(size: size)
        
        self.addChild(parallaxBackground)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        parallaxBackground.reverseMovementDirection()
    }
    
    override func update(_ currentTime: TimeInterval) {
        parallaxBackground.updateTime()
    }

}
