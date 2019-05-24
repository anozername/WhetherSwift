//
//  ViewController.swift
//  WhetherSwift
//
//  Created by dant on 24/05/2019.
//  Copyright © 2019 dant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var InputField: UITextField!
    @IBOutlet weak var TextZone: UITextView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        InputField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        defaults.set(textField.text, forKey: "input")
    }

    @IBAction func SubmitButton(_ sender: UIButton) {
        if let input = defaults.string(forKey: "input"){
            TextZone.text = input
        }
    }
    
}

