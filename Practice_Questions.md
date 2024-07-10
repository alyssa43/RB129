<h2>LS 120 Questions</h2>

1. <b>What is OOP and why is it important?</b> 

   OOP stands for "object oriented programming". It is a programming paradigm that allows for more organized and flexible code. By creating objects that contain both state (data) and behavior (functionality) it allows us to have a self-contained component of our program that can be changed or manipulated without affecting our entire program. By breaking down our code into smaller, more manageable parts, it makes our code more organized and easier to read and modify when needed. It is important because without OOP our program would be very fragile and likely to have a ripple effect throughout the entire program from just one error.

2. <b>What is encapsulation?</b> 

   Encapsulation is a form of data protection where data (state) and functionality (behavior) are combined into a single unit called an "object". By containing an object's state and behavior within itself, we can then pass these objects around in our program to use as needed. We can also choose to hide certain data, or expose it as needed, which helps in orgnizing and protecting the inner workings of our code.

3. <b>How does encapsulation relate to the public interface of a class?</b> 

   Because encapsulation bundles data and functionality together into a singular object, it allows us to hide this data and functionality from the rest of our code. The way in which we define a class' attributes and methods determines whether those attributes and methods are accessible to objects instantiated from that class outside of the class. For instance, if we define a public instance method within a class, any objects instantiated from that class can access that method from outside of the class. The public interface of a class acts as a layer of abstraction that allows objects of that class to interact with it's public attributes and methods without needing to be aware of the internal details.

4. What is an object? 

   An object can be thought of as an individual and unique container that holds information. The information an object contains will be determined by the class it was created from. Even when multiple objects are created from one class, they will still be their own unique object. EX:

   ```ruby
   class Person
     attr_accessor :name, :age, :occupation
   end
   ```

   With the above `Person` class, we can create multiple objects, each of which will contain it's own unique state. Each `Person` object will represent a different person with it's own specific values for the attributes `@name`, `@age`, and `@occupation`.

5. What is a class? 

   A class can be thought of as the mold or blueprint that is used to create objects. They are used to define the objects throughout our program. The way in which we define our class, will determine the state and behaviors available to an object instantiated from that class. 

6. What is instantiation? 

   Instantiation is the process of creating an instance of a class, also known as an object. To create a new instance of a class we must call the `new` method on the class in which we which to instantiate an object from, like so:

   ```ruby
   bob = Person.new
   ```

   Above we have instantiated an instance of the `Person` class and saved it into a local variable called `bob`.

7. <b>What is polymorphism?</b> 

   Polymorphism occurs when objects of different classes respond to the same method invocation. EX:

   ```ruby
   class Animal
     def move
       "I can move"
     end
   end
   
   class Dog < Animal; end
   class Cat < Animal; end
   class Fish < Animal; end
   
   Dog.new.move # => "I can move"
   Cat.new.move # => "I can move"
   Fish.new.move # => "I can move"
   ```

   In the above example, we have instantiated three new objects, one from the `Dog` class, one from the `Cat` class, and one from the `Fish` class. All three of these objects are of a different type, however they all three have the ability to call the `move` method. In this example we achieve polymorphism through inheritance.

8. <b>Explain two different ways to implement polymorphism.</b> 

   We can implement polymorphism through class inheritance, interface inheritance, or through duck typing. Using class inheritance to achieve polymorphism is when a subclass inherits a behavior(s) from a superclass. Using interface inheritance to achieve polymorphism is when a class inherits a behavior(s) by way of mixing in a module. And finally, using duck typing to achieve polymorphism is when objects of different types can invoke method's of the same name, and same number of arguments.

9. How does polymorphism work in relation to the public interface?

   Generally speaking, to use a classes instance method in a polymorphic manner, that instance method will need to be `public`. Meaning that it is available to be invoked on an instance of that class outside of the class. If a classes instance method is `private`, you will not be able to invoke that method from outside of the class which limits how to use it in a polymorphic manner. However, if you implement a `public` instance method within a class that invokes a `private` or `protected` instance method you can still achieve polymorphism. The key is there needs to be at least one `public` method available to an object to achieve polymorphism.

