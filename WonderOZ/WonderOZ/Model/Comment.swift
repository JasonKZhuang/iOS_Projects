//
//  Comment.swift
//  WonderOZ
//
//  Created by Jason-Zhuang on 27/1/18.
//  Copyright © 2018 iOSWorld. All rights reserved.
//

import Foundation

class Comment
{
    var commentId: Int;
    var commentContext: String;
    var adventureId: Int;
    
    init(comId:Int, context: String, advId:Int)
    {
        self.commentId = comId
        self.commentContext = context
        self.adventureId = advId
    }
}
