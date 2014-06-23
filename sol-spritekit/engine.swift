//
//  engine.swift
//  sol-spritekit
//
//  Created by Ryan McGarvey on 6/16/14.
//  Copyright (c) 2014 Ryan McGarvey. All rights reserved.
//

import Foundation



class Engine {
    var sol: Sol
    var world: World
    var eyes = Sensor[]()
    var left_winds = Sensor[]()
    var right_winds = Sensor[]()
    var round = 0
    
    init(num_sensors: Int) {
        
        for i in 0..num_sensors{
            eyes.append(Sensor(id: i, type: "eye"))
            left_winds.append(Sensor(id: i, type: "left wind"))
            right_winds.append(Sensor(id: i, type: "right wind"))
        }
        
        for j in 0..num_sensors {
            for k in 0..num_sensors {
                eyes[j].siblings["\(k - j)"] = eyes[k]
            }
        }

        sol = Gland(eyes: eyes, winds: left_winds + right_winds)
        world = World(eyes: eyes, left_winds: left_winds, right_winds: right_winds)
    }
    
    func update() -> Dictionary<Int, Bool> {
        var round_stats = Dictionary<Int, Bool>()
        round += 1
        for cycle in 1...50 {
            world.next_scene()
            sol.react()
            if world.correct_response {
                sol.validate_reaction()
                round_stats[cycle] = true
            }else {
                round_stats[cycle] = false
            }
            sol.sleep()

        }
        return round_stats
    }
}
