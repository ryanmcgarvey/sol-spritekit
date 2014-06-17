//
//  engine.swift
//  sol-spritekit
//
//  Created by Ryan McGarvey on 6/16/14.
//  Copyright (c) 2014 Ryan McGarvey. All rights reserved.
//

import Foundation



class Engine {
    var stats = Dictionary<Int, Bool>()
    var sol: Sol
    var world: World
    var eyes = Sensor[]()
    var controls = Control[]()
    var left_winds = Sensor[]()
    var right_winds = Sensor[]()
    
    init() {
        for i in 0...3 {
            eyes.append(Sensor(id: i, type: "eye"))
            left_winds.append(Sensor(id: i, type: "left wind"))
            right_winds.append(Sensor(id: i, type: "right wind"))
            controls.append(Control(id: i, type: "control"))
        }
        sol = Gland(sensors: eyes + left_winds + right_winds, controls: controls)
        world = World(eyes: eyes, left_winds: left_winds, right_winds: right_winds, controls: controls)
    }
    
    func run() {
        for cycle in 1...1000 {
            world.next_scene()
            sol.react()
            if world.correct_response {
                sol.validate_reaction()
                stats[cycle] = true
            }else {
                stats[cycle] = false
            }
            sol.reset()
        }
    }
}
