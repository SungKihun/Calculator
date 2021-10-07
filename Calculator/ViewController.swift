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
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
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
