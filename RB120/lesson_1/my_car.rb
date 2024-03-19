class MyCar
  attr_accessor :color, :year, :model

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake a decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    @color = color
    puts "Your car is now #{@color}."
  end
end

suburban = MyCar.new(2014, "Chevy Suburban", "white")
suburban.speed_up(20)     # => You push the gas and accelarate 20 mph.
suburban.current_speed    # => You are now going 20 mph.
suburban.speed_up(20)     # => You push the gas and accelarate 20 mph.
suburban.current_speed    # => You are now going 40 mph.
suburban.brake(20)        # => You push the brake and decelarate 20 mph.
suburban.current_speed    # => You are now going 20 mph.
suburban.brake(20)        # => You push the brake and decelarate 20 mph.
suburban.current_speed    # => You are now going 0 mph.
suburban.shut_down        # => Let's park this bad boy!
suburban.current_speed    # => You are now going 0 mph.

puts suburban.color       # => white
suburban.color = "black"  # => black
puts suburban.color       # => black
puts suburban.year        # => 2014

puts suburban.color           # => black
suburban.spray_paint("blue")  # => "Your car is now blue."
puts suburban.color           # => blue