//
//  FindCity.swift
//  WhetherSwift
//
//  Created by dant on 02/06/2019.
//  Copyright © 2019 dant. All rights reserved.
//

import Foundation
import Weather

func findCity(tab: [City], name: String) -> City {
    for city in tab {
        if (city.name == name) {
            return city
        }
    }
    return tab[0]
}
