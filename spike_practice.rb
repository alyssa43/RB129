module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

# Square.ancestors => [Square, Quadrilateral, Shape, Describable...]

p Square.sides # => 4
p Square.new.sides # => 4
p Square.new.describe_shape # => NameError - uninitialized constant Describable::SIDES


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

=begin
The outputs here will be `4`, `4`, and then a `NameError` exception. 

The first output of `4` comes from line 27 where we invoke the class method `sides` on the `Square` class. Because we are invoking the `sides` method directly on the class itself that is why it's invoking a class method. Ruby first searches within the `Square` class for this class method, which it does not find there. Ruby then goes up the lookup chain to the `Quadrilateral` class, which it does not find there either. Ruby then continues up the lookup chain to the `Shape` class, where it does find the `self.sides` class method to invoke. Within the `self.sides` class method we reference `self`, which in this instance is the class `Square`, then we use the scope resolution operator `::` and the constant `SIDES` to tell Ruby we want to reference the constant `SIDES` within the `Square` class. Ruby then searches within the `Square` class for the constant `SIDES`, but does not find it there. Ruby then continues up the lookup chain to the `Quadrilater` class where it is found, and returns the Integer `4`. Which is then returned and output by the `p` method invocation.

The second output of `4` comes from line 28 where we invoke the instance method `sides` on a new instane of the class `Sqaure`. Ruby first searches within the `Square` class for the instance method `sides` which it does not find there. Ruby then continues up the lookup chain to the the `Quadrilateral` class where it does not find there either. Ruby then continues up the lookup chain to the `Shape` class where it does find the instance method `sides`. Within the `Shape#sides` instance method definition we reference `self`, which is currently referencing the calling object, which in this instance is an instance of the `Square` class. We then call the `#class` method on this object which returns the class `Square`. We then use the scope resolution operator to reference the constant `SIDES` within the `Sqaure` class. Ruby then searches within the `Sqaure` class for the constant `SIDES`, but does not find it there. Ruby then continues up the lookup chain to the `Quadrilateral` class where it is found, and returns the Integer `4`. Which is then returned and output by the `p` method invocation.
=end