import Foundation

class World {
    var eyes: Sensor[]
    var left_winds: Sensor[]
    var right_winds: Sensor[]
    var ball_position = 0
    var wind_strength = 0
    
    var size:Int {
        return eyes.count
    }
    
    init(eyes: Sensor[], left_winds: Sensor[], right_winds: Sensor[]) {
        self.eyes = eyes
        self.left_winds = left_winds
        self.right_winds = right_winds
    }
    
    func next_scene() {
        place_ball(Int(arc4random_uniform(UInt32(size))))
        set_wind([-1].sample())
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
            right_winds[wind_strength - 1].signal(true)
        }
        if wind_strength < 0 {
            left_winds[(-1 * strength) - 1].signal(true)
        }
    }
    
    var correct_response: Bool {
        var correct_position = ball_position + wind_strength
        var actual_position = prediction
        
        if correct_position > (self.size - 1) {
            correct_position = self.size - 1
        }
        if correct_position < 0 {
            correct_position = 0
        }

        return actual_position == correct_position
    }
    
    var prediction: Int {
        for (index, eye) in enumerate(eyes) {
            if eye.predicted {
                return index
            }
        }
        return -1
    }
}

