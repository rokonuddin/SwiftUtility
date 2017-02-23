//: Playground - noun: a place where people can play

import UIKit


/**  **associatedtype** associatedtype Gives a placeholder name to a type that is used as part of a protocol. The type is not specified until the protocol is adopted. */

protocol Entertainment {
    associatedtype MediaType
}
class Foo : Entertainment {
    typealias MediaType = String //Could be any type to fit the need
}


/**
 **extension** Lets one add new functionality to an existing class, structure, enumeration, or protocol type.
 */
class Person {
    var name:String = ""
    var age:Int = 0
    var gender:String = ""
}
extension Person {
    func printInfo() {
        print("My name is \(name), I'm \(age) years old and I'm a \(gender).")
    }
}

/** **fileprivate** An access control construct that restricts scope to only the defining source file.*/

class Job {
    fileprivate var jobTitle:String = ""
}
extension Job {
    //This wouldn't compile using "private"
    func printJobTitle() {
        print("My job is \(jobTitle)")
    }
}


/**
 **inout** A value that is passed to a function and modified by it, and is passed back out of the function to replace the original value. Applies to both reference and value types.
 */

func dangerousOp(_ error:inout NSError?) {
    error = NSError(domain: "", code: 0, userInfo: ["":""])
}
var potentialError:NSError?
dangerousOp(&potentialError)
//Now potentialError is no longer nil and initialized



/**
 **internal** An access control construct that allows entities to be used within any source file from its defining module, but not in any source file outside of it.
 */
class Car {
    internal var carName:String = ""
}
let car = Car()
car.carName = "BMW"








