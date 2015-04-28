class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    add_employee_to_boss unless boss.nil?
  end

  def add_employee_to_boss
    # p @boss.employees
    @boss.employees << self
  end

  def bonus(multiplier)
    @bonus = (@salary * multiplier)
  end
end

class Manager < Employee
  def initialize(name, title, salary, boss)
    super
    @employees = []
  end

  def employees
    @employees
  end

  def bonus(multiplier)
    total = 0
    stack = []
    self.employees.each do |employee|
      stack << employee
    end

    until stack.empty?
      current = stack.shift
      total += current.salary
      if current.is_a?(Manager)
        current.employees.each do |employee|
          stack << employee
        end
      end
    end

    return total * multiplier
  end
end

ned = Manager.new("ned", "Founder", 1000000, nil)
darren = Manager.new("darren", "TA Manager", 78000, ned)
shawna = Employee.new("shawna", "TA", 12000, darren)
david = Employee.new("david", "TA", 10000, darren)

# p ned
# p darren.employees

p ned.bonus(5)
p darren.bonus(4)
p shawna.bonus(3)
p david.bonus(3)
