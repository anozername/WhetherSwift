//
//  TableCellController.swift
//  WhetherSwift
//
//  Created by dant on 31/05/2019.
//  Copyright © 2019 dant. All rights reserved.
//

import UIKit
import Weather

var selected: String = " "

class TableCellController: UITableViewController {
    var TextZone = " "
  
    @IBOutlet var table: UITableView!
    
    var cellViewModels = [Forecast]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(favoriteCities)
        table.reloadData()
        /*let semaphore = DispatchSemaphore(value: 0)
        for city in favoriteCities {
            let task = weatherClient.weather(for: city, completion: { response in
                if let data = response {
                    print("response ok")
                    self.cellViewModels.append(data)
                    semaphore.signal()
                }
            })
            semaphore.wait()
        }*/
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return favoriteCities.count
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: UITableViewCell) {
        if (segue.identifier == "WEATHER") {
            
        }
    }*/
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = favoriteCities[indexPath.row].name
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        let cell = tableView.dequeueReusableCell(withIdentifier: "ville", for: indexPath)
        cell.textLabel?.text = favoriteCities[indexPath.row].name
        
        //cell.detailTextLabel?.text = String(cellViewModel.temperature)
        //cell.imageView?.image = cellViewModel.weather[0].icon
        return cell
    }
    
}
