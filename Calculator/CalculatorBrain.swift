//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 성기훈 on 2021/10/07.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Double> = [
        "π": .pi,
        "e": M_E
    ]
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }   
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
