//
//  AdvTableViewController.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 20/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import UIKit

class AdvTableViewController: UITableViewController
{
    var adventureLst:[Adventure]?
    
    var myCategory:Category?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadData()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        loadData()
    }
    
    func loadData()
    {
        if myCategory != nil
        {
            self.adventureLst = AdventureDB.dbInstance.getAdventuresByCategory(category: myCategory!)
            self.navigationItem.title = myCategory?.getDescription()
        }else
        {
            self.navigationItem.title = "All Adventures"
            self.adventureLst = AdventureDB.dbInstance.getAdventuresList();
        }
        tableView.reloadData();
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let listCount:Int = self.adventureLst!.count;
        return listCount;
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Configure the cell...
        let adventure = self.adventureLst![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adventureViewCell", for: indexPath) as! AdvTableViewCell
        
        cell.selectionStyle = .none;
        //==========
        cell.adventureTitle.text  = adventure.title
            + "\n" + adventure.address
            + "\n" + "\(String(adventure.distance))( km away)"; 
        //==========
        //cell.adventureImage.image = adventure.itemImages[0]
        cell.adventureImage.image = FileManageHelper.instance.getImage(argFilename: adventure.imageNames[0])
        
        //==========
        cell.btnFavorite.tag = indexPath.row;
        if (adventure.favourite == false)
        {
            cell.btnFavorite.setImage(UIImage(named: "favorite-small-blank"), for: UIControlState.normal)
        }else
        {
            cell.btnFavorite.setImage(UIImage(named: "favorite-small-fill"), for: UIControlState.normal)
        }
        //=========
        switch adventure.rate
        {
        case 0:
            cell.star1.image = UIImage(named: "star-small-blank")
            cell.star2.image = UIImage(named: "star-small-blank")
            cell.star3.image = UIImage(named: "star-small-blank")
            cell.star4.image = UIImage(named: "star-small-blank")
            cell.star5.image = UIImage(named: "star-small-blank")
        case 1:
            cell.star1.image = UIImage(named: "star-small-fill")
            cell.star2.image = UIImage(named: "star-small-blank")
            cell.star3.image = UIImage(named: "star-small-blank")
            cell.star4.image = UIImage(named: "star-small-blank")
            cell.star5.image = UIImage(named: "star-small-blank")
        case 2:
            cell.star1.image = UIImage(named: "star-small-fill")
            cell.star2.image = UIImage(named: "star-small-fill")
            cell.star3.image = UIImage(named: "star-small-blank")
            cell.star4.image = UIImage(named: "star-small-blank")
            cell.star5.image = UIImage(named: "star-small-blank")
        case 3:
            cell.star1.image = UIImage(named: "star-small-fill")
            cell.star2.image = UIImage(named: "star-small-fill")
            cell.star3.image = UIImage(named: "star-small-fill")
            cell.star4.image = UIImage(named: "star-small-blank")
            cell.star5.image = UIImage(named: "star-small-blank")
        case 4:
            cell.star1.image = UIImage(named: "star-small-fill")
            cell.star2.image = UIImage(named: "star-small-fill")
            cell.star3.image = UIImage(named: "star-small-fill")
            cell.star4.image = UIImage(named: "star-small-fill")
            cell.star5.image = UIImage(named: "star-small-blank")
        case 5:
            cell.star1.image = UIImage(named: "star-small-fill")
            cell.star2.image = UIImage(named: "star-small-fill")
            cell.star3.image = UIImage(named: "star-small-fill")
            cell.star4.image = UIImage(named: "star-small-fill")
            cell.star5.image = UIImage(named: "star-small-fill")
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200;
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton)
    {
        let itemId = self.adventureLst![sender.tag].itemId
        let temp_adventure = AdventureDB.dbInstance.getAdventure(advId: itemId)
        
        if (temp_adventure.favourite == true)
        {
            temp_adventure.favourite = false
        }else
        {
            temp_adventure.favourite = true
        }
        
        if AdventureDB.dbInstance.updateAdventure(adv: temp_adventure) == true
        {
            loadData()
        }
        self.tableView.reloadData();
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier
        {
            switch identifier
            {
                case "showDetail","showDetailFromCategory":
                    let adventureDVC = segue.destination as! AdvDetailViewController
                    if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
                    {
                        adventureDVC.adventure = self.adventureLst?[indexPath.row]
                    }
                default:
                    break
            }
            
        }
        
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem)
    {
        
    }
    

}
