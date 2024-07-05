=begin
Scenario 1: Restaurant Management System
Requirements:
+ There are Chefs, Waiters, Customers, and a Manager.
+ All staff members (chefs, waiters, and managers) have names and employee IDs.
+ Chefs can cook dishes.
+ Waiters can take orders and serve food.
+ Customers can place orders and eat food.
+ The manager can manage the restaurant and check on staff.
+ All staff members can receive their salary.
=end

# class StaffMember
#   attr_reader :name

#   def initialize(name, id_number)
#     @name = name
#     @id_number = id_number
#   end

#   def receive_salary(paycheck_amount)
#     p "Here is your $#{paycheck_amount} pay check."
#   end
# end

# class Chef < StaffMember
#   def cook_dish(dish)
#     p "Cooking #{dish}"
#   end
# end

# class Waiter < StaffMember
#   def take_order(dish)
#     puts "Thank you for your order. Your #{dish} will be out soon."
#   end

#   def serve_food(dish)
#     p "Here is your #{dish}"
#   end
# end

# class Manager < StaffMember
#   def manage_restaurant
#     p "Managing restaurant"
#   end

#   def check_on_staff(staff_member)
#     p "Checking on #{staff_member.name} the #{staff_member.class}"
#   end
# end

# class Customer
#   def place_order(waiter)
#     order = ''
#     puts "Hello, your waiter #{waiter.name} can now take your order."
#     loop do
#       puts "What would you like to eat? =>"
#       order = gets.chomp
#       break if order != ''
#       puts "Invalid order"
#     end
#     waiter.take_order(order)
#     order
#   end

#   def eat_food(dish)
#     p "Eating my #{dish}"
#   end
# end

# chef = Chef.new('Remy', 123)
# waiter = Waiter.new('Alexa', 456)
# manager = Manager.new('Joe', 789)
# customer = Customer.new

# customers_order = customer.place_order(waiter)
# chef.cook_dish(customers_order)
# manager.manage_restaurant
# manager.check_on_staff(waiter)
# waiter.serve_food(customers_order)
# customer.eat_food(customers_order)

=begin
Scenario 2: University System
Requirements:
+ There are Professors, Students, Courses, and an Administrator.
+ Professors have a name, an employee ID, and can teach courses.
+ Students have a name, a student ID, and can enroll in courses.
+ Administrators have a name and an employee ID
+ Courses have a title, a course code, and a list of enrolled students.
+ The administrator can add courses, assign professors to courses, and enroll students in courses.
+ Students can attend courses and take exams.
=end

# class Person
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end
# end

# class UniversityEmployee < Person
#   def initialize(name, employee_id)
#     super(name)
#     @employee_id = employee_id
#   end
# end

# class UniversityStudent < Person
#   def initialize(name, student_id)
#     super(name)
#     @student_id = student_id
#   end
# end

# class Professor < UniversityEmployee
#   def teach_course(course)
#     "#{self.class} #{self.name} is teaching #{course.title}"
#   end
# end

# class Student < UniversityStudent
#   def enroll_in_course(course)
#     course.enrolled_students << self.name
#     "#{self.name} enrolled in #{course.title}"
#   end

#   def attend_course(course)
#     "#{self.class} #{self.name} is attending #{course.title}"
#   end

#   def take_exam(course)
#     "#{self.class} #{self.name} is taking an exam for #{course.title}"
#   end
# end

# class Administrator < UniversityEmployee
#   def add_course(title, course_code)
#     Course.new(title, course_code)
#     "#{self.class} #{self.name} has added a new course: #{title}"
#   end

#   def assign_professor_course(professor, course)
#     professor.teach_course(course)
#     "#{professor.class} #{professor.name} will teach #{course.title}"
#   end

#   def enroll_student_in_course(student, course)
#     course.enrolled_students << student.name
#     "#{self.class} #{self.name} has enrolled #{student.name} in #{course.title}"
#   end
# end

# class Course
#   attr_reader :title, :enrolled_students

#   def initialize(title, course_code)
#     @title = title
#     @course_code = course_code
#     @enrolled_students = []
#   end
# end

# alyssa = Student.new('Alyssa Easter', 519169990)
# mr_g = Professor.new('Joesph Goldburg', 123456789)
# admin = Administrator.new("Abby Ministrator", 909012121)

# rb129 = Course.new("Ruby 129", 129129)

