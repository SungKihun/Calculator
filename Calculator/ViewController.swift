//
//  ViewController.swift
//  Calculator
//
//  Created by 성기훈 on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.titleLabel!.text!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = zeroFilter(num: textCurrentlyInDisplay + digit)
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    func zeroFilter(num: String) -> String{
        
        if num.first == "0" {
            
            let numSecondIndex = num.index(num.startIndex, offsetBy: 1)
            
            if num[numSecondIndex] == "0" {
                return "0"
            } else if num[numSecondIndex] != "0" && num[numSecondIndex] != "." {
                var numString = num
                numString.removeFirst()
                
                return numString
            } else {
                return num
            }
        } else {
            return num
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = removePoint(num: newValue)
        }
    }
    
    func removePoint(num: Double) -> String {
        var floatNumString = String(num)
        
        while floatNumString.last == "0" {
            floatNumString.removeLast()
        }
        
        if floatNumString.last == "."{
            floatNumString.removeLast()
        }
        
        return floatNumString
    }
    
    var displayValueInteger: Int {
        get {
            return Int(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.titleLabel!.text {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
}
