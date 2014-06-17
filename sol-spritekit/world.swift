import Foundation

class World {
    var eyes: Sensor[]
    var left_winds: Sensor[]
    var right_winds: Sensor[]
    var controls: Control[]
    var ball_position = 0
    var wind_strength = 0
    
    var size:Int {
        return eyes.count
    }
    
    init(eyes: Sensor[], left_winds: Sensor[], right_winds: Sensor[], controls: Control[]) {
        self.eyes = eyes
        self.left_winds = left_winds
        self.right_winds = right_winds
        self.controls = controls
    }
    
    func next_scene() {
        place_ball(Int(arc4random_uniform(UInt32(size))))
        set_wind(Int(arc4random_uniform(UInt32(2))))
    }
    
    func place_ball(position: Int) {
        self.ball_position = position
        for (index, sensor) in enumerate(eyes) {
            sensor.signal(index == ball_position)
        }
    }
    
    func set_wind(strength: Int) {
        self.wind_strength = strength
        if wind_strength > 0 {
            for (index, wind) in enumerate(right_winds) {
                wind.signal(wind_strength - index > 0)
            }
        }
        if wind_strength < 0 {
            for (index, wind) in enumerate(left_winds) {
                wind.signal((-1 * wind_strength) - index > 0)
            }
        }
    }
    
    var correct_response: Bool {
        var correct_position = ball_position + wind_strength
        var actual_position = active_position
        
        if correct_position > (self.size - 1) {
            correct_position = self.size - 1
        }
        if correct_position < 0 {
            correct_position = 0
        }

        return actual_position == correct_position
    }
    
    var active_position: Int {
        for (index, control) in enumerate(controls) {
            if control.active {
                return index
            }
        }
        return -1
    }
}

