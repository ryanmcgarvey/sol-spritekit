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
    var points = CGPoint[]()
    
    override func didMoveToView(view: SKView) {
        add_graph()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        var correct = 0
        var wrong = 0
        var round_stats = engine.update()
        
        for (cycle, result) in round_stats {
            if result {
                correct += 1
            }else{
                wrong += 1
            }
        }
        
        var percent_right = Float(correct) / Float(round_stats.count)
        println("Round: \(engine.round) \(percent_right)")
        var x_axis = (Float(engine.round) / Float(CGRectGetMaxX(self.frame))) * 200
        points.append(CGPoint(x:  x_axis , y: percent_right * 1000.0))
        
        self.removeChildrenInArray([graph])
        add_graph()
    }
    
    func add_graph() {
        graph = SKShapeNode(points: &points, count: UInt(points.count))
        graph.strokeColor = UIColor.redColor()
        graph.position = CGPoint(x:CGRectGetMinX(self.frame), y:CGRectGetMinY(self.frame));
        self.addChild(graph)
    }
    
}
