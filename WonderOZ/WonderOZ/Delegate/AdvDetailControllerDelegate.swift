//
//  AdvDetailControllerDelegate.swift
//  WonderOZ
//
//  Created by Zhangzixi on 2018/2/3.
//  Copyright © 2018年 iOSWorld. All rights reserved.
//

import Foundation
import UIKit


extension AdvDetailViewController : UITableViewDelegate
{
    
}

extension AdvDetailViewController : UITableViewDataSource
{
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let count:Int = (self.adventure?.comments.count)!;
        return count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let comment = self.adventure?.comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentViewCell", for: indexPath) as! ComntTableViewCell
        cell.commentTextView.text = comment?.commentContext;
        cell.btnDelete.tag = (comment?.commentId)!
        return cell;
    }
    
}
