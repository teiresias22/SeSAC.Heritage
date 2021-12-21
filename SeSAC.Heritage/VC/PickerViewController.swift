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
    
    var stockCode: Int?
    var cityCode: String?
    var filterTag: String?
    
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
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let pickerType = filterTag {
            if pickerType == "heritage" { 
                return stockCodeInformation.stockCode.count
            } else {
                return cityInformation.city.count
            }
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let pickerType = filterTag {
            if pickerType == "heritage" {
                return "\(stockCodeInformation.stockCode[row].text)"
            } else {
                return "\(cityInformation.city[row].city)"
            }
        } else {
            return "이 메세지를 봤다면 개발자에게 알려주세요!"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerType = filterTag {
            let vc = self.parent as? MapViewController
            if pickerType == "heritage" {
                stockCode = stockCodeInformation.stockCode[row].code
                vc?.code = stockCode
            } else {
                cityCode = cityInformation.city[row].code
                vc?.city = cityCode
            }
        }
    }
    
}
