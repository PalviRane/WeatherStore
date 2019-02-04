//
//  SharedPref.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 04/02/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

struct SharedPrefKeys
{
    static let is_onboard_complete = "isOnboard"
}

class SharedPref: NSObject
{
    static let shared: SharedPref =
    {
        let sharedPre = SharedPref()
        return sharedPre
    }()
    
    func setOnboardingStatus(status: Bool)
    {
        UserDefaults.standard.set(status, forKey: SharedPrefKeys.is_onboard_complete)
        UserDefaults.standard.synchronize()
    }
    
    func getOnboardingStatus() -> Bool {
        
        return UserDefaults.standard.bool(forKey: SharedPrefKeys.is_onboard_complete)
    }
}