10. <b>What is duck typing? How does it relate to polymorphism - what problem does is solve?</b> 

    Duck typing is a way to achieve polymorphism. It occurs when objects of different types invoke a method of the same name, and with the same number of arguments. These objects can be treated as belonging to a specific category of objects - "if it quacks like a duck it can be treated as a duck".

    ```ruby
    class SavingsAccount
      # ... code omitted for brevity
      
      def check_balance
        "This savings account has a balance of #{@balance}."
      end
    end
    
    class CreditCard
      # ... code omitted for brevity
      
      def check_balance
        "Your credit card has a balance of #{@balance}."
      end
    end
    
    class CarLoan
      # ... code omitted for brevity
      
      def check_balance
        "Your car loan has a remaining balance of #{@balance}."
      end
    end
    
    my_savings = SavingsAccount.new
    my_credit_card = CreditCard.new
    my_car_loan = CarLoan.new
    
    my_accounts = [my_savings, my_credit_card, my_car_loan]
    
    my_accounts.each do |account|
      account.check_balance
    end
    ```

    In the above example we have a local variable called `my_accounts` that is an Array whose elements are objects of three different types:  `SavingsAccount`, `CreditCard`, and `CarLoan`. We then invoke the `Array#each` method to iterate through the `my_accounts` variable. Within the `#each` method invocations `do..end` block we then invoke a method called `#check_balance` on each object within the `my_accounts` array. Because each type of account has it's own `check_balance` method we are able to achieve polymorhphism this way. A problem that using duck typing solves would be when you wish to achieve polymorphism, but inheritance isn't appropriate.

11. What is inheritance?

    Inheritance in OOP and Ruby is a mechanism where a class inherits behaviors and attributes from another class. The class that passes on its behaviors is called the 'superclass', and the class that inherits those behaviors is called the 'subclass'. When defining a class to subclass another class, the subclass will have access to all of the `public` and `protected` methods and attributes of the superclass. This creates a hierarchical relationship between classes, where the subclass can also have additional behaviors and attributes or override existing ones from the superclass. A class can only subclass from one superclass.

12. What is the difference between a superclass and a subclass?

    A "superclass" passes all of its public and protected functionality onto the "subclass". The subclass will be able to reference any of that information as needed. Whereas, the superclass does not have access to any of the functionality within the subclass. 

13. What is a module?

    A module is a set of behaviors and/or data that is grouped together and can be included into classes through "mixing in". Modules allow for the sharing of reusable code across multiple classes without using class inheritance. By using modules, also known as "interface inheritance", it keeps our code DRY. To mix a module into a class we use the `include` method invocation, and pass it the name of the module you wish to mix in as the argument.

14. What is a mixin?

    A mixin is when you invoke the `include` method and pass in a module as the argument, within a class. This allows the class to access any data and/or behaviors defined within that module.

15. When is it good to use inheritance?

    It is good to use inheritance when there is a hierarchical relationship between classes, or in other words, when classes have an "is-a" relationship. For example, if we have the classes `Animal` and `Dog`, we can say that a `Dog` "is-an" `Animal`. This means it makes sense for our `Dog` class to inherit from the `Animal` class. However, if we have two unrelated classes, like `Car` and `Fish`, there is no shared hierarchy, so inheritance would not be appropriate for these two classes.

16. <b>In inheritance, when would it be good to override a method?</b> 

    When dealing with inheritance, it woud be a good idea to override a method when an inherited method is not appropriate for the subclass. For example if a subclass inherits a method from it's parent but that method isn't applicaple to the subclass, we can define a method with the same name within the subclass. This will then override the method from the superclass and instead use the subclasses method upon invocation. EX:

    ```ruby
    class Fish
      def swim
        "I'm a fish, of course I can swim!"
      end
    end
    
    class Batfish < Fish; end
    
    batty = Batfish.new
    batty.swim # => "I'm a fish, of course I can swim!"
    ```

    In the above example we have two classes `Fish` and `Batfish`. The `Fish` class is the parent, or superclass, of the `Batfish` class. This means that all methods within the `Fish` class are inherited and available to the `Batfish` class. When we invoke the `#swim` method on our `Batfish` object, we see the return value is the String `"I'm a fish, of course I can swim!"`. However, the batfish doesn't swim, so we want to override the `Fish#swim` method by writing our own `#swim` method within the `Batfish` class. Like so:

    ```ruby
    class Batfish < Fish
      def swim
        "I'm a fish, but I can't swim! I use my fins to walk across the ocean floor."
      end
    end
    batty = Batfish.new
    batty.swim # => "I'm a fish, but I can't swim! I use my fins to walk across the ocean floor."
    ```

    Now when we invoke the `#swim` method on our `Batfish` object, the return value is the String `"I'm a fish, but I can't swim! I use my fins to walk across the ocean floor."`.

