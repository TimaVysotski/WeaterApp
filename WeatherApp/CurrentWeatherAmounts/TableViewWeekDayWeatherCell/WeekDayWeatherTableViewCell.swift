//
//  WeekDayWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Timan on 4/28/19.
//  Copyright © 2019 Timan. All rights reserved.
//

import UIKit

class WeekDayWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var firstDayLabel: UILabel!
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var thirdDayLabel: UILabel!
    @IBOutlet weak var fourthDayLabel: UILabel!
    @IBOutlet weak var fifthDayLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var fifthImageView: UIImageView!
    @IBOutlet weak var firstTemperatureLabel: UILabel!
    @IBOutlet weak var secondTemperatureLabel: UILabel!
    @IBOutlet weak var thirdTemperatureLabel: UILabel!
    @IBOutlet weak var fourthTemperatureLabel: UILabel!
    @IBOutlet weak var fifthTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(_ city : City){
        self.firstDayLabel.text = (city.value(forKey: Words.firstDayName) as! String)
        self.firstTemperatureLabel.text = (city.value(forKey: Words.firstDayTemperature) as! String)
        self.firstImageView.image = (UIImage(named: (city.value(forKey: Words.firstDayIcon) as! String))!)
        self.secondDayLabel.text = (city.value(forKey: Words.secondDayName) as! String)
        self.secondTemperatureLabel.text = (city.value(forKey: Words.secondDayTemperature) as! String)
        self.secondImageView.image = (UIImage(named: (city.value(forKey: Words.secondDayIcon) as! String))!)
        self.thirdDayLabel.text = (city.value(forKey: Words.thirdDayName) as! String)
        self.thirdTemperatureLabel.text = (city.value(forKey: Words.thirdDayTemperature) as! String)
        self.thirdImageView.image = (UIImage(named: (city.value(forKey: Words.thirdDayIcon) as! String))!)
        self.fourthDayLabel.text = (city.value(forKey: Words.fourthDayName) as! String)
        self.fourthTemperatureLabel.text = (city.value(forKey: Words.fourthDayTemperature) as! String)
        self.fourthImageView.image = (UIImage(named: (city.value(forKey: Words.fourthDayIcon) as! String))!)
        self.fifthDayLabel.text = (city.value(forKey: Words.fifthDayName) as! String)
        self.fifthTemperatureLabel.text = (city.value(forKey: Words.fifthDayTemperature) as! String)
        self.fifthImageView.image = (UIImage(named: (city.value(forKey: Words.fifthDayIcon) as! String))!)
    }
}
