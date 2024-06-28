<h2>LS 120 Questions</h2>

1. <b>What is OOP and why is it important?</b> 

   OOP stands for "object oriented programming". It is a programming paradigm that allows for more organized and flexible code. By creating objects that contain both state (data) and behavior (functionality) it allows us to have a self-contained component of our program that can be changed or manipulated without affecting our entire program. By breaking down our code into smaller, more manageable parts, it makes our code more organized and easier to read and modify when needed. It is important because without OOP our program would be very fragile and likely to have a ripple effect throughout the entire program from just one error.

2. <b>What is encapsulation?</b> 

   Encapsulation is a form of data protection where data (state) and functionality (behavior) are combined into a single unit called an "object". By containing an object's state and behavior within itself, encapsulation then allows us to pass these objects around in our program. We can choose to hide certain data or expose it as needed, which helps in organizing and protecting the inner workings of our code.

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

12. What is the difference between a superclass and a subclass?

13. What is a module?

14. What is a mixin?

15. When is it good to use inheritance?

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

    An object encapsulates its state within itself by the use of instance variables. The state of an object refers to the collection of that object's instance variables. When defining a class, we will want to create instance variables to hold the important data that an object of that class should have. Whereas, the behavior of an object is determined by the methods available to that object. By defining instance methods within our class, we enable specific behaviors for objects instantiated from that class. For example, if we define a `Dog` class and within that class, we define a `speak` instance method, we have given any object instantiated from the `Dog` class the ability to `speak` - this is considered the `Dog`'s behavior.

19. How do you initialize a new object?

20. What is a constructor method?

21. What is an instance variable, and how is it related to an object?

22. What is an instance method?

23. <b>How do objects encapsulate state?</b> 

    An object encapsulates its state within itself by the use of instance variables. The state of an object refers to the collection of that object's instance variables. When defining a class, we will want to create instance variables to hold the important data that an object of that class should have. When an object is instantiated from a class, that object will contain it's own unique state.

24. What is the difference between classes and objects?

25. How can we expose information about the state of the object using instance methods?

26. <b>What is a collaborator object, and what is the purpose of using collaborator objects in OOP?</b> 

    A collaborator object is any object that is being held within the state (instance variable) of another object. The purpose of using collaborator objects is to enable objects to interact and collaborate with other objects in our program. EX:

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

28. What is a getter method?

29. What is a sett method?

30. What is attractive_accessor?

31. <b>How do you decide whether to reference an instance variable or a getter method?</b> 

    Generally speaking, it is usually a good idea to invoke a getter method if there is one, rathr than reference the instance variable. When there is a getter method avaialbe to retrieve an instance method, you should invoke that because there could be important implementation within that getter method definition that may be needed. For example, if there is `@dob` instance variable within a `Person` object, that holds an Array object with three numeric elements that represent the persons month, day, and year of birth but when we retrieve the data we would like to have it formatted as a String in `'mm/dd/yyyy'` fashion; we could put that implementation into the getter method. EX:

    In the code below, the `Person#info` instance method invokes the `dob` getter method which formats the `Person` object's `@dob` variable the way in which we want when retrieving it. 

    ```ruby
    class Person
      def initialize(name, dob)
        @name = name
        @dob = dob
      end
    
      def dob
        "#{@dob[0]}/#{@dob[1]}/#{@dob[2]}"
      end
    
      def info
        "Hello, I am #{@name} and my birthday is #{dob}" # here the `dob` getter method is being invoked
      end
    end
    
    bob = Person.new('Robert', [1, 2, 2000])
    bob.info # => "Hello, I am Robert and my birthday is 1/2/2000"
    ```

    However, if we re-write the `Person#info` method to reference the `@dob` instance variable instead of the getter method, this is the output we will see:

    ```ruby
    class Person
      def initialize(name, dob)
        @name = name
        @dob = dob
      end
    
      def dob
        "#{@dob[0]}/#{@dob[1]}/#{@dob[2]}"
      end
    
      def info
        "Hello, I am #{@name} and my birthday is #{@dob}" # here the `@dob` instance variable is being referenced
      end
    end
    
    bob = Person.new('Robert', [1, 2, 2000])
    bob.info # => "Hello, I am Robert and my birthday is [1, 2, 2000]"
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

    You would call a method with `self` when invoking a class method.

34. What are class methods?

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