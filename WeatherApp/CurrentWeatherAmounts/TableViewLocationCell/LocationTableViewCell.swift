//
//  LocationTableViewCell.swift
//  WeatherApp
//
//  Created by Timan on 4/28/19.
//  Copyright © 2019 Timan. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var content: LocationTableViewCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
    func setUpCell(_ city : City){
        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        self.temperatureLabel.text = (city.value(forKey: Words.temperature) as! String)
        self.weatherIconImageView.image = (UIImage(named: (city.value(forKey: Words.icon) as! String))!)
        self.weatherDescriptionLabel.text = (city.value(forKey: Words.descriptionToday) as! String)
        content.bounds = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
