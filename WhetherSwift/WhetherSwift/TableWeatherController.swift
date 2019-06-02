//
//  TableCellController.swift
//  WhetherSwift
//
//  Created by dant on 31/05/2019.
//  Copyright © 2019 dant. All rights reserved.
//

import UIKit
import Weather

class TableWeatherController: UITableViewController {
    var weather : [Forecast] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let semaphore = DispatchSemaphore(value: 0)
        self.title = selected
        
       let task = weatherClient.forecast(for: findCity(tab: weatherClient.citiesSuggestions(for: self.title!), name: self.title!), completion: { response in
            if let data = response {
                self.weather = data
                semaphore.signal()
            }
        })
        semaphore.wait()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return weather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = formatter.string(for: weather[indexPath.row].date)
        cell.detailTextLabel?.text = weather[indexPath.row].weather[0].description
        cell.imageView?.image = weather[indexPath.row].weather[0].icon
        return cell
    }
}
