//
//  TableCellController.swift
//  WhetherSwift
//
//  Created by dant on 31/05/2019.
//  Copyright © 2019 dant. All rights reserved.
//

import UIKit
import Weather

class TableCellController: UITableViewController {
    var TextZone = " "
    var cellViewModels = [Forecast]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let semaphore = DispatchSemaphore(value: 0)
        for city in favoriteCities {
            let task = weatherClient.weather(for: city, completion: { response in
                if let data = response {
                    print("response ok")
                    self.cellViewModels.append(data)
                    semaphore.signal()
                }
            })
            semaphore.wait()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = formatter.string(from: cellViewModel.date)
        //cell.detailTextLabel?.text = String(cellViewModel.temperature)
        cell.imageView?.image = cellViewModel.weather[0].icon
        return cell
    }
    
}