17. <b>What is the method lookup path?</b> 

    The method lookup path is the path that Ruby travels when resolving a method invocation. First, Ruby searches the calling object's class to try to resolve the method invocation. If the method invocation is not able to be resolved from the current class, Ruby then goes up the method lookup chain, class by class until the method invocation can be resolved. If Ruby searches the entire method lookup chain and still cannot resolve the method invocation then you will receive a `NoMethodError` exception. To find a class' method lookup chain, you can invoke the `#ancestors` method on the `Class` EX:

    ```ruby
    class Animal; end
    class Dog < Animal; end
    
    Dog.Ancestors # => [Dog, Animal, Object, Kernel, BasicObject]
    ```

    In this example, when any object of the `Dog` class invokes a method, Ruby will first search the `Dog` class. If not found there, Ruby then searches the `Animal` class. If not found there, Ruby then searches the `Object` class. So on, until it reaches the `BasicObject` class.

18. <b>When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?</b> 

    When defining a class, we may have important data that we want an object of the class to hold. This data represents the object's state. The state of an object is the collection of its instance variables. The behavior of an object, on the other hand, is determined by the methods available to that object. By defining instance methods within our class, we enable specific behaviors for instances of that class. For example:

    ```ruby
    class Dog
      attr_reader :name
      
      def initialize(name)
        @name = name
      end
      
      def speak
        "Ruff!"
      end
    end
    ```

    In the code above, we define a `Dog` class that has an instance variable called `@name` and an instance method called `speak`. This means any object instantiated from the `Dog` class will have its own unique state (the value referenced by `@name`) and the ability to `speak` (behavior). 

19. How do you initialize a new object?

    To initialize a new object you must invoke the `#new` method on the class name that you wish to instantiate from, and if applicable pass any arguments required. To see if a class requires arguments upon instantiation you can look within the class at the constructor method, which is the `#initialize` instance method. When `#new` is invoked, Ruby is triggered to invoke that classes `#initialize` method. EX:

    ```ruby
    class Person
      def initialize(name)
        @name = name
      end
    end
    
    bob = Person.new('Robert')
    ```

    In the above example we have created a new `Person` object by invoking the `#new` method on the class `Person` which takes the String `'Robert'` as an argument. Because the `Person#new` method invocation invokes the `Person#initialize` method, the String `'Robert'` is what is being passed into the `Person#initialize` method, which then assigns the `@name` instance variable to reference the String `'Robert'`. A new local variable called `bob` is then assigned to reference this new `Person` object.

20. What is a constructor method?

    A constructor method is a method that is invoked when an object is being instantiated or created. In Ruby, we have the `#initialize` method that we use as the constructor method.

21. What is an instance variable, and how is it related to an object?

    An instance variable is a variable that holds a value specifically correlated to an indivdual object. It begins with the `@` symbol and  is scoped at the object level. Because it is scoped at the object level, that means that each individual object will have their own unique set of instance variables. We refer to an objects collection of instance variables as that object's state. 

22. What is an instance method?

    An instance method is a method that is defined within a class and is available to be invoked by objects of that same class. To define an instance method, you use the `def` keyword followed by the method name, all of which goes within the class definition.

23. <b>How do objects encapsulate state?</b> 

    An object encapsulates its state within itself by the use of instance variables. The state of an object refers to the collection of that object's instance variables. When defining a class, we will want to create instance variables to hold the important data that an object of that class should have. When an object is instantiated from a class, that object will contain it's own unique state.

24. What is the difference between classes and objects?

    Objects are created from classes. When an object is instantiated it uses the code within the classes definition to determine that object's behaviors and it's individual specific state.

25. How can we expose information about the state of the object using instance methods?

    To expose the data being held within an object's state, we can use accessor methods. There are two types of accessor methods, getter methods and setter methods. A getter method is an instance method that typically returns the value of an instance variable. A setter method is an instance method that allows you to modify the value of an instance variable. You can create your own accessor methods by defining them within the class definition, or Ruby has a shortcut by using `attr_reader` for getter methods, `attr_writer` for setter methods, or `attr_accessor` for both a getter and a setter method.

