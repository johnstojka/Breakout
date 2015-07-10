//
//  ViewController.swift
//  Breakout
//
//  Created by John Stojka  on 7/9/15.
//  Copyright © 2015 John Stojka . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()
    var paddle = UIView()
    var ball = UIView()
    var lives = 5
    var bricksArray : [UIView] = []
    
    @IBOutlet weak var livesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brickLoader()
        
        ball = UIView(frame: CGRectMake(view.center.x, view.center.y, 20, 20))
        ball.backgroundColor = UIColor.blueColor()
        ball.layer.cornerRadius = 10
        ball.clipsToBounds = true
        ball.layer.borderWidth = 2
        ball.layer.borderColor = UIColor.redColor().CGColor
        view.addSubview(ball)
        
        paddle = UIView(frame: CGRectMake(view.center.x, view.center.y * 1.7, 80, 20))
        paddle.backgroundColor = UIColor.blackColor()
        view.addSubview(paddle)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        
        let ballDynamicBehavior = UIDynamicItemBehavior(items: [ball])
        ballDynamicBehavior.friction = 0
        ballDynamicBehavior.resistance = 0
        ballDynamicBehavior.elasticity = 1.0
        ballDynamicBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(ballDynamicBehavior)
        
        let paddleDynamicBehavior = UIDynamicItemBehavior(items: [paddle])
        paddleDynamicBehavior.density = 10000
        paddleDynamicBehavior.resistance = 100
        paddleDynamicBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(paddleDynamicBehavior)
        
        let pushBehavior = UIPushBehavior(items: [ball], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.2, 1.0)
        pushBehavior.magnitude = 0.25
        dynamicAnimator.addBehavior(pushBehavior)
        
        
        var temp = bricksArray
        temp.append(ball)
        temp.append(paddle)
        collisionBehavior = UICollisionBehavior(items: temp)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        
        livesLabel.text = "Lives: \(lives)"

        
    }
    
    @IBAction func dragPaddle(sender: UIPanGestureRecognizer) {
        let panGesture = sender.locationInView(view)
        paddle.center = CGPointMake(panGesture.x, view.center.y * 1.7)
        dynamicAnimator.updateItemUsingCurrentState(paddle)
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        if item.isEqual(ball) && p.y > paddle.center.y {
            lives--
            if lives > 0 {
                livesLabel.text = "Lives: \(lives)"
               ball.center = view.center
                dynamicAnimator.updateItemUsingCurrentState(ball)
            }
            else {
                livesLabel.text = "Game Over"
                ball.removeFromSuperview()            }
       }
    }
    
    func brickLoader() {
        let brickWidth = (375 / 5)
        var colorCounter = 0
        for i in 0...5 {
            let newBrick = UIView(frame: CGRectMake(CGFloat(brickWidth * i), CGFloat(0), CGFloat(brickWidth), CGFloat(brickWidth)))
            newBrick.backgroundColor = UIColor.redColor()
            newBrick.layer.borderWidth = 2
            newBrick.layer.borderColor = UIColor.whiteColor().CGColor
            let newBrickDynamicBehavior = UIDynamicItemBehavior(items: [newBrick])
            newBrickDynamicBehavior.density = 10000
            view.addSubview(newBrick)
            bricksArray.append(newBrick)
        }
        
        for i in 0...5 {
            let newBrick2 = UIView(frame: CGRectMake(CGFloat(brickWidth * i), CGFloat(75), CGFloat(brickWidth), CGFloat(brickWidth)))
            newBrick2.backgroundColor = UIColor.orangeColor()
            newBrick2.layer.borderWidth = 2
            newBrick2.layer.borderColor = UIColor.whiteColor().CGColor
            let newBrick2DynamicBehavior = UIDynamicItemBehavior(items: [newBrick2])
            newBrick2DynamicBehavior.density = 10000
            view.addSubview(newBrick2)
            bricksArray.append(newBrick2)
        }
        
        for i in 0...5 {
            let newBrick3 = UIView(frame: CGRectMake(CGFloat(brickWidth * i), CGFloat(150), CGFloat(brickWidth), CGFloat(brickWidth)))
            newBrick3.backgroundColor = UIColor.yellowColor()
            newBrick3.layer.borderWidth = 2
            newBrick3.layer.borderColor = UIColor.whiteColor().CGColor
            let newBrick3DynamicBehavior = UIDynamicItemBehavior(items: [newBrick3])
            newBrick3DynamicBehavior.density = 10000
            view.addSubview(newBrick3)
            bricksArray.append(newBrick3)
        }
    }
}
