//
//  ViewController.swift
//  retro-calculator
//
//  Created by Ellen Shin on 5/11/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    @IBOutlet weak var output: UILabel!
    
    var runningNumber = ""
    var leftValstr = ""
    var rightValstr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    var buttonSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        output.text = runningNumber
        
    }

    @IBAction func onDividePress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Add)
    }
   
    @IBAction func onEqualPress(sender: AnyObject) {
        playSound()
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        
        if runningNumber != "" {
            if currentOperation != Operation.Empty {
                rightValstr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    result = String(Double(leftValstr)!*Double(rightValstr)!)
                }
                else if currentOperation == Operation.Divide {
                    result = String(Double(leftValstr)!/Double(rightValstr)!)
                }
                else if currentOperation == Operation.Subtract {
                    result = String(Double(leftValstr)!-Double(rightValstr)!)
                }
                else if currentOperation == Operation.Add {
                    result = String(Double(leftValstr)!+Double(rightValstr)!)
                }
                leftValstr = result
                output.text = result
                currentOperation = op
                
            } else {
                leftValstr = runningNumber
                runningNumber = ""
                currentOperation = op
            }
 
        }
            }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
}




















