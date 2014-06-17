//
//  node.swift
//  sol-spritekit
//
//  Created by Ryan McGarvey on 6/16/14.
//  Copyright (c) 2014 Ryan McGarvey. All rights reserved.
//

import Foundation

class  Node {
    var active = false
    var connections = Connection[]()
    var id: Int
    var type: String
    var finger_print: String
    
    init(id: Int, type: String) {
        self.id = id
        self.type = type
        self.finger_print = "\(type): \(id)"
    }
    
    func signal(value: Bool) {
        active = value
        if active {
            for connection in connections {
                connection.signal(self)
            }
        }
    }
    
    func add_connection(connection: Connection) {
        connections.append(connection)
    }
    
}


class Sensor: Node {
    
}

class Control: Node {
}