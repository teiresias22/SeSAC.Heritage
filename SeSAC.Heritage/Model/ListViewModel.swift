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
    
    var cityCode: Observable<String> = Observable("11")
    var stockCode: Observable<Int> = Observable(11)
    
}
