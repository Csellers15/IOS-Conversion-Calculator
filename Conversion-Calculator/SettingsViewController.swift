//
//  SettingsViewController.swift
//  Conversion-Calculator
//
//  Created by Cole Sellers on 9/24/19.
//  Copyright © 2019 Cole Sellers. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
}


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    var mode : CalculatorMode?
    var delegate: SettingsViewControllerDelegate?
    
    var pickerData: [String] = [String]()
    var toFromChoice : String?
    var choice: String?
    
    var fromLength: LengthUnit?
    var toLength: LengthUnit?
    
    var fromVol: VolumeUnit?
    var toVol: VolumeUnit?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unitPicker.delegate = self
        self.unitPicker.isHidden = true
        
        if(mode == .Length){
            LengthUnit.allCases.forEach{
                pickerData.append($0.rawValue)
            }
            self.fromLabel.text? = self.fromLength!.rawValue
            self.toLabel.text? = self.toLength!.rawValue
            
        } else {
            VolumeUnit.allCases.forEach{
                pickerData.append($0.rawValue)
            }
           self.fromLabel.text? = self.fromVol!.rawValue
           self.toLabel.text? = self.toVol!.rawValue
        }
            
        self.unitPicker.dataSource = self
         
        self.fromLabel.isUserInteractionEnabled = true
        self.toLabel.isUserInteractionEnabled = true
         
        let fromTap = UITapGestureRecognizer(target: self, action: #selector(fromPicker))
        let toTap = UITapGestureRecognizer(target: self, action: #selector(toPicker))
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(dismissPicker))
        view.addGestureRecognizer(tap)
        fromLabel.addGestureRecognizer(fromTap)
        toLabel.addGestureRecognizer(toTap)
    }
    
    @objc func dismissPicker() {
        self.unitPicker.isHidden = true
        if (self.toFromChoice == "to"){
            self.toLabel.text = self.choice
        }else {
            self.fromLabel.text = self.choice
        }
        
        self.toFromChoice = ""
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
    }
    
    @objc private func fromPicker(){
        self.unitPicker.isHidden = false
        becomeFirstResponder()
        self.toFromChoice = "from"
    }
    
    @objc private func toPicker(){
        self.unitPicker.isHidden = false
        becomeFirstResponder()
        self.toFromChoice = "to"
    }
    
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.choice = self.pickerData[row]
    }
}