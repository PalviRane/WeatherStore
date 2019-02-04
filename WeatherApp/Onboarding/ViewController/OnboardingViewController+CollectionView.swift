//
//  OnboardingViewController+CollectionView.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 28/01/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let onboardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        onboardCell.setupOnboardCollectionCell(forIndexpath: indexPath  )
        onboardCell.delegate = self
        
        return onboardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: screenWidth, height: screenHeight+20)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        for cell in onboardCollectionView.visibleCells
        {
            let indexPath = onboardCollectionView.indexPath(for: cell)
            imagesPageControl.currentPage = (indexPath?.row)!
        }
        
    }
    
}
