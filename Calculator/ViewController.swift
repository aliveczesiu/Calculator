//
//  ViewController.swift
//  Calculator
//
//  Created by Krzysztof Synowiec on 03/06/2017.
//  Copyright © 2017 Krzysztof Synowiec. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addiction
    case subtraction
    case multiplication
    
}

class ViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!

    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNumber:Int = 0
    var lastButtonWasMode:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addiction)
    }
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtraction)
    }
    @IBAction func didPressMultiply(_ sender: UIButton) {
        changeMode(newMode: .multiplication)
    }
    @IBAction func didPressEquals(_ sender: Any) {
        
        guard let labelInt:Int = Int (labelString) else {
            return
        }
        if (currentMode == .not_set || lastButtonWasMode) {
            return
        }
        
        if (currentMode == .addiction) {
            savedNumber = savedNumber + labelInt
        }
        else if (currentMode == .subtraction) {
            savedNumber = savedNumber - labelInt
        }
        
        else if (currentMode == .multiplication) {
            savedNumber = savedNumber * labelInt
        }
        currentMode = .not_set
        labelString = "\(savedNumber)"
        updateText()
        lastButtonWasMode = true
    }
    @IBAction func didPressClear(_ sender: Any) {
        
         labelString = "0"
         currentMode = .not_set
         savedNumber = 0
         lastButtonWasMode = false
         Label.text = "0"
        
        
    }
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if (lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }

    func updateText () {
        guard let labelInt:Int = Int (labelString) else {
            return
        }
        
        if (currentMode == .not_set) {
            savedNumber = labelInt
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle  = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        
        Label.text = formatter.string(from: num)
    }
    
    func changeMode (newMode:modes) {
        if (savedNumber == 0) {
            return
        }
        
        
        currentMode = newMode
        lastButtonWasMode = true
        
        
    }

    
}

