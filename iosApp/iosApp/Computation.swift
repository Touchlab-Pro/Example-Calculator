//
//  Computation.swift
//  iosApp
//

import Foundation
import CalculatorSample

class Computation : ObservableObject {
    @Published var readout = "0"
    @Published var op : OperationType? = nil

    var previousNumber = ""
    var current = ""
    var replaceDigit = true
    
    func input(inputValue: String) {
        let entryType : EntryType = EntryTypeKt.lookupEntryType(value: inputValue)
        handleNumericTyping(entryType: entryType, inputValue: inputValue)
        
        if (entryType == EntryType.operation) {
            let operationType = OperationTypeKt.lookupOperationType(
                value: inputValue, defaultValue: OperationType.UNKNOWN(message: "unknown")
            )
            handleMathOperation(operationType: operationType)
        }
    }
    
    func handleMathOperation(operationType: OperationType) {
        if (operationType is OperationType.CLEAR) {
            doClear()
        } else if (operationType is OperationType.DELETE) {
            doDelete()
        } else if (operationType is OperationType.EQUALS) {
            doEquals()
        } else if (operationType is OperationType.PLUS ||
                   operationType is OperationType.MINUS ||
                   operationType is OperationType.MULTIPLY ||
                   operationType is OperationType.DIVIDE) {
            if (previousNumber.count > 0 && op != nil) {
                previousNumber = "\(doMath())"
                readout = previousNumber
                op = operationType
            } else {
                previousNumber = current
                op = operationType
            }
        }
    }
    
    func handleNumericTyping(entryType : EntryType, inputValue: String) {
        switch (entryType) {
        case .numeric:
            if (replaceDigit) {
                current = inputValue
            } else {
                if (inputValue == "." ) {
                    if (!current.contains(".")) {
                        current = current+inputValue
                    }
                } else {
                    current = current+inputValue
                }
            }
            replaceDigit = false
            readout = current
        case .operation:
            replaceDigit = inputValue != "<"
        default:
            print("Do nothing")
        }
    }
    
    func doClear() {
        replaceDigit = true
        current = ""
        previousNumber = ""
        op = nil
        readout = "0"
    }
    
    func doDelete() {
        if (current.count > 0) {
            current.remove(at: current.index(before: current.endIndex))
            if (current.count == 0){
                readout = "0"
            } else {
                readout = current
            }
        }
    }
    
    func doEquals() {
        if (previousNumber.count > 0 && current.count > 0 && op != nil) {
            let result = doMath()
            previousNumber = result
            current = result
            readout = result
        }
        replaceDigit = true
        op = nil
    }
    
    func doMath() -> String {
        let prev = Double(previousNumber)!
        let curr = Double(current)!
        var result = ""
        if (op is OperationType.PLUS) {
            result = "\(prev + curr)"
        } else if (op is OperationType.MINUS) {
            result = "\(prev - curr)"
        } else if (op is OperationType.MULTIPLY) {
            result = "\(prev * curr)"
        } else if (op is OperationType.DIVIDE) {
            result = "\(prev / curr)"
        }
        return result
    }
}
