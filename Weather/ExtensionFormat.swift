//
//  ExtensionFormat.swift
//  Weather
//
//  Created by MacOne-YJ4KBJ on 15/06/2022.
//

import Foundation
import UIKit

extension Double{
    func formatWindMs() -> String{
        return String(format: "%.2f", self) + " M/s"
    }
    
    func formatWindMilh() -> String{
        let mil = self * 3600 / 1000 / 1.6
        return String(format: "%.1f", mil) + " Mil/h"
    }
    
    func formatWindKh() -> String{
        let km = self * 3600 / 1000
        return String(format: "%.0f", km) + " Km/h"
    }
    
    func formatTempC() -> String{
        let tempC = self - 273.15
        return String(format: "%.0f", tempC) + "°C"
    }
    
    func formatHumidity() -> String{
        return String(format: "%.0f", self) + "%"
    }
    
    func formatDate() -> String{
        let timeResult : Double = self
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE | dd.MM"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        print(localDate)
        return localDate
   
    }
}
