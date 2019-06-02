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

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var Spinn: UIActivityIndicatorView!
    var input = ""


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AddToFavorites: UITabBarItem!

    
    @IBOutlet weak var TextZone: UITextView!

    var data: [String]! = []
    var filteredData: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.pasteConfiguration
        favoriteCities = NSEntityDescription.entity(forEntityName: "favoriteCities", in: context).cities

    }
    
    @IBOutlet var DisplaySearch: UISearchDisplayController!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("textFieldShouldReturn")
        return true
    }
    
   
    
    @IBAction func onChange(_ sender: UISwitch) {
        print("merde ", favoriteCities)
        print(sender.isOn, sender.isEnabled, sender.isSelected)
        var name = (sender.superview as! UITableViewCell).textLabel?.text as! String
        if sender.isOn {
            favoriteCities.append(findCity(tab: weatherClient.citiesSuggestions(for: name), name: name))
        
        }
        else {
            var acc = 0
            while acc < favoriteCities.count {
                if (favoriteCities[acc].name == name) {
                    favoriteCities.remove(at: acc)
                }
                acc += 1
            }
            // sender.setOn(false, animated: true)
        }
        
        
    }
    
    
    func isFavorite(s: String) -> Bool {
        for city in favoriteCities {
            if (city.name == s) {
                return true
            }
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        let button = UISwitch(frame: .zero)
        button.tag = indexPath.row // for detect which row switch Changed
        button.addTarget(self, action: #selector(self.onChange(_:)), for: .valueChanged)
        button.isOn = false
        if (isFavorite(s: filteredData[indexPath.row])) {
            button.isOn = true
        }
        cell.accessoryView = button
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = []
        var suggestion = ""
        for city in weatherClient.citiesSuggestions(for: searchText) {
            suggestion = "\(city.name)"
            filteredData.append(suggestion)
        }
        
        
        tableView.reloadData()
    }
    
    func checkSearch(data : String) -> Bool {
        var isIn = false
        for city in filteredData {
            if (data == city) {
                isIn = true
            }
        }
        return isIn
    }
    
    /* It is called each time user type a character by keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        tableView.isHidden = false
        if range.length != 0 {
            for _ in 1...range.length {
                input = String(input.dropLast())
            }
        }
        input += string
        print("input :'\(input)',string :'\(string)', range : '\(range)', length : \(range.length)")
        
        var suggestion = ""
    
        self.InputField.filterStrings(data)

        return true
    }*/
    
   /* @IBAction func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != nil && checkSearch(data: searchBar.text!)) {
            Spinn.isHidden = false
            Spinn.startAnimating()
            let semaphore = DispatchSemaphore(value: 0)
            TextZone.text = " "
            
            var result = "Message ?"
            let task = weatherClient.weather(for: weatherClient.citiesSuggestions(for: searchBar.text!)[0], completion: { response in
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
            //AddToFavorites.isHidden = false
            //favoriteCities.append(weatherClient.citiesSuggestions(for: input)[0])
        }
    }
    
    @IBAction func SubmitTabBar(_ sender: UITabBarItem) {
        favoriteCities.append(weatherClient.citiesSuggestions(for: input)[0])
    }*/

}

