//
//  WindTableViewCell.swift
//  WeatherApp
//
//  Created by Timan on 4/28/19.
//  Copyright © 2019 Timan. All rights reserved.
//

import UIKit

class WindTableViewCell: UITableViewCell {
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(_ city : City){
        self.windDirectionLabel.text = (city.value(forKey: Words.windDirection) as! String)
        self.windSpeedLabel.text = (city.value(forKey: Words.windSpeed) as! String)
    }
    
}