26. <b>What is a collaborator object, and what is the purpose of using collaborator objects in OOP?</b> 

    A collaborator object is an object that is being held within the state (instance variable) of another object. The purpose of using collaborator objects is to enable objects to interact and collaborate with other objects in our program. EX:

    ```ruby
    class Person
      attr_reader :name
    
      def initialize(name)
        @name = name
      end
    end
    
    my_name = "Alyssa"
    
    alyssa = Person.new(my_name)
    
    p my_name.object_id     # => 60
    p alyssa.name.object_id # => 60
    ```

    In the above code, the collaborator object is the String object `"Alyssa"`, which is stored within the local variable `my_name` . This String object is passed as an argument to the `Person.new` method invocation, which calls the `Person#initialize` constructor method. Inside this method, the `@name` instance variable is assigned to reference the same String object `"Alyssa`". By invoking the `object_id` method on both `my_name` and `alyssa.name` (which returns the value stored within the `@name` instance variable), we can see that both variables reference the same String object. In this example the collaborator object is just a simple String object; however, collaborator objects can be of any type, such as other custom objects. Using collaborator objects allows objects to work together with other objects, which helps to keep code organized and easier to maintain.

27. <b>What is an accessor method?</b> 

    An accessor method is an instance method within a class that allows access to an instance variable within that class. It is used to retrieve or modify the data referenced by the instance variable.

    There are two types of accessor methods, getter methods and setter methods. A getter method is an instance method that typically returns the value of an instance variable. A setter method is an instance method that allows you to modify the value of an instance variable. You can create your own accessor methods by defining them within the class definition, or Ruby has a shortcut by using `attr_reader` for getter methods, `attr_writer` for setter methods, or `attr_accessor` for both a getter and a setter method.

28. What is a getter method?

    A getter method is an instance method that (typically) returns the value being referenced by an instance variable.

29. What is a setter method?

    A setter method is an instance method that allows you to modify the value of an instance variable.

30. What is attr_accessor?

    `attr_accessor` is a method, that when invoked creates both a getter and setter method for the instance variable passed to it as an arugment. The argument passed to the `attr_accessor` method invocation should be a symbol representing the instance variable. EX:

    ```ruby
    class Person
      attr_accessor :name
      
      def initialize(name)
        @name = name
      end
    end
    ```

    In the above example, we have created both a getter method (`Person#name`) and a setter method (`Person#name=`) that allows us to both access and modify the `@name` instance variable.

31. <b>How do you decide whether to reference an instance variable or a getter method?</b> 

    Generally speaking, it is usually a good idea to invoke a getter method if there is one, rather than reference the instance variable. When there is a getter method availabe to retrieve an instance method, you should invoke that because there could be important implementation within that getter method definition that may be needed. For example, let's say there is `@dob` instance variable within a `Person` object that references an object of the `Time` class. When we want to retrieve the information within the `@dob` instance variable, we want it to be formatted in a String; we could put that implementation into the getter method defintion. EX:

    In the code below, the `Person#info` instance method invokes the `dob` getter method which formats the `Person` object's `@dob` variable the way in which we want when retrieving it. 

    ```ruby
    class Person
      def initialize(name, dob)
        @name = name
        @dob = dob
      end
    
      def dob
        @dob.strftime('%m/%d/%Y')
      end
    
      def info
        "Hello, I am #{@name} and my birthday is #{dob}" # here the `dob` getter method is being invoked
      end
    end
    
    bob = Person.new('Robert', Time.new(2000, 1, 15))
    bob.info # => "Hello, I am Robert and my birthday is 1/15/2000"
    ```

    However, if we re-write the `Person#info` method to reference the `@dob` instance variable instead of the getter method, this is the output we will see:

    ```ruby
    class Person
      def initialize(name, dob)
        @name = name
        @dob = dob
      end
    
      def dob
        @dob.strftime('%m/%d/%Y')
      end
    
      def info
        "Hello, I am #{@name} and my birthday is #{@dob}" # here the `@dob` instance variable is being referenced
      end
    end
    
    bob = Person.new('Robert', Time.new(2000, 1, 15))
    bob.info # => "Hello, I am Robert and my birthday is 2000-01-15 00:00:00 -0800"
    ```

