//
//  ListViewModel.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/09.
//

import UIKit
import Realm
import RealmSwift

class ListViewModel {
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    //ListVC
    var target = "StockCode"
    
    let listInformation = ListInformation()
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    
    //ListTableVC
    var stockCodeData: StockCode?
    var cityData: City?
    var category: String = ""

    //ListDetailVC
    var items = Heritage_List()
    
    //MapViewFilter
    var cityCode: Observable<String> = Observable("11")
    var stockCode: Observable<Int> = Observable(0)
    
    
}
