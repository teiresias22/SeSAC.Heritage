//
//  PickerViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/19.
//

import UIKit

class PickerViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    
    var stockCode = 11
    var cityCode = "11"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        createPickerView()
    }
    
    func createPickerView(){
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        case 0: stockCode = stockCodeInformation.stockCode[row].code
        case 1: cityCode = cityInformation.city[row].code
        default: break
        }
        
        if let MapViewController = self.parent as? MapViewController {
            MapViewController.code = stockCode
            MapViewController.city = cityCode
        }
    }
    
}
