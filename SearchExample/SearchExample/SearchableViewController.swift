//
//  SearchableViewController.swift
//  SearchExample
//
//  Created by Bruno Bilescky on 29/09/15.
//  Copyright © 2015 bgondim. All rights reserved.
//

import UIKit

let cities = ["São Paulo","Osasco","Guarulhos","Carapicuiba","Barueri","São Josê dos Campos","Itapevi","Santos","Diadema","Franco da Rocha","Rio de Janeiro","Belo Horizonte","Curitiba","Florianópolis","Guaxupé","Sorocaba","Campinas"]

class SearchableViewController: UIViewController, UISearchResultsUpdating, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView :UICollectionView!
    
    lazy var acceptedCharacters :NSMutableCharacterSet = {
        let accepted = NSMutableCharacterSet()
        accepted.formUnionWithCharacterSet(NSCharacterSet.letterCharacterSet())
        accepted.formUnionWithCharacterSet(NSCharacterSet.decimalDigitCharacterSet())
        accepted.addCharactersInString(" _-.!")
        return accepted
    }()
    
    lazy var searchableCities :[String] = {
        return cities.map {
            let sanitizedData = $0.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion:true)!
            let sanitizedString = String(data: sanitizedData, encoding: NSASCIIStringEncoding)!
            return sanitizedString.componentsSeparatedByCharactersInSet(self.acceptedCharacters.invertedSet).joinWithSeparator("").uppercaseString
        }
    }()
    
    var filteredCities : [String] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var filterString = "" {
        didSet {
            if filterString.characters.count == 0 {
                filteredCities = cities
            }
            else {
                filterCities()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredCities = cities
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    private func filterCities() {
        let filteredIndexes = searchableCities.filter { $0.hasPrefix(filterString) }.map { searchableCities.indexOf($0)! }
        filteredCities = filteredIndexes.map { return cities[$0] }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("placeCell", forIndexPath: indexPath) as! PlaceCollectionViewCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("placeCellPretty", forIndexPath: indexPath) as! PlaceCollectionViewCell
        cell.textLabel.text = filteredCities[indexPath.item]
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let term = searchController.searchBar.text ?? ""
        filterString = term.uppercaseString
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if let previousView = context.previouslyFocusedView as? PlaceCollectionViewCell {
                previousView.transform = CGAffineTransformIdentity
                previousView.layer.shadowColor = UIColor.clearColor().CGColor
                previousView.backgroundColor = UIColor.whiteColor()
                previousView.textLabel.textColor = UIColor.blackColor()
            }
            if let nextView = context.nextFocusedView as? PlaceCollectionViewCell {
                nextView.transform = CGAffineTransformMakeScale(1.05, 1.05)
                nextView.backgroundColor = UIColor.darkGrayColor()
                nextView.textLabel.textColor = UIColor.whiteColor()
            }
        }, completion: nil)
    }
    
}
