//
//  FistViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/29.
//

import UIKit
import RealmSwift
import Kingfisher

class FistViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    var elementName = ""
    var items: Array = [[String: String]]()
    var key: String!
    var ct: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "JHeritage".localized()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "MapoFlowerIsland", size: 40)!
        titleLabel.textColor = .customYellow
        
        noticeLabel.text = "앱을 설정중에 있습니다.\n앱을 종료하지 마시고 잠시만 기다려주세요.".localized()
        noticeLabel.numberOfLines = 0
        noticeLabel.font = UIFont().MapoFlowerIsland16
        noticeLabel.textColor = .customRed
        
        //print("Realm is located at:", localRealm.configuration.fileURL!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let heritage = localRealm.objects(Heritage_List.self).count
        if heritage == 0 {
            fetcHeritageData()
            presentNextPage()
            //totalCnt와 맞지 않으면 행동이 필요함.
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.presentNextPage()
        }
    }
    
    func presentNextPage() {
        let sb = UIStoryboard(name: "List", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        self.present(nav, animated: true, completion: nil)
    }
    
    func fetcHeritageData() {
        let path = (Bundle.main.url(forResource: "HeritageList", withExtension: "xml"))!
        let parser = XMLParser(contentsOf: path)
        parser?.delegate = self
        parser?.parse()
    }
}

extension FistViewController: XMLParserDelegate {
    
    //XMLParser가 시작 태그를 만나면 호출됨
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "sn" || elementName == "no" || elementName == "ccmaName" || elementName == "crltsnoNm" || elementName == "ccbaMnm1" || elementName == "ccbaMnm2" || elementName == "ccbaCtcdNm" || elementName == "ccsiName" || elementName == "ccbaAdmin" || elementName == "ccbaKdcd"  || elementName == "ccbaCtcd"  || elementName == "ccbaAsno"  || elementName == "ccbaCncl"  || elementName == "ccbaCpno"  || elementName == "longitude"  || elementName == "latitude" {
            self.key = elementName
        }
    }
    
    // 태그의 Data가 String으로 들어옴
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.key != nil {
            if self.key == "sn" {
                self.items.append([key: string])
            } else {
                self.items[ct][key] = string
            }
        }
        if key == "latitude" {
            ct = ct + 1
        }
    }
    
    //XMLParser가 종료 태그를 만나면 호출됨
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.key = nil
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print(validationError)
    }
    
    //XMLParser가 종료되면 호출됨
    func parserDidEndDocument(_ parser: XMLParser) {
        saveRealm()
    }
    
    //items의 값을 Realm에 저장함
    func saveRealm() {
        var sn: String = ""//순번
        var no: String = "" //고유 키값
        var ccmaName: String = "" //문화재종목
        var crltsnoNm: String = "" //지정호수
        var ccbaMnm1: String = "" //문화재명(국문)
        var ccbaMnm2: String = "" //문화재명(영문)
        var ccbaCtcdNm: String = "" //시도명
        var ccsiName: String = "" //시군구명
        var ccbaAdmin : String = "" //관리자
        var ccbaKdcd: String = "" //종목코드(필수)
        var ccbaCtcd: String = "" //시도코드(필수)
        var ccbaAsno: String = "" //지정번호(필수)
        var ccbaCncl: String = "" //지정해제여부
        var ccbaCpno: String = "" //문화재연계번호
        var longitude: String = "" //경도
        var latitude: String = "" //위도
        
        for i in 0..<items.count {
            for (key, value) in items[i] {
                if key == "sn" {
                    sn = value
                } else if key == "no" {
                    no = value
                } else if key == "ccmaName" {
                    ccmaName = value
                } else if key == "crltsnoNm" {
                    crltsnoNm = value
                } else if key == "ccbaMnm1" {
                    ccbaMnm1 = value
                } else if key == "ccbaMnm2" {
                    ccbaMnm2 = value
                } else if key == "ccbaCtcdNm" {
                    ccbaCtcdNm = value
                } else if key == "ccsiName" {
                    ccsiName = value
                } else if key == "ccbaAdmin" {
                    ccbaAdmin = value
                } else if key == "ccbaKdcd" {
                    ccbaKdcd = value
                } else if key == "ccbaCtcd" {
                    ccbaCtcd = value
                } else if key == "ccbaAsno" {
                    ccbaAsno = value
                } else if key == "ccbaCncl" {
                    ccbaCncl = value
                } else if key == "ccbaCpno" {
                    ccbaCpno = value
                } else if key == "longitude" {
                    longitude = value
                } else if key == "latitude" {
                    latitude = value
                }
            }
            let heritage = Heritage_List(sn: sn, no: no, ccmaName: ccmaName, crltsnoNm: crltsnoNm, ccbaMnm1: ccbaMnm1, ccbaMnm2: ccbaMnm2, ccbaCtcdNm: ccbaCtcdNm, ccsiName: ccsiName, ccbaAdmin: ccbaAdmin, ccbaKdcd: ccbaKdcd, ccbaCtcd: ccbaCtcd, ccbaAsno: ccbaAsno, ccbaCncl: ccbaCncl, ccbaCpno: ccbaCpno, longitude: longitude, latitude: latitude)
            try! localRealm.write {
                localRealm.add(heritage)
            }
        }
    }
}
