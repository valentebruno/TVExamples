//
//  ViewController.swift
//  LuckMachine
//
//  Created by Bruno Bilescky on 29/09/15.
//  Copyright © 2015 bgondim. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let removeSelectedPerson = true
    
    @IBOutlet weak var selectedPerson :UILabel!
    
    lazy var jsonList :[String] = {
        if let jsonPath = NSBundle.mainBundle().pathForResource("people", ofType: "json"), let data = NSData(contentsOfFile: jsonPath) {
            return try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String]
        }
        return []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selectRandomPerson() {
        print("We have: \(jsonList.count) people in the list")
        let randomNumber = Int(arc4random_uniform(UInt32(jsonList.count)))
        let selectedPersonName = jsonList[randomNumber]
        selectedPerson.text = selectedPersonName
        if removeSelectedPerson {
            jsonList.removeAtIndex(randomNumber)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

