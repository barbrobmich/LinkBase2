//
//  MonthYearPickerView.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

//protocol DatePickerDelegate {
//    
//    func dateChanged(month: Int, year: Int)
//}

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    var months: [String]!
    var years: [Int]!

    var month: Int = 0 {
        didSet{
            selectRow(month-1, inComponent: 0, animated: false)
        }
    }

    var year: Int = 0{
        didSet{
            selectRow(years.index(of: year)!, inComponent: 1, animated: true)
        }
    }

    var onDateSelected: ((_ month: Int, _ year: Int)->Void)?

    override init(frame: CGRect) {
        super.init(frame:frame)
        self.commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }

    func commonSetup() {
        var years: [Int] = []
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        for _ in 1...15 {
            years.append(year)
            year -= 1
        }
        }
        self.years = years


    var months: [String] = []
    var month = 0
    for _ in 1...12 {
        months.append(DateFormatter().monthSymbols[month].capitalized)
        month += 1
    }

    self.months = months

    self.delegate = self
    self.dataSource = self
        
        

        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        self.selectRow(currentMonth - 1, inComponent: 0, animated: false)

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }

//NSFontAttributeName: UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "SanFranciscoText-Light", size: 12)
        
        // where data is an Array of String
        switch component {
        case 0:
            label.text = months[row]
        case 1:
            label.text = "\(years[row])"
        default:
            break
        }
        
        return label
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
            
        case 0:
            return NSAttributedString(string: months[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        case 1:
            return NSAttributedString(string: "\(years[row])", attributes: [NSForegroundColorAttributeName : UIColor.white])
            
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = self.selectedRow(inComponent: 0)+1
        let year = years[self.selectedRow(inComponent: 1)]
        if let block = onDateSelected {
            block(month,year)
        }

        print("picked \(month) / \(year)")
        self.month = month
        self.year = year
    }


}
