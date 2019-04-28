//
//  MainTableViewCell.swift
//  WeatherApp
//
//  Created by Timan on 4/28/19.
//  Copyright © 2019 Timan. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(_ city : City){
        
        self.temperatureLabel.text = (city.value(forKey: Words.temperature) as! String)
    }
    
}
