//
//  WeatherViewController+PickerView.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 04/02/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

extension WeatherViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return locationData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.locationName = locationData[row]
        
        navigationTitleButton.setTitle(locationName, for: .normal)
        self.hideShowPicker()
    
        self.getWeatherData()
    }

}
