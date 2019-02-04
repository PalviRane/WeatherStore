//
//  WebserviceHandler.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 02/02/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import Foundation

class WebserviceHandler
{
    // MARK: GET
    func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?, _ urlResponse: HTTPURLResponse) -> ())
    {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    // MARK: FILTER GET REQ
    func filterGet(path: String, params: [String:String]) -> NSMutableURLRequest{
        
        let urlComp = NSURLComponents(string: path)!
        
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        //else {return}
        let request = NSMutableURLRequest(url: urlComp.url!)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        request.addValue("bearer "+"", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    // MARK: Create GET Request
    func getClientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest
    {
        var paramString = ""
        if let params = params {
            
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
        }
        
        let url = URL.init(string: path+"?"+paramString)! //else {return}
        
        let request = NSMutableURLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        return request
    }
    
    
    func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (Bool, Data, HTTPURLResponse) -> ()) {
        request.httpMethod = method
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 60
        urlconfig.timeoutIntervalForResource = 60
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            //            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            //            print(json)
            if let data = data
            {
                // let json = try? JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode
                {
                    completion( true, data, response)
                }
                else if let response = response as? HTTPURLResponse, 401 ~= response.statusCode
                {
                    completion(false, data, response)
                    
                }
                else if let response = response as? HTTPURLResponse, 400...499 ~= response.statusCode {
                    //self.mapToErrorModel(response: data)
                    completion( false, data, response)
                }else // 500 errors
                {
                    DispatchQueue.main.async(execute:
                        {
                            print("Something Went Wrong")
                    })
                    
                    completion(false, data, response as! HTTPURLResponse)
                }
            }else{
                
                DispatchQueue.main.async(execute:
                    {
                        print("Something Went Wrong")
                })
                
            }
            }.resume()
    }
}




