//
//  FavoriteViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 21/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoriteViewController: UIViewController
{
    var myFavoriteCategory = [CategoryClass]()
    
    @IBOutlet var favour_Collect_View: UICollectionView!
    
    struct StoryBoard
    {
        static let favoriteCell = "favoriteCell"
        static let favoriteHeaderView   = "favoriteHeaderView"
        static let showDetailSegue = "showFavoriteDetial"
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow:CGFloat = 2.0
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.myFavoriteCategory = AdventureDB.dbInstance.getFavouriteCategories();
        
        let myCollectionViewWith = favour_Collect_View?.frame.width;
        let layout = favour_Collect_View.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: myCollectionViewWith!, height: 150)
        
        favour_Collect_View?.reloadData();
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == StoryBoard.showDetailSegue
        {
            let detailViewController = segue.destination as! AdvDetailViewController
            detailViewController.adventure = sender as? Adventure
        }
    }
}
