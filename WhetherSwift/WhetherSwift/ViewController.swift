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
    @IBOutlet weak var Spinn: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    let weatherClient = WeatherClient(key: "e7a6caa465aee8f94b57375dde1ba754") // d4398ab9c5924d563949cf24f6881e50 or e7a6caa465aee8f94b57375dde1ba754
    
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
        Spinn.startAnimating()
        let semaphore = DispatchSemaphore(value: 0)
        TextZone.text = " "
        var result = "Message ?"
        let task = weatherClient.weather(for: weatherClient.citiesSuggestions(for: "Paris")[0], completion: { response in
            if let data = response {
                print("response ok")
                self.TextZone.text = "Message : \(data)" // 63 sec pending
                semaphore.signal()
                self.Spinn.stopAnimating()
            }
        })
        semaphore.wait()
        
        if let input = defaults.string(forKey: "input"){
            // TextZone.text = result
            print("submitted")
        }
    }
}

