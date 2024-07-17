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

   Answer: The output will be `nil`. This is because we have created a new instance of the `Person` class without assigning a value to the `@name` instance variable. By default, uninitialized instance variables have a value of `nil`. So, when we invoke the `Person#name` getter method on our `Person` object `bob`, Ruby will return the value referenced by the `@name` instance variable, which then gets output and returned by the `p` method invocation. 

   `nil` will be output. This happens because on line 9 we initialize a local variable called `bob` and assign it to reference a new instance of the `Person` class. When we instantiate a new `Person` object, there is an instance variable called `@name`, but at no point does a value get assigned to that instance variable, which leaves it uninitialized which defaults to have a value of `nil`. Then, on line 10 our local variable `bob` , which references an instance of our `Person` class, calls the getter method `Person#name` which will return the value referenced by the `@name` instance variable; `nil`. It is then returned and output by the `p` method invocation. 

   This demostrates how instance variables differ from local variables because if you try to reference an uninitialized instance variable, `nil` (the default value) will be returned. Whereas if you try to reference an uninitialized local variable you will get a `NameError` exception because Ruby cannot find a local variable that hasn't been initialized.

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

   Answer: The output will be `nil`. On line 15 we initialize a new local variable called `teddy` and assign it to reference a new instance of the class `Dog`. Because when you instantiate a new object, any uninitialized instance variables will have a default value of `nil`, that means that the `@can_swim` instance variable is currently referencing `nil`. That will only change once the `#enable_swim` method is invoked, which assigns a new value to the `@can_swim` instance variable. So, when we invoke the `Dog#swim` method on line 16 on our `Dog` object `teddy` we evaulate if the instance variable `@can_swim` has a truthy value. And because it's value is currently `nil`, which is a falsy value, the string `"swimming!"` does not get implicitly returned. Since, that is the only line of code within that method nothing ends up being returned, and when there is a method invocation without a return value, `nil` is then returned by default. This is why we see the output `nil`. 

   This demonstrates how instance variables that have not been initialized have a default value of `nil`. 

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

   Answer:The outputs here will be `4`, `4`, and then a `NameError` exception. 
   
   The first output of `4` comes from line 27 where we invoke the class method `sides` on the `Square` class. Because we are invoking the `sides` method directly on the class itself that is why it's invoking a class method. Ruby first searches within the `Square` class for this class method, which it does not find there. Ruby then goes up the lookup chain to the `Quadrilateral` class, which it does not find there either. Ruby then continues up the lookup chain to the `Shape` class, where it does find the `self.sides` class method to invoke. Within the `self.sides` class method we reference `self`, which in this instance is the class `Square`, then we use the scope resolution operator `::` and the constant `SIDES` to tell Ruby we want to reference the constant `SIDES` within the `Square` class. Ruby then searches within the `Square` class for the constant `SIDES`, but does not find it there. Ruby then continues up the lookup chain to the `Quadrilater` class where it is found, and returns the Integer `4`. Which is then returned and output by the `p` method invocation.
   
   The second output of `4` comes from line 28 where we invoke the instance method `sides` on a new instane of the class `Sqaure`. Ruby first searches within the `Square` class for the instance method `sides` which it does not find there. Ruby then continues up the lookup chain to the the `Quadrilateral` class where it does not find there either. Ruby then continues up the lookup chain to the `Shape` class where it does find the instance method `sides`. Within the `Shape#sides` instance method definition we reference `self`, which is currently referencing the calling object, which in this instance is an instance of the `Square` class. We then call the `#class` method on this object which returns the class `Square`. We then use the scope resolution operator to reference the constant `SIDES` within the `Sqaure` class. Ruby then searches within the `Sqaure` class for the constant `SIDES`, but does not find it there. Ruby then continues up the lookup chain to the `Quadrilateral` class where it is found, and returns the Integer `4`. Which is then returned and output by the `p` method invocation.
   
   
   
   
   
    This code will output a `4`, then another `4`, and then finally a `NameError` exception. The first `4` we see output comes from line 25 where we are invoking the `sides` method directly on the class `Square`. Because we invoke it directly on the class itself means we are invoking the class method `sides` (`self.sides`). Ruby first looks within the `Square` class for a `self.sides` method, which it does not find. So it continues searching within the `Quadrilateral` class, where it also does not find it. It then searches the `Shape` class where it does find the class method `self.sides`. Within that class method definition, on line 11, we implicitly return the value of invoking `self::SIDES`. On this line `self` refers to the object that called the `self.sides` method; which is the `Square` class. Which is why Ruby looks within the `Square` class to resolve the `self::SIDES` method invocation. Ruby is searching for a constant called `SIDES`. It is not found within the `Square` class, but within the next class up the method lookup path, the `Quadrilateral` class. The `Square.sides` class method invocation then returns the Integer `4`. Which is then returned at output by the `p` method invocation.

