//
//  ViewController.swift
//  MyCalculator
//
//  Created by aulbourn knowles on 10/22/16.
//  Copyright © 2016 Think Feel Cre8. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String {
        case Empty = "Empty"    //assigns a member of 'Empty' to Operation
        case Add = "+"         //assigns a member of 'Add' to Operation
        case Divide = "/"       //assigns a member of 'Divide' to Operation
        case Multiply = "*"     //assigns a member of 'Multiply' to Operation
        case Subtract = "-"     //assigns a member of 'Subtract' to Operation
    }
    
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var runningNumber = ""
    var btnPressedSound = AVAudioPlayer()
    var currentOperation = Operation.Empty
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "Fuzzy Beep", ofType: "wav")
        
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnPressedSound = AVAudioPlayer(contentsOf: soundURL)
            
            btnPressedSound.prepareToPlay()
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    @IBAction func onMultiplyBtnPressed(_ sender: AnyObject) {
        processOperation(.Multiply)
    }
    
    @IBAction func onDivideBtnPressed(_ sender: AnyObject) {
        processOperation(.Divide)
    }
    
    @IBAction func onAddBtnPressed(_ sender: AnyObject) {
        processOperation(.Add)
    }
    
    @IBAction func onSubtractBtnPressed(_ sender: AnyObject) {
        processOperation(.Subtract)
    }
    
    @IBAction func equalBtnPressed(_ sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        
        outputLbl.text = runningNumber
    }
    
    @IBAction func resetBtn(_ sender: AnyObject) {
        if leftValue != "" {
            leftValue = ""
        }
        
        if rightValue != "" {
            rightValue = ""
        }
        
        if result != "" {
            result = ""
        }
        
        if runningNumber != "" {
            runningNumber = ""
        }
        
        if outputLbl.text != "0" {
            outputLbl.text = "0"
        }
        
        if currentOperation != Operation.Empty {
            currentOperation = Operation.Empty
        }
    }
    
    func processOperation(_ operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }
                
                else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                
                else if currentOperation == Operation.Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                
                else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                
                leftValue = result
                outputLbl.text = result
                
            }
            
                currentOperation = operation
            } else {
                leftValue = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
        
        }
        
    

        





    func playSound() {
        if btnPressedSound.isPlaying {
            btnPressedSound.stop()
        }
        
        btnPressedSound.play()
    }

}



