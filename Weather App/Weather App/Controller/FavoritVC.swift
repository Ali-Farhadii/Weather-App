//
//  FavoritVC.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/5/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import UIKit

class FavoritVC: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    static var cities = ["Tehran"]
    var indexOfSelectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .label
        navigationItem.backBarButtonItem = backButton
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {}
    
}

extension FavoritVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritVC.cities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == FavoritVC.cities.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addLocationCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! FavoritCell
        let cityName = FavoritVC.cities[indexPath.row]
    
        cell.updateUI(with: cityName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == FavoritVC.cities.count { return }
        // Store indexPath of selected row for use it to pass cityName to HomeVC
        indexOfSelectedCell = indexPath.row
        
        performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "backToHome" else {
            return
        }
        
        let homeVC = segue.destination as! ViewController
        
        homeVC.cityName = FavoritVC.cities[indexOfSelectedCell]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete else { return }

        FavoritVC.cities.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    
}
