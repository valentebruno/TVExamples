//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by Bruno Bilescky on 28/09/15.
//  Copyright © 2015 bgondim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var images = ["arms-final","back-to-the-start","dribbble","ferocia","finances","mailru_berlin_il_01","photokeeper"]
    
    @IBOutlet weak var collectionView :UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let imageName = images[indexPath.row]
        cell.imageView.image = nil
        if let image = UIImage(named: imageName) {
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("We did hit indexPath: \(indexPath)")
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            context.previouslyFocusedView?.transform = CGAffineTransformIdentity
            context.previouslyFocusedView?.layer.shadowColor = UIColor.clearColor().CGColor
            context.nextFocusedView?.transform = CGAffineTransformMakeScale(1.15, 1.15)
            context.nextFocusedView?.layer.shadowColor = UIColor.blackColor().CGColor
            context.nextFocusedView?.layer.shadowRadius = 8.0
            context.nextFocusedView?.layer.shadowOffset = CGSizeMake(0,2)
            context.nextFocusedView?.layer.shadowOpacity = 1.0
            }, completion: nil)
    }
    
}

