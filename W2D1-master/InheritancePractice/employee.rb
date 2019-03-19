
class Employee
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = salary * multiplier
  end
  protected
  attr_reader :salary
end

class Manager < Employee
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    bonus = employees.sum do |employee|
      if employee.is_a? Manager
        employee.salary * multiplier + employee.bonus(multiplier)
      else
        employee.salary * multiplier
      end
    end
  end

  
  attr_reader :employees
end

if __FILE__ == $PROGRAM_NAME
  employee2 = Employee.new("notbob", "janitor", 10000, "james")
  employee1 = Employee.new("bob", "janitor", 12000, "james")
  manager1 = Manager.new("james", "bossman", 78000, "peter", [employee1, employee2])
  bigman = Manager.new("peter", "bossestman", 1000000, nil, [manager1])
  # p employee1
  # p manager1
  p manager1.bonus(4)
end