//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 03/02/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import Foundation

protocol WeatherDelegate
{
    func reloadWeatherData(success: Bool)
    func showLoadingView()
    func hideLoadingView()
}

extension WeatherDelegate
{
    func reloadWeatherData(success: Bool){ }
    func showLoadingView(){ }
    func hideLoadingView(){ }
}

class WeatherViewModel: NSObject
{
    var weatherDataArray: [WeatherModel]?
    var weatherSortedArray:[(key: Int?, value: [WeatherModel])]?
    
    var delegate : WeatherDelegate?
    
    func getWeatherData(ofLocation locationName: String, weatherMetrics metrics: String )
    {
        delegate?.showLoadingView()
        let urlString = WebServiceUrls().BASE_URL+metrics+"-"+locationName+".json"
        
        WebserviceHandler().get(request: WebserviceHandler().getClientURLRequest(path: urlString)) { (success, object, urlResponse) in
            DispatchQueue.main.async(execute:
                {
                    self.saveWeatherData(response: object, success: success, urlResponse: urlResponse, location: locationName, metric: metrics)
            })
        }
    }
    
    func saveWeatherData(response: Data?,  success: Bool, urlResponse: HTTPURLResponse, location: String, metric: String)
    {
        if success {
            guard let response = response else {return}
            
            let json = try? JSONSerialization.jsonObject(with: response, options: [])
            // print(json!)
            
            self.saveToJsonFile(forLocation: location, weatherMetrics: metric, withJson: json!)
            delegate?.hideLoadingView()
        }
        else
        {
            print("Http Status code: ", urlResponse.statusCode)
        }
        
    }
    
    func saveToJsonFile(forLocation location:String, weatherMetrics metrics: String, withJson responseJson: Any)
    {
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = location+"-"+metrics
        
        let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName+".json")
        
        // Transform array into data and save it into file
        do
        {
            let data = try JSONSerialization.data(withJSONObject: responseJson, options: [])
            try data.write(to: fileUrl, options: [])
            
            retrieveDataFromJsonFile(withFileName: fileName)
        }
        catch
        {
            print(error)
        }
    }
    
    func checkFileAvailablityInDirectory(forLocation location:String, weatherMetrics metrics: String)
    {
        //Check if file exists
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        let fileName = location+"-"+metrics
        
        if let pathComponent = url.appendingPathComponent(fileName+".json")
        {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath)
            {
                //File Available
                retrieveDataFromJsonFile(withFileName: fileName)
            }
            else
            {
                //File Unavailable
                getWeatherData(ofLocation: location, weatherMetrics: metrics)
            }
        }
        else
        {
            //File Unavailable
            getWeatherData(ofLocation: location, weatherMetrics: metrics)
        }
    }
    
    func retrieveDataFromJsonFile(withFileName fileName:String)
    {
        // Get the url of Persons.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else
        { return }
        
        let fileUrl = documentsDirectoryUrl.appendingPathComponent(fileName+".json")
        
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let weatherData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else
            {
                print ("fail")
                return
            }
            
            let jsonData = try? JSONSerialization.data(withJSONObject:weatherData)
            
            self.weatherDataArray = try JSONDecoder().decode([WeatherModel].self, from: jsonData!)
            
            self.setWeatherGroupData()
        }
        catch
        {
            print(error)
        }
    }
    
    func setWeatherGroupData()
    {
        guard let weatherData = weatherDataArray else { return }
        
        //Group Data
        var groupedDictionary = Dictionary(grouping: weatherData, by: { $0.year })
        let sortedArray = groupedDictionary.sorted(by: { $0.key as Int! < $1.key as Int!})
        
        self.weatherSortedArray = sortedArray
        
        delegate?.reloadWeatherData(success: true)
    }
    
    
    
}
