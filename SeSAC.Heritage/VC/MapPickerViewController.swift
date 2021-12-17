//
//  MapPickerViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/18.
//

import UIKit

class MapPickerViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewSubmit: UIButton!
    
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickerViewSubmitButtonClicked(_ sender: UIButton) {
        pickerView.resignFirstResponder()
        
        
    }
    
    
}

extension MapPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return stockCodeInformation.stockCode.count
        case 1: return cityInformation.city.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(stockCodeInformation.stockCode[row].text)"
        case 1: return "\(cityInformation.city[row].city)"
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:  stockCodeInformation.stockCode[row].code
        case 1:  cityInformation.city[row].code
        default: break
        }
    }
}
