//
//  SearchVC.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/5/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var tableView:UITableView!
    var searchController: UISearchController!
    
    //MARK: - Property
    var cityModel = CityModel()
    var cities = [CityModel]()
    var filteredCities = [String]()
    var sectionOfSelectedCell = 0
    var rowOfSelectedCell = 0
    var selectFromSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        
        cities = cityModel.getData()
    }
    
    func filterContent(with searchText:String) {
        
        if !isFiltering() || isSearchBarEmpty() {
            filteredCities.removeAll()
            tableView.reloadData()
        }
        
        for country in cities {
            for city in country.cityName {
                if city.lowercased().contains(searchText.lowercased()) {
                    filteredCities.append(city)
                }
            }
        }
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
}

extension SearchVC: UITableViewDelegate , UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() { return 1 }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() { return filteredCities.count }
        return cities[section].cityName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! SearchCell
        
        if isFiltering() {
            cell.cityNameLabel.text = filteredCities[indexPath.row]
            selectFromSearch = true
            rowOfSelectedCell = indexPath.row
        }
        else {
            cell.cityNameLabel.text = cities[indexPath.section].cityName[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering() { return nil }
        return cities[section].countryName
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sectionOfSelectedCell = indexPath.section
        rowOfSelectedCell = indexPath.row
        performSegue(withIdentifier: "backToFavorite", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "backToFavorite" else {
            return
        }
        
        if selectFromSearch {
            FavoritVC.cities.append(filteredCities[rowOfSelectedCell])
        }
        else {
            FavoritVC.cities.append(cities[sectionOfSelectedCell].cityName[rowOfSelectedCell])
        }
        
    }
}

extension SearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContent(with: searchBar.text!)
    }

}

extension SearchVC: UISearchBarDelegate {
    
    
}
