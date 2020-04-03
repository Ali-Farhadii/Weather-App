//
//  ViewController.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/5/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Property
    var cityName = "Tehran"
    var modelObject = WeatherManager()
    
    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        modelObject.delegate = self
        
        navigationController?.navigationBar.barTintColor = .systemBackground
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .label
        navigationItem.backBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Call this method for hit endpoint to get data
        modelObject.makeRequest(with: cityName)
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {}
    
    // Initialize elements of view before change with new data from API
    func setUpUI() {
        
        let cityTextAttribute = NSMutableAttributedString(string: "City Name", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-DemiBold", size: 25)!])
        cityTextAttribute.append(NSAttributedString(string: "\nDescription", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!,NSAttributedString.Key.foregroundColor : UIColor.gray]))
        cityNameLabel.attributedText = cityTextAttribute
        
        let tempTextAttribute = NSMutableAttributedString(string: "Current Temperature\n\nMin-Temp / Max-Temp", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-DemiBold", size: 20)!])
        tempsLabel.attributedText = tempTextAttribute
    }
}

//MARK: - Delegate methods for update UI with data or error
extension ViewController: WeatherManagerProtocol {
    
    func updateUI(with weatherModel: WeatherData) {
        let imageName = weatherModel.getImageName(with: weatherModel.id[0] ?? 0)
        
        DispatchQueue.main.async {
            
            let cityTextAttribute = NSMutableAttributedString(string: "\(self.cityName)", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-DemiBold", size: 25)!])
            cityTextAttribute.append(NSAttributedString(string: "\n\(weatherModel.description[0])", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!,NSAttributedString.Key.foregroundColor : UIColor.gray]))
            self.cityNameLabel.attributedText = cityTextAttribute
            
            let tempTextAttribute = NSMutableAttributedString(string: "\(weatherModel.temp)°\n\n\(weatherModel.minTemp)°   /   \(weatherModel.maxTemp)°", attributes: [NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-DemiBold", size: 20)!])
            self.tempsLabel.attributedText = tempTextAttribute
            
            self.weatherImage.image = UIImage(systemName: imageName)
        }
    }
    
    func failWithError(_ error: ErrorType) {
        
        DispatchQueue.main.async {
            var title = ""
            var message = ""
            
            switch error {
            case .url:
                title = "Error"
                message = "There is something wrong with city name that you select, Please try again."
            case .network:
                title = "Network Error"
                message = "Please check your internet coneccion and try again."
            case .parse:
                title = "Erro"
                message = "There is something wrong in take data from server, Please try again"
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
