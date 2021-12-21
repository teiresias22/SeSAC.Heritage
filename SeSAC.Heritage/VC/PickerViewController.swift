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
    var filterTag: String?
    
    let heritageList = ["국보":11, "보물":12, "사적":13, "명승":15, "천연기념물":16, "국가무형문화재":17, "국가민속문화재":18, "시도유형문화재":21, "시도무형문화재":22, "시도기념물":23, "시도민속문화재":24, "시도등록문화재":25, "문화재자료":31, "국가등록문화재":79, "이북5도 무형문화재":80, "모두":00]
    let cityList = ["서울":11, "부산":21, "대구":22, "인천":23, "광주":24, "대전":25, "울산":26, "세종":45, "경기":31, "강원":32, "충북":33, "충남":34, "전북":35, "전남":36, "경북":37, "경남":38, "제주":50, "전국일원":99, "모두":00]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
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
