//
//  OnboardingCollectionViewCell.swift
//  WeatherApp
//
//  Created by Aakash Kumbhar on 28/01/19.
//  Copyright © 2019 Palvi Rane. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell
{
    //UI Elements
    
    @IBOutlet weak var onboardImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    //Constraints
    @IBOutlet weak var continueButtonHeightConstraint: NSLayoutConstraint!  //50
    
    //Delegate
    var delegate: OnboardingRedirectionDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupOnboardCollectionCell(forIndexpath indexpath: IndexPath)
    {
        self.onboardImageView.image = UIImage.init(named: String(indexpath.row)+".jpg")
        if indexpath.row == 1
        {
            continueButtonHeightConstraint.constant = 50
            informationLabel.text = "Categorized monthly with various metrices"
        }
        else
        {
            continueButtonHeightConstraint.constant = 0
            informationLabel.text = "Year - by - Year weather updates"
        }
        self.layoutIfNeeded()
    }
    
    @IBAction func continueButtonAction(_ sender: Any)
    {
        delegate?.redirectToHome()
    }
    

}

