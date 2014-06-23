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
    var signal_strength = Dictionary<String, Bool>()
    var signal_total = 0
    
    var active: Bool {
        return signal_total == parents.count
//        for(id, signal) in signal_strength {
//            if !signal {
//                return false
//            }
//        }
//        return true
    }
    
    func strengthen() {
        strength += 1
    }
    
    func signal(parent: Node) {
        signal_total += 1
        signal_strength[parent.finger_print] = true
    }
    
    func reset() {
        signal_total = 0
        for parent in parents {
            signal_strength[parent.finger_print] = false
        }
    }
    
    init(parents: Node[], children: Node[] ) {
        self.parents = parents
        self.children = children
        for parent in parents {
            parent.add_connection(self)
            signal_strength[parent.finger_print] = false
        }
    }
    
}

class AbstractConnection {
    var sibling_ids = Dictionary<String, Int>()
    func prediction_for(

    init(sensor: Sensor) {
        for connection in sensor.connections {
            for child in connection.children {
                for(id, sibling) in sensor.siblings {
                    
                    if sibling.id == child.id {
                        if sibling_ids[id] {
                            sibling_ids[id] = sibling_ids[id]! + 1
                        }else {
                            sibling_ids[id] = 1
                        }
                        
                    }
                    
                }
            }
        }
    }
}

class Gland: Sol {
    var eyes: Sensor[]
    var winds: Sensor[]
    var connections =  Dictionary<String,Connection>()
    var abstract_connections = Dictionary<String,AbstractConnection>()
    
    var sensors: Sensor[] {
        return eyes + winds
    }
    
    init(eyes: Sensor[], winds: Sensor[]) {
        self.eyes = eyes
        self.winds = winds
    }
    
    func react() {
        valid_sensors.sample().predict(true)
    }
    
    func validate_reaction() {
        var ids = active_sensors.map {
            (var sensor) -> String in
            return sensor.finger_print
        }
        
        var sensor_fingerprint = "\(ids)"
        if var connection = connections[sensor_fingerprint] {
            connection.strengthen()
        }else{
            connections[sensor_fingerprint] = Connection(parents: active_sensors, children: active_predictions)
        }
    }
    
    func reset() {
        for sensor in sensors {
            sensor.predict(false)
            sensor.signal(false)
        }
        for connection in connections.values {
            connection.reset()
        }
    }
    
    func sleep() {
        var active_sensor = secondary_sensor_with_most_connections()
        
    }
    
    func secondary_sensor_with_most_connections() -> Sensor {
        return winds[0]
    }
    
    var valid_sensors: Node[] {
        var nodes = Node[]()

        for sensor in active_sensors {
            for connection in sensor.connections {
                if connection.active {
                    nodes += connection.children
                }
            }
        }
        
        if nodes.isEmpty {
            return eyes
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
    
    var active_predictions: Sensor[] {
        var output = Sensor[]()
            for node in eyes {
                if node.active {
                    output += node
                }
            }
            return output
    }
}


