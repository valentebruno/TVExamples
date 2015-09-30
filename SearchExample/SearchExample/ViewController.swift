//
//  ViewController.swift
//  SearchExample
//
//  Created by Bruno Bilescky on 29/09/15.
//  Copyright © 2015 bgondim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showSearch() {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        guard let resultsController = storyboard.instantiateInitialViewController() as? SearchableViewController else { fatalError("Unable to instantiate a SearchableViewController.") }
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.placeholder = "Digite o nome da cidade"
        self.presentViewController(searchController, animated: true) {
            
        }
    }

}

