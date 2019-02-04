//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 01/02/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell
{
    //UI Elements
    @IBOutlet weak var weatherDataLabel: UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellForMonth(monthString: String)
    {
         weatherDataLabel.text = monthString
    }
    
    func setupCellForYear(WithData weatherData: WeatherModel?)
    {
        guard let weather_data = weatherData else
        {
            weatherDataLabel.text = "N/A"
            return
        }
        
        guard let dataValue = weather_data.year else
        {
            weatherDataLabel.text = "N/A"
            return
        }
        
        weatherDataLabel.text = String(dataValue)
    }
    
    func setupCell(WithData weatherData: WeatherModel?)
    {
        guard let weather_data = weatherData else
        {
            weatherDataLabel.text = "N/A"
            return
        }
        
        guard let dataValue = weather_data.value else
        {
            weatherDataLabel.text = "N/A"
            return
        }
        
        weatherDataLabel.text = String(dataValue)
    }

}
