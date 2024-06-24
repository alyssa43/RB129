<h2> RB129 Practice Problems</h2>

1. What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

   ```ruby
   class Person
     attr_reader :name
     
     def set_name
       @name = 'Bob'
     end
   end
   
   bob = Person.new
   p bob.name
   ```

   Answer: `nil` will be output. This happens because on line 9 we assign a local variable called `bob` to reference a new instance of the class `Person`. When we instantiate a new `Person` class object, there is an instance variable called `@name`, but at no point does a value get assigned to that instance variable, which leaves it uninitialized which defaults to have a value of `nil`. Then, on line 10 our local variable `bob` , which references an instance of our `Person` class, calls the getter method `Person#name` which will return the value referenced by the `@name` instance variable; `nil`. It is then returned and output by the `p` method invocation. 

   This demostrates how instance variables differ from local variables because an uninitialized instance variable will default to a value of `nil`, while an uninitialized local variable will throw a `NameError` exception because Ruby cannot find a local variable that hasn't been initiailzed.

   

2.  What is output and why? What does this demonstrate about instance variables?

   ```ruby
   module Swimmable
     def enable_swimming
       @can_swim = true
     end
   end
   
   class Dog
     include Swimmable
     
     def "swimming" if @can_swim
     end
   end
   
   teddy = Dog.new
   p teddy.swim
   ```

   Answer: `nil` will be output. What happens here is that on line 15 we ininitialize a new local variable called `teddy` and assign it to reference the value of instantiating a new instance of the `Dog` class by invoking the `new` method on the class `Dog`. Then on line 16 we invoke the `swim` method on our local variable `teddy` which is an instance of the `Dog` class. Within the instance method definition for the `Dog#swim` method, we can see that the String object `"swimming"` will be inplicitly returned if the instance variable `@can_swim` is referencing a truthy value. However, because the `enable_swimming` method within the `Swimmable` module never gets invoked, the `@can_swim` instance variable never gets assigned. When an instance variable never gets assigned a value to refernce, it will deafult to reference `nil`, and because `nil` is a falsy value; line 11 does not return the string `"swimming"`, and sense that is the only line of code within the `swim` instance method definition; `nil` is then returned, which is what gets output by the `p` method invocation.

   

3. What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods below?

   ```ruby
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
   
   p Square.sides
   p Square.new.sides
   p Square.new.describe_shape
   ```

   Answer: This code will output a `4`, then another `4`, and then finally a `NameError` exception. The first `4` we see output comes from line 25 where we are invoking the `sides` method directly on the class `Square`. Because we invoke it directly on the class itself means we are invoking the class method `sides` (`self.sides`). Ruby first looks within the `Square` class for a `self.sides` method, which it does not find. So it continues searching within the `Quadrilateral` class, where it also does not find it. It then searches the `Shape` class where it does find the class method `self.sides`. Within that class method definition, on line 11, we implicitly return the value of invoking `self::SIDES`. On this line `self` refers to the object that called the `self.sides` method; which is the `Square` class. Which is why Ruby looks within the `Square` class to resolve the `self::SIDES` method invocation. Ruby is searching for a constant called `SIDES`. It is not found within the `Square` class, but within the next class up the method lookup path, the `Quadrilateral` class. The `Square.sides` class method invocation then returns the Integer `4`. Which is then returned at output by the `p` method invocation.