# p admin.assign_professor_course(mr_g, rb129)
# p admin.enroll_student_in_course(alyssa, rb129)
# p alyssa.attend_course(rb129)
# p mr_g.teach_course(rb129)
# p alyssa.take_exam(rb129)

# p admin.add_course('RB 130', 130130)

=begin
Scenario 3: Banking System
Requirements:
+ There are Customers, Accounts (Checking, Savings), and BankEmployees (Tellers, Managers).
+ Customers have a name, customer ID, and can own accounts.
+ Accounts have a balance and can be deposited into and withdrawn from.
Bank employees have a name, employee ID, and can perform transactions on accounts.
Tellers can deposit into and withdraw from accounts.
Managers can open new accounts and view all transactions.
Customers can view their account balance.
=end

# class Customer
#   def initialize(name, customer_id)
#     @name = name
#     @customer_id = customer_id
#     @accounts = []
#   end

#   def view_account_balance
#     if @accounts.empty?
#       puts "You do not have any accounts open yet."
#     else
#       @accounts.each do |account|
#         puts "Your #{account.type} balance is $#{account.balance}"
#       end
#     end
#   end

#   def add_account(new_account)
#     @accounts << new_account
#   end

#   protected

#   attr_accessor :accounts
# end

# class Account
#   attr_reader :type, :balance

#   def initialize
#     @balance = 0
#     @type = self.class
#   end

#   def deposit(amount)
#     @balance += amount
#   end

#   def withdrawl(amount)
#     @balance -= amount
#   end
# end

# class Checking < Account
# end

# class Saving < Account
# end

# class BankEmployee
#   def initialize(name, employee_id)
#     @name = name
#     @employee_id = employee_id
#   end
# end

# class Teller < BankEmployee
#   def perform_deposit(customer, account)
#   end

#   def perform_withdrawl(customer, account)
#   end
# end

# class Manager < BankEmployee
#   def open_account(customer, type)
#     if type.downcase == 'saving'
#       customer.add_account(Saving.new)
#     elsif type.downcase == 'checking'
#       customer.add_account(Checking.new)
#     else
#       "Invalid account type. Please try again."
#     end
#   end

#   def view_all_transactions
#   end
# end

# alyssa = Customer.new("Alyssa Easter", 8923139)
# alyssa.view_account_balance

# manager = Manager.new('Connie', 123456)
# manager.open_account(alyssa, 'saving')

# alyssa.view_account_balance
=begin
Scenario 4: E-learning Platform
Requirements:
There are Instructors, Students, Courses, and a PlatformAdministrator.
Instructors have a name, an employee ID, and can create courses.
Students have a name, a student ID, and can enroll in courses.
Courses have a title, course content, and a list of enrolled students.
The platform administrator can add courses, assign instructors to courses, and enroll students in courses.
Students can complete assignments and receive grades.
=end

=begin
Scenario 5: Social Media Platform
Requirements:
There are Users, Posts, Comments, and an Admin.
Users can create posts and comment on posts.
Posts have a title, content, and a list of comments.
Comments have content and are associated with a user and a post.
The admin can manage users and moderate posts and comments.
Users can like posts and comments.
=end

class User
  def initialize(name)
    @name = name
    @posts = []
    @comments = []
  end

  def create_post(title, content)
    puts "'#{title}' has been posted!"
    @posts << Post.new(title, content)
  end

  def comment_on_post(post)
  end

  def like_post(post)
    post.add_like
    "The post: '#{post.title}', has #{post.likes} likes."
  end

  def like_comment(comment)
    comment.likes += 1
    "The comment: '#{comment.content}', has #{comment.likes} likes."
  end
end

class Post
  attr_reader :comments, :likes

  def initialize(title, content)
    @title = title
    @content = content
    @comments = []
    @likes = 0
    "'#{title}' has been posted!"
  end

  def add_like
    @likes += 1
  end
end

class Comment
  attr_accessor :likes

  def initialize(content)
    @content = content
    @likes = 0
    "'#{content}' has been posted!"
  end
end

alyssa = User.new('Alyssa')
winnie_pic = alyssa.create_post("Winnie", "Photo of cute dog")

rich = User.new('Richard')
p rich.like_post(winnie_pic)

class Admin
  def manage_user
  end

  def moderate_post
  end

  def moderate_comments
  end
end