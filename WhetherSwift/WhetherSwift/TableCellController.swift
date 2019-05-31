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
    
    var cellViewModels = [URLCellTable]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var city = favoriteCities[0]
        var result : (Forecast?) -> Void
        weatherClient.weather(for: city, completion: result)
    }
}
