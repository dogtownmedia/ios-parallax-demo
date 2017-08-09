//
//  PBParallaxScrolling.swift
//  ParallaxBackgroundSwift
//
//  Created by Justin Hall on 8/8/17.
//  Copyright © 2017 jhall. All rights reserved.
//

import Foundation
import SpriteKit

class ParallaxScrolling: SKSpriteNode {
    
    let flickeringAdjustment: CGFloat = 0.05
    
    var backgrounds: [SKSpriteNode]
    var clonedBackgrounds: [SKSpriteNode]
    var speeds: [CGFloat]
    var numberOfBackgrounds = 0
    var scrollingDirection: ParallaxBackgroundDirection
    
    init?(backgroundImages: [UIImage], size: CGSize, scrollingDirection: ParallaxBackgroundDirection, startingSpeed: CGFloat, speedDecreaseFactor: CGFloat) {
        self.backgrounds = []
        self.clonedBackgrounds = []
        self.speeds = []
        self.numberOfBackgrounds = backgroundImages.count
        self.scrollingDirection = scrollingDirection
        super.init(texture: nil, color:UIColor.clear, size: size)
        
        let zPos = 1.0 / CGFloat(numberOfBackgrounds)
        var currentSpeed = startingSpeed
        self.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.zPosition = -100
        
        for (index, image) in backgroundImages.enumerated() {
            let background = SKSpriteNode(texture: SKTexture(cgImage: image.cgImage!), size:size)
            
            background.zPosition = self.zPosition - (zPos + (zPos * CGFloat(index)))
            background.position = CGPoint(x: 0.0, y: 0.0)
            guard let clonedBackground = background.copy() as? SKSpriteNode else { return }
            var clonedBackgroundX = background.position.x
            var clonedBackgroundY = background.position.y
            
            switch scrollingDirection {
            case .right:
                clonedBackgroundX = -background.size.width
            case .left:
                clonedBackgroundX = background.size.width
            case .up:
                clonedBackgroundY = -background.size.height
            case .down:
                clonedBackgroundY = background.size.height
            }
            
            clonedBackground.position = CGPoint(x: clonedBackgroundX,y: clonedBackgroundY)
            backgrounds.append(background)
            clonedBackgrounds.append(clonedBackground)
            speeds.append(currentSpeed)
            
            // Decrease speed
            currentSpeed = currentSpeed / speedDecreaseFactor
            
            // Add backgrounds as childs to this node
            self.addChild(background)
            self.addChild(clonedBackground)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reverseMovementDirection() {
        var newDirection: ParallaxBackgroundDirection = scrollingDirection
        switch scrollingDirection {
        case .down:
            newDirection = .up
            break
        case .up:
            newDirection = .down
            break
        case .left:
            newDirection = .right
            break
        case .right:
            newDirection = .left
            break
        }
        self.scrollingDirection = newDirection
    }
    
    func updateTime() {
        for i in 0..<numberOfBackgrounds {
            let speed = self.speeds[i]
            let background = self.backgrounds[i]
            let clonedBackground = self.clonedBackgrounds[i]
            
            var adjustedBackgroundX = background.position.x
            var adjustedBackgroundY = background.position.y
            var adjustedClonedBackgroundX = clonedBackground.position.x
            var adjustedClonedBackgroundY = clonedBackground.position.y

            switch self.scrollingDirection {
            case .right:
                adjustedBackgroundX += speed
                adjustedClonedBackgroundX += speed
                
                if (adjustedBackgroundX >= background.size.width) {
                    adjustedBackgroundX = adjustedBackgroundX - 2 * background.size.width + flickeringAdjustment
                }
                if (adjustedClonedBackgroundX >= clonedBackground.size.width) {
                    adjustedClonedBackgroundX = adjustedClonedBackgroundX - 2 * clonedBackground.size.width + flickeringAdjustment
                }
            case .left:
                adjustedBackgroundX -= speed
                adjustedClonedBackgroundX -= speed
                
                if (adjustedBackgroundX <= -self.size.width) {
                    adjustedBackgroundX = adjustedBackgroundX + 2 * self.size.width - flickeringAdjustment
                }
                if adjustedClonedBackgroundX <= -self.size.width {
                    adjustedClonedBackgroundX = adjustedClonedBackgroundX + 2 * self.size.width - flickeringAdjustment
                }
            case .up:
                adjustedBackgroundY += speed
                adjustedBackgroundY += speed
                
                if adjustedBackgroundY >= background.size.height {
                    adjustedBackgroundY = adjustedBackgroundY - 2 * background.size.height + flickeringAdjustment
                }
                if adjustedClonedBackgroundY >= clonedBackground.size.height {
                    adjustedClonedBackgroundY = adjustedClonedBackgroundY - 2 * clonedBackground.size.height + flickeringAdjustment
                }
            case .down:
                adjustedBackgroundY -= speed // need to just be minus
                adjustedClonedBackgroundY -= speed // need to just be minus?
                
                if (adjustedBackgroundY <= -self.size.height) {
                    adjustedBackgroundY = adjustedBackgroundY + 2 * self.size.height - flickeringAdjustment
                }
                if adjustedClonedBackgroundY <= -self.size.height {
                    adjustedClonedBackgroundY = adjustedClonedBackgroundY + 2 * self.size.height - flickeringAdjustment
                }
            }
            background.position = CGPoint(x: adjustedBackgroundX, y: adjustedBackgroundY)
            clonedBackground.position = CGPoint(x: adjustedClonedBackgroundX, y: adjustedClonedBackgroundY)
        }
    }
    
}