32. <b>Why does the `#change_info` method not work as expected here?</b>

    ```ruby
    class GoodDog
      attr_accessor :name, :height, :weight
      
      def initialize(n, h, w)
        @name = n
        @height = h
        @weight = w
      end
      
      def speak
        "#{name} says arf!"
      end
      
      def change_info(n, h, w)
        name = n
        height = h
        weight = w
      end
      
      def info
        "#{name} weighs #{weight} and is #{height} tall."
      end
    end
    
    sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
    sparky.change_info('Spartacus', '24 inches', '45 lbs')
    puts sparky.info # => Sparky weighs 10 lbs and is 12 inches tall.
    ```

    The `change_info` method is not working as expected because instead of invoking the setter methods `name=`, `height=`, and `weight=` Ruby thinks we are just creating new local variables. To tell Ruby that we are wishing to invoke the setter methods, we need to prefix each with `self`, like so:

    ```ruby
    def change_info(n, h, w)
      self.name = n
      self.height = h
      self.weight = w
    end
    ```

33. When would you call a method with self?

    You call a method with `self` when within an instance method definition you want to invoke a setter method. If you leave the `self` prefix off of the method invocation, Ruby thinks you are just creating a new local method variable. EX:

    ```ruby
    class Person
      attr_accessor :name, :age
      
      def initialize(name, age)
        @name = name
        @age = age
      end
      
      def another_year_older
        self.age += 1
      end
    end
    
    bob = Person.new('Robert', 24)
    bob.age # => 24
    bob.another_year_older 
    bob.age # => 25
    ```

    However, if we change the above code by leaving the `self` prefix off of the `age=` method invocation within the `another_year_older` instance method we would see the following:

    ```ruby
    class Person
      attr_accessor :name, :age
      
      def initialize(name, age)
        @name = name
        @age = age
      end
      
      def another_year_older
        age += 1
      end
    end
    
    bob = Person.new('Robert', 24)
    bob.age # => 24
    bob.another_year_older # => NoMethodError: undefined method `+` for nil:NilClass
    ```

    Because we didn't prefix the `age=` method invocation with `self`, Ruby thought we were trying to create a new local method variable called `age`, which is why the `another_year_older` method isn't working.

34. What are class methods?

    Class methods are methods that are scoped at the class level. When defined they are prefixed with `self.` When invoking a class method, you use the class name followed by the method name. EX:

    ```Ruby
    class Person
      def self.info
        puts "This is a class method"
      end
    end
    
    Person.info # => "This is a class method"
    ```

35. What is the purpose of a class variable?

36. What is a constant variable?

37. What is the default `to_s` method that comes with Ruby, and how do you override this?

38. What are some important attributes of the `to_s` method?

39. From within a class, when an instance method uses `self`, what does it reference?

40. What happens when you use `self` inside a class but outside of an instance method?

41. Why do you need to use `self` when calling private setter methods?

42. <b>Why use `self`, and how does `self` change depending on the scope it is used in?</b>

    Because `self` refers to the current object, what `self` references depends on the scope in which it is used. 

    When `self` is scoped at the class level, meaning it is used inside of a class but outside any instance methods, it references that class. This is why, to define a class method, we prefix the method name with `self`, so that Ruby knows the class itself will be invoking this method and not an object instantiated from the class. 

    When `self` is scoped at the object level, meaning it used inside an instance method within a class, it references the calling object. Using `self` within an instance method is useful when we want to invoke a setter method instead of directly accessing the instance variable. To let Ruby know that we want to invoke a setter method and not just create a new local variable, we must prefix the method invocation with `self`. 

43. What is inheritance, and why do we use it?

    Inheritance is how a class has the ability to inherit behaviors (instance methods) from another class.  

44. Give an example of how to use class inheritance.

45. Given an example of overriding. What would you use it?

46. Give an example of using the `super` method. When would we use it?

47. Give an example of using the `super` method with an argument.

48. When creating a hierarchical structure, under what circumstances would a module be useful?

49. What is interface inheritance, and under what circumstances would it be useful in comparison to class inheritance?

50. How is the method lookup path affected by module mixins and class inheritance?

51. What is namespacing?

52. How does Ruby provide the functionality of multiple inheritance?

53. Describe the use of modules as containers.

54. Why should a class have as few public methods as possible?

55. What is the `private` method call used for?

56. What is the `protected` keyword used for?

57. What are two rules of `protected` methods?

58. Why is it generally a bad idea to override methods from the Object class, and which method is commonly overridden?

59. What is the relationship between a class and an object?

60. Explain the idea that a class groups behaviors.

61. Objects do not share state between other objects, but do share behaviors