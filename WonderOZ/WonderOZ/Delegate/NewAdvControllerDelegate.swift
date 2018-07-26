//
//  NewAdvControllerDelegate.swift
//  WonderOZ
//
//  Created by Zhangzixi on 2018/2/3.
//  Copyright © 2018年 iOSWorld. All rights reserved.
//

import Foundation
import UIKit


extension NewAdvViewController : UIPickerViewDelegate
{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.cateText.text = AdventureDB.dbInstance.cate_string[row]
        self.catePickerView.isHidden = true
        Picker_index = row
    }
    
}

extension NewAdvViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return AdventureDB.dbInstance.cate_string.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        self.view.endEditing(true)
        return AdventureDB.dbInstance.cate_string[row]
    }
    
}

extension NewAdvViewController : UITextFieldDelegate
{
    
}

extension NewAdvViewController : UITextViewDelegate
{
    
}
