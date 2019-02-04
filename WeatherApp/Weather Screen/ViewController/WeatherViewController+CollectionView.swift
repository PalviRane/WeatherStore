//
//  WeatherViewController+CollectionView.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 31/01/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        guard let weatherGroupArray = weatherVM.weatherSortedArray else
        {
            return 0
        }
        return weatherGroupArray.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        if indexPath.section == 0
        {
            let monthString = self.monthData[indexPath.row]
            dataCell.setupCellForMonth(monthString: monthString)
        }
        else
        {
            guard let weatherGroupArray = weatherVM.weatherSortedArray else
            {
                return dataCell
            }
            
            let currentGroup = weatherGroupArray[indexPath.section-1]
            
            if indexPath.row == 0
            {
                let currentDataArray = currentGroup.value
                let currentData = currentDataArray[indexPath.row]
              
                dataCell.setupCellForYear(WithData: currentData)
            }
            else
            {
                let currentDataArray = currentGroup.value
                let currentData = currentDataArray[indexPath.row-1]
                
                dataCell.setupCell(WithData: currentData)
            }
        }
        
        return dataCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth/14, height: 50)
    }
}
