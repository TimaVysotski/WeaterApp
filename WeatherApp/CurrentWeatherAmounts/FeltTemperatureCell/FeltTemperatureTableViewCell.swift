//
//  FeltTemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Timan on 4/28/19.
//  Copyright © 2019 Timan. All rights reserved.
//

import UIKit

class FeltTemperatureTableViewCell: UITableViewCell {
    @IBOutlet weak var feltTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(_ city : City){
        self.feltTemperatureLabel.text = (city.value(forKey: Words.feltTemperature) as! String)
    }
    
}
