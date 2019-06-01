//
//  ViewController.swift
//  WhetherSwift
//
//  Created by dant on 24/05/2019.
//  Copyright © 2019 dant. All rights reserved.
//

//  TODO debug touch screen

import UIKit
import Weather

public var favoriteCities: [City] = []

let weatherClient = WeatherClient(key: "e7a6caa465aee8f94b57375dde1ba754") // d4398ab9c5924d563949cf24f6881e50 or e7a6caa465aee8f94b57375dde1ba754

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var InputField: SearchTextField!
    @IBOutlet weak var TextZone: UITextView!
    @IBOutlet weak var Spinn: UIActivityIndicatorView!
    var input = ""
    
    @IBOutlet weak var SearchBar: UISearchBar!

    @IBOutlet weak var AddToFavorites: UITabBarItem!
    @IBOutlet weak var TabBarFavorite: UITabBar!
    override func viewDidLoad() {
        print("qsdf")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        InputField.delegate = self
        self.InputField.filterStrings(["None"])
        self.InputField.itemSelectionHandler = {item, itemPosition in
            self.InputField.text = item[itemPosition].title
            self.input = item[itemPosition].title
        }

    }
    
    @IBOutlet var DisplaySearch: UISearchDisplayController!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("textFieldShouldReturn")
        return true
    }
    
    // It is called each time user type a character by keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length != 0 {
            for _ in 1...range.length {
                input = String(input.dropLast())
            }
        }
        input += string
        print("input :'\(input)',string :'\(string)', range : '\(range)', length : \(range.length)")
        
        var suggestion = ""
        var suggestions = [""]
        for city in weatherClient.citiesSuggestions(for: input) {
            suggestion = "\(city.name)"
            suggestions.append(suggestion)
        }
        self.InputField.filterStrings(suggestions)

        return true
    }
    
    @IBAction func SubmitTabBar(_ sender: UITabBarItem) {
        favoriteCities.append(weatherClient.citiesSuggestions(for: input)[0])
    }

    @IBAction func SubmitButton(_ sender: UIButton) {
        Spinn.startAnimating()
        let semaphore = DispatchSemaphore(value: 0)
        TextZone.text = " "
    
        var result = "Message ?"
        let task = weatherClient.weather(for: weatherClient.citiesSuggestions(for: input)[0], completion: { response in
            if let data = response {
                print("response ok")
                self.TextZone.text = "Message : \(data)"
                semaphore.signal()
            }
        })
        semaphore.wait()

        if input == "klknlk" {
            print("result is at its default value")
        }else if input == "" || input == " "{
            print("result is empty")
        }else{
            print("result : '\(input)'")
        }
        Spinn.stopAnimating()
        TabBarFavorite.isHidden = false
        favoriteCities.append(weatherClient.citiesSuggestions(for: input)[0])
        //AddToFavorites.setValue(weatherClient.citiesSuggestions(for: input)[0], forKey: "city")
        
    }
}

