//
//  ViewController.swift
//  WhetherSwift
//
//  Created by dant on 24/05/2019.
//  Copyright © 2019 dant. All rights reserved.
//

import UIKit
import Weather

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var InputField: UITextField!
    @IBOutlet weak var TextZone: UITextView!
    let defaults = UserDefaults.standard
    let weatherClient = WeatherClient(key: "e7a6caa465aee8f94b57375dde1ba754")
    
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

        var something = ""
        let task = weatherClient.weather(for: weatherClient.citiesSuggestions(for: "Paris")[0], completion: { data in
            if let data = data {
                //print(data) ok
                something = String(decoding: data, as: UTF8.self)
            } else {
                // no data and no error... what happened???
            }
        })
        if let input = defaults.string(forKey: "input"){
            TextZone.text = something
        }
    }
    
}

