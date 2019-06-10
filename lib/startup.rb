require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(name, title)
        if !self.valid_title?(title)
            raise "Not a valid title"
        else
            @employees << Employee.new(name, title)
        end
    end

    def size
        employees.length
    end

    def pay_employee(employee)
        employee_salary = @salaries[employee.title]
        if employee_salary < funding
            employee.pay(employee_salary)
            @funding -= employee_salary
        else
            raise "Not enough funds"
        end
    end

    def payday
        @employees.each do |employee|
         pay_employee(employee)
        end
    end
    
    def average_salary
        total = 0
        employees.each do |employee|   
            total += salaries[employee.title]
        end
        return total / employees.length
    end


    def close
        @funding = 0
        @employees = []
    end

    def acquire(startup)
      @funding += startup.funding

        startup.salaries.each do |title, amount|
            if !@salaries.has_key?(title)
                @salaries[title] = amount
            end
        end
        @employees += startup.employees
      startup.close
    end
end







