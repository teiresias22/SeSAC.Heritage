//
//  HeritageListAPIManager.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class HeritageListAPIManager {
    
    static let shared = HeritageListAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(page: Int, result: @escaping CompletionHandler) {
        
        let url = Endpoint.Heritage_List
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                result(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

