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
        if monthString.count == 0
        {
            self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else
        {
            self.backgroundColor = #colorLiteral(red: 1, green: 0.768627451, blue: 0.1450980392, alpha: 0.5)
        }
        
         weatherDataLabel.text = monthString
    }
    
    func setupCellForYear(WithData weatherData: WeatherModel?)
    {
        self.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.4666666667, blue: 0.2078431373, alpha: 0.5)
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
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
