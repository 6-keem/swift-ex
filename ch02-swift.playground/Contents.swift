import Cocoa

enum VendingMachineError : Error{
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count : Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Soda" : Item(price: 7, count: 11),
    ]
    
    var coinsDeposited = 0
    
    func vend(itenNamed name : String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
    
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 32

do {
    try vendingMachine.vend(itenNamed: "Chips")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.outOfStock {
    print("Out of Stock")
} catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error). ")
}

let x = try? vendingMachine.vend(itenNamed: "Chips")
print(x)

let y = try! vendingMachine.vend(itenNamed: "Candy Bar")
print(y)

let z = try? vendingMachine.vend(itenNamed: "Pretzels")
print(z)

let w = try! vendingMachine.vend(itenNamed: "Pretzels")
print(w)


