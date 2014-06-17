//
//  GameScene.swift
//  sol-spritekit
//
//  Created by Ryan McGarvey on 6/16/14.
//  Copyright (c) 2014 Ryan McGarvey. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var engine = Engine()
    var graph = SKShapeNode()
    var timer = SKLabelNode(fontNamed:"Chalkduster")
    

    override func didMoveToView(view: SKView) {
        let update_button = UpdateEngineButton(color: UIColor.purpleColor(), size: CGSize(width: 100, height: 100))
        update_button.position = CGPoint(x:CGRectGetMaxX(self.frame) - 100, y:CGRectGetMinY(self.frame) + 100);
        update_button.game_scene = self
        update_button.userInteractionEnabled = true;
        self.addChild(update_button)
        
        timer.text = "Timer";
        timer.fontSize = 30;
        timer.position = CGPoint(x:CGRectGetMaxX(self.frame) - 300, y:CGRectGetMinY(self.frame) + 70 );
        
        self.addChild(timer)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

    }
   
    override func update(currentTime: CFTimeInterval) {
    }
    
    func update_results() {
        var start_time = NSDate.timeIntervalSinceReferenceDate()
        engine.run()
        var end_time = NSDate.timeIntervalSinceReferenceDate()
        timer.text = "\(end_time - start_time)"
        var correct = 0
        var wrong = 0
        var points = CGPoint[]()
        self.removeChildrenInArray([graph])
        
        for (round, result) in engine.stats {
            if result {
                correct += 1
            }else{
                wrong += 1
            }
            if round % 10 == 0 {
                var percent_right = Float(correct) / Float(correct + wrong)
                println("Round: \(round) \(percent_right)")
                points.append(CGPoint(x: (Float(round) / Float(engine.stats.count) ) * 1000.0 , y: percent_right * 1000.0))
            }
        }
        
        graph = SKShapeNode(points: &points, count: UInt(points.count))
        graph.strokeColor = UIColor.redColor()
        graph.position = CGPoint(x:CGRectGetMinX(self.frame), y:CGRectGetMinY(self.frame));
        self.addChild(graph)
    }
}
