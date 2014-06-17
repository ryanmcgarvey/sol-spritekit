//
//  update_engine.swift
//  sol-spritekit
//
//  Created by Ryan McGarvey on 6/16/14.
//  Copyright (c) 2014 Ryan McGarvey. All rights reserved.
//

import SpriteKit

class UpdateEngineButton: SKSpriteNode {
    var game_scene: GameScene?

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("Updateing!")
        game_scene?.update_results()
    }
    
}