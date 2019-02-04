//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 31/01/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController
{
    //UI Elements
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var metricesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    @IBOutlet weak var navigationTitleButton: UIButton!
    
    //Constraints
    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint! //100
    
    //View Model
     let weatherVM: WeatherViewModel = WeatherViewModel()
    
    //Data
    
    var locationName : String?
    var weatherMetric: String?
    var locationData: [String] = [String]()
    var monthData: [String] = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        initialViewSetup()
        initialCollectionCellSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController!.isNavigationBarHidden = false
        
        self.getWeatherData()
    }
    
    func initialCollectionCellSetup()
    {
        self.weatherCollectionView.register(UINib.init(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
    }
    
    //Intial Setup
    
    func initialViewSetup()
    {
        weatherVM.delegate = self
        
        locationData = ["UK", "England", "Scotland", "Wales"]
        monthData = ["", "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        metricesSegmentedControl.selectedSegmentIndex = 0
        self.weatherMetric = "Tmax"
        
        self.locationName = locationData.first


    }
    
    func hideShowPicker()
    {
        UIView.animate(withDuration: 0.3)
        {
            if self.pickerHeightConstraint.constant == 0
            {
                self.pickerHeightConstraint.constant = 100
                self.navigationTitleButton.setImage(#imageLiteral(resourceName: "UpArrow"), for: .normal)
            }
            else
            {
                self.pickerHeightConstraint.constant = 0
                self.navigationTitleButton.setImage(#imageLiteral(resourceName: "Down Arrow"), for: .normal)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    //Webservice Call
    
    func getWeatherData()
    {
        guard let location = self.locationName else
        {
            return
        }
        
        guard let metric = self.weatherMetric else
        {
            return
        }
        weatherVM.checkFileAvailablityInDirectory(forLocation: location, weatherMetrics: metric)
    }
    
    //Segment Controller
    
    @IBAction func setSelectedSegment(_ sender: UISegmentedControl)
    {
        if metricesSegmentedControl.selectedSegmentIndex == 0
        {
            self.weatherMetric = "Tmax"
        }
        else if metricesSegmentedControl.selectedSegmentIndex == 1
        {
            self.weatherMetric = "Tmin"
        }
        else
        {
            self.weatherMetric = "Rainfall"
        }
        
        self.getWeatherData()
    }
    
    //Button Action
    
    @IBAction func citySelectButtonAction(_ sender: UIButton)
    {
        self.hideShowPicker()
    }
}

extension WeatherViewController: WeatherDelegate
{
    func reloadWeatherData(success: Bool)
    {
        if success
        {
            weatherCollectionView.reloadData()
        }
    }
    
    func showLoadingView()
    {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoadingView()
    {
        dismiss(animated: false, completion: nil)
    }
}
