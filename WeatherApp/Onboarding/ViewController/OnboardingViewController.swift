//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 28/01/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController
{
    //UI Elements
    
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.initialCollectionCellSetup()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        imagesPageControl.currentPage = 0
    }
    
    func initialCollectionCellSetup()
    {
        self.onboardCollectionView.register(UINib.init(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
    }
    
}

extension OnboardingViewController: OnboardingRedirectionDelegate
{
    func redirectToHome()
    {
        SharedPref.shared.setOnboardingStatus(status: true)
        
        let weatherViewController = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        
        let navigationController = UINavigationController(rootViewController: weatherViewController!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationController
    }
}
