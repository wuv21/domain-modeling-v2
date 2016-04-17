//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
  }
}

////////////////////////////////////
// Mathematics protocol
//
protocol Mathematics {
    func +(left: Self, right: Self) -> Self
    func -(left: Self, right: Self) -> Self
}

////////////////////////////////////
// Double extension
//
extension Double {
    func GBP() -> Money { return Money(amount: Int(self * 0.5), currency: "GBP") }
    func USD() -> Money { return Money(amount: Int(self), currency: "USD") }
    func EUR() -> Money { return Money(amount: Int(self * 1.5), currency: "EUR") }
    func CAN() -> Money { return Money(amount: Int(self * 5/4), currency: "CAN") }
    
}

////////////////////////////////////
// Money
//
func +(left: Money, right: Money) -> Money {
    return Money(amount: left.amount + right.convert(left.currency).amount, currency: left.currency)
}

func -(left: Money, right: Money) -> Money {
    return Money(amount: left.amount - right.convert(left.currency).amount, currency: left.currency)
}

public struct Money : CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String

    public var description : String {
        get {
            return self.currency + String(self.amount)
        }
    };
  
    public func convert(to: String) -> Money {
        switch to {
        case "GBP":
            if self.currency == "USD" {
                return Money(amount: Int(Double(self.amount) * 0.5), currency: to)
            } else if self.currency == "EUR" {
                return Money(amount: Int(Double(self.amount) * 1/3), currency: to)
            } else if self.currency == "CAN" {
                return Money(amount: Int(Double(self.amount) * 2/5), currency: to)
            } else {
                return Money(amount: self.amount, currency: to)
            }
            
        case "CAN":
            if self.currency == "USD" {
                return Money(amount: Int(Double(self.amount) * 5/4), currency: to)
            } else if self.currency == "EUR" {
                return Money(amount: Int(Double(self.amount) * 5/6), currency: to)
            } else if self.currency == "GBP" {
                return Money(amount: Int(Double(self.amount) * 5/2), currency: to)
            } else {
                return Money(amount: self.amount, currency: to)
            }
        
        case "USD":
            if self.currency == "EUR" {
                return Money(amount: Int(Double(self.amount) * 2/3), currency: to)
            } else if self.currency == "GBP" {
                return Money(amount: self.amount * 2, currency: to)
            } else if self.currency == "CAN" {
                return Money(amount: Int(Double(self.amount) * 4/5), currency: to)
            } else {
                return Money(amount: self.amount, currency: to)
            }
        
        case "EUR":
            if self.currency == "USD" {
                return Money(amount: Int(Double(self.amount) * 1.5), currency: to)
            } else if self.currency == "GBP" {
                return Money(amount: self.amount * 3, currency: to)
            } else if self.currency == "CAN" {
                return Money(amount: Int(Double(self.amount) * 6/5), currency: to)
            } else {
                return Money(amount: self.amount, currency: to)
            }
        default:
            print("Currency not correct")
            return Money(amount: 0, currency: "")
        }
    }
  
    public func add(to: Money) -> Money {
        if to.currency == self.currency {
            return Money(amount: self.amount + to.amount, currency: self.currency)
        } else {
            let converted_src = self.convert(to.currency)
            return Money(amount: converted_src.amount + to.amount, currency: to.currency)
        }
    }
        
    public func subtract(from: Money) -> Money {
        if from.currency == self.currency {
            return Money(amount: from.amount - self.amount, currency: from.currency)
        } else {
            let converted_src = self.convert(from.currency)
            return Money(amount: from.amount - converted_src.amount, currency: from.currency)
        }
    }
}

////////////////////////////////////
// Job
//
public class Job {
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }

  public var title : String
  public var salary: JobType
  
  public init(title : String, type : JobType) {
    self.title = title
    self.salary = type
  }
  
  public func calculateIncome(hours: Int) -> Int {
    switch self.salary {
    case .Salary(let valueS):
        return valueS
        
    case .Hourly(let valueH):
        return Int(valueH * Double(hours))
    }
  }
  
  public func raise(amt : Double) {
    switch self.salary {
    case .Salary(let valueS):
        self.salary = Job.JobType.Salary(Int(Double(valueS) + amt))
    case .Hourly(let valueH):
        self.salary = Job.JobType.Hourly(valueH + amt)
    }
  }
}

////////////////////////////////////
// Person
//
public class Person {
  public var firstName : String = ""
  public var lastName : String = ""
  public var age : Int = 0
  private var _job : Job?
  private var _spouse : Person?

  public var job : Job? {
    get { return self._job }
    set(value) {
        if self.age >= 16 {
            self._job = value
        }
    }
  }
  
  public var spouse : Person? {
    get { return self._spouse}
    set(value) {
        if self.age >= 18 {
            self._spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  public func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]";
  }
}

////////////////////////////////////
// Family
//
public class Family {
  private var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        
        self.members.append(spouse1)
        self.members.append(spouse2)
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    var count = 0
    var age_test = false
    while !age_test && members.count > 0{
        if members[count].age >= 21 {
            age_test = true
        }
        
        count += 1
    }
    
    if age_test {
        child.age = 0;
        self.members.append(child)
        return true
    }
    
    return false
  }
  
  public func householdIncome() -> Int {
    var total = 0
    for member in self.members {
        if member.job != nil {
            total += member.job!.calculateIncome(2000)
        }
    }
    
    return total
  }
}





