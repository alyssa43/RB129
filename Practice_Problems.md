<h2> RB129 Practice Problems</h2>

1. What will the code below output? Why?

   ```ruby
   class Student
     attr_reader :id
   
     def initialize(name)
       @name = name
       @id
     end
   
     def id=(value)
       self.id = value
     end
   end
   
   tom = Student.new("Tom")
   tom.id = 45
   ```

   <b>Answer:</b> The code above will output a `SystemStackError` exception. This is happening because our setter method for the `@id` instance variable, the `id=` instance method, is actually a recursive method that just keeps calling itself. Within the `id=` instance method definition we use `self.` to try and invoke the `id` getter instance method, but because we follow that with the `=` sign we are actually invoking the `id=` instance method.

   This line:

   ```ruby
   self.id = value
   ```

   is essentially the same as invoking:

   ```ruby
   self.id=(value)
   ```

   Because of this, this method basically just becomes a big infinite loop, which in turns causes the `SystemStackError` exception.

   To fix this error, we could change line 10 to access the `@id` instance variable directly:

   ```ruby
   @id = value
   ```

2. Define a class of your choice with the following: 

   * Constructor method that initializes 2 instance variables
   * Instance method that outputs an interpolated string of those variable
   * Getter method for both (you can use the shorthand notation if you want)
   * Prevent instances from accessing these methods from outside the class
   * Finally, explain what concept(s) you've just demonstrated with your code

   <b>Answer:</b>

   ```ruby
   class Person
     def initialize(name, age)
       @name = name
       @age = age
     end
   
     def info
       "Hello, my name is #{name} and I am #{age} years old."
     end
   
     private
   
     attr_reader :name, :age 
   end
   
   me = Person.new('Alyssa', 35)
   
   p me.name # => NoMethodError: private method `name` called for #<Person:...>
   p me.age # => NoMethoError: private method `age` called for #<Person:...>
   p me.info # => "Hello, my name is Alyssa and I an 35 years old."
   ```

   The code above demonstrates method access control, and more specifically; how public and private instance methods work.

   Here we have a class called `Person` that has two instance variables: `@name` and `@age`. We have created two `private` getter methods for these instance variables, called `name` and `age`. Because these getter methods are private, when we try to invoke them on our `Person` object `me`, we will get a `NoMethodError` exception because we cannot call a `private` method from outside of the class. However, when the `Person#info` instance method invokes the `name` and `age` getter instance methods, those methods will be invoked and return the values references by those instance variables, which then end up being inserted into the interpolated string that the `Person#info` instance method returns.

   This demonstrates how by making instance methods `public`, we allow any instance of that class to invoke that instance method. And, by making instance methods `private` we are protecting that data from being accessed from outside of the class because `private` instance methods are not able to be invoked from outside of the class, only from within the class.

3. What concept does the following code aim to demonstrate?

   ```ruby
   module Greet
     def greet(message)
       puts message
     end
   end
   
   class Teacher
     include Greet
   end
   
   class Student
     include Greet
   end
   
   tom = Teacher.new
   rob = Student.new
   
   tom.greet("Bonjour!")
   rob.greet("Hello!")
   ```

   <b>Answer:</b> The code above demostrates polymorphism through interface inheritance. By defining a module that contains a common behavior for multiple classes, we can then mix that behavior into those classes. We do this by invoking the `include` method and passing the module name as the argument within the class we wish to add the behavior(s) to. 

   By including the `Greet` module into the `Teacher` and `Student` classes, we have given any instances of those classes the ability to invoke the `Greet#greet` instance method.

   Polymorphism is achieved because we are allowing instances of different classes to invoke the same method.

   Interface inheritance allows us to keep us from repeating code within our program.

4. What will the last line of code return?

   ```ruby
   class Student
     def initialize(id, name)
       @id = id
       @name = name
     end
   
     def ==(other)
       self.id == other.id
     end
   
     private
   
     attr_reader :id, :name
   end
   
   rob = Student.new(123, "Rob")
   tom = Student.new(456, "Tom")
   
   rob == tom
   ```

   <b>Answer:</b> The above code will output a `NoMethodError` exception because when we invoke the `Person#==` instance method, the `id` getter method for another instance of the `Student` class, `tom` is being invoked. However, because the `id` getter instance method is a `private` instance method, we are not able to invoke it on any instance that is not the calling object. For us to access the `id` getter instance method for `tom` (or any other instance of the `Student` class), but still limit access to the `id` getter instance method from outside of the class, we can make the `id` instance method `protected` instead of `private`. 

   ```ruby
   class Student
     def initialize(id, name)
       @id = id
       @name = name
     end
   
     def ==(other)
       self.id == other.id
     end
   
     protected
   
     attr_reader :id
   
     private
   
     attr_reader :name
   end
   
   rob = Student.new(123, "Rob")
   tom = Student.new(456, "Tom")
   
   rob == tom # => false
   ```

   By making this modification, we will be able to invoke the `id` getter method of the `Student` object `tom` that was passed in as the argument.

   Protected methods are similar to private methods. These methods are also not accessible to be invoked from outside of the class, and must be invoked from another method within the same class. They are different in that they allow us to invoke protected methods on another instance of the same class.

   By modifying the `id` getter method to a `protected` method, we are still able to limit access to that method from outside of the class, while allowing other instances of the `Student` class to invoke another `Student` object's `id` getter method.

5. What will the last two lines of code output?

   ```ruby
   class Foo
     def self.method_a
       "Justice" + all
     end
     
     def self.method_b(other)
       "Justice" + other.exclamate
     end
   
     private
   
     def self.all
       " for all"
     end
   
     def self.exclamate
       all + "!!!"
     end
   end
   
   foo = Foo.new
   puts Foo.method_a
   puts Foo.method_b(Foo)
   ```

   <b>Answer:</b> The method invocation `puts Foo.method_a` will output: Justice for all

   The method invocation `puts Foo.method_b(Foo)` will output: Justice for all!!!

   When we invoke `Foo.method_a`, we are invoking the class method `method_a` within the `Foo` class. Within that method definition we invoke the `all` class method. Because we are within a class method, when we invoke `all` it is essentially like telling Ruby to invoke `self.all` and because we are within a class method, `self` will reference the class itself. This means that we are invoking the `all` class method, which returns the string `" for all"`. This string then gets concatenated with the string `"Justice"`, and returned as the argument of the `puts` method invocation, which then outputs: Justice for all

   When we invoke `Foo.method_b(Foo)`, we invoking the class method `method_b` within the `Foo` class and passing in the `Foo` class as the argument. Within that method definition we invoke the `exclamate` class method on the class passed in as the argument, represented by `other`, which is actually the same class; `Foo`. This means that in this instance:

   `other.exclamate` is the same as `Foo.exclamate`. Because the class passed in as the argument is actually the same class as the calling object of `method_b`, we are able to invoke the private class method `exclamate`. From within the `exclamate` class method, we invoke the `all` class method, which returns the string " for all", and concatenates the string `"!!!"` to the end. This means that the `exclamate` class method will return the string " for all!!!", which then gets concatenated onto the string "Justice". The string returned by the class method `method_b` invocation is the string `"Justice for all!!!"`, which then gets passed to the `puts` method invocation then outputting that to the console.



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

