import Foundation


extension Array {
    func sample() -> T {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

protocol Sol {
    func react()
    func validate_reaction()
    func reset()
    func sleep()
}


class Connection {
    var parents: Node[]
    var children: Node[]
    var strength = 1
    
    var active: Bool {
    for parent in parents {
        if !parent.active {
            return false
        }
        }
        return true
    }
    
    func strengthen() {
        strength += 1
    }
    
    init(parents: Node[], children: Node[] ) {
        self.parents = parents
        self.children = children
        for parent in parents {
            parent.add_connection(self)
        }
    }
    
}

class AssumedConnection {
    
}

class Gland: Sol {
    var sensors: Sensor[]
    var controls: Control[]
    var connections =  Dictionary<String,Connection>()
    
    init(sensors: Sensor[], controls: Control[]) {
        self.sensors = sensors
        self.controls = controls
    }
    
    func react() {
        valid_controls.sample().signal(true)
    }
    
    func validate_reaction() {
        var ids = active_sensors.map {
            (var sensor) -> String in
            return sensor.finger_print
        }
        
        var sensor_fingerprint = "\(ids)"
        if var connection = connections[sensor_fingerprint] {
            // println("connection already made with: \(sensor_fingerprint)")
            connection.strengthen()
        }else{
            // println("Adding connection with fingerprint: \(sensor_fingerprint)")
            connections[sensor_fingerprint] = Connection(parents: active_sensors, children: active_controls)
        }
    }
    
    
    func reset() {
        for control in controls {
            control.signal(false)
        }
    }
    
    func sleep() {

    }
    
    
    var valid_controls: Node[] {
        var nodes = Node[]()

        for sensor in active_sensors {
            for connection in sensor.connections {
                if connection.active {
                    nodes += connection.children
                }
            }
        }
        
        if nodes.isEmpty {
            return controls
        }else {
            return nodes
        }
        
    }
    
    var active_sensors: Sensor[] {
        var output = Sensor[]()
        for sensor in sensors {
            if sensor.active {
                output += sensor
            }
        }
        return output
    }
    
    var active_controls : Control[] {
    var output = Control[]()
        for node in controls {
            if node.active {
                output += node
            }
        }
        return output
    }
}


