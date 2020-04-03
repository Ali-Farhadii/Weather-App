//
//  FavoritCell.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/6/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import UIKit

class FavoritCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var tempLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateUI(with cityName:String) {
        
        //TODO: update temp of city
        cityNameLabel.text = cityName
    }
}
