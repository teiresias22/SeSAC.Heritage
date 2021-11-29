import UIKit
import RealmSwift

class ListTableViewController: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    var elementName = "" //현재 Element
    var items: Array = [[String: String]]()
    var key: String!
    var ct: Int = 0
    
    var listInformation: String = ""
    var stockCodeData: StockCode?
    var cityData: City?
    var category: String = ""
    
    var pageCount: Int = 1
    var searchTarget: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = listInformation.localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        
        listTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        listTable.delegate = self
        listTable.dataSource = self
        
        fetcHeritageData()
        
        //print("Realm is located at:", localRealm.configuration.fileURL!)
        // Do any additional setup after loading the view.
    }
    
    func fetcHeritageData() {
        //검색할대상 설정
        if stockCodeData != nil {
            searchTarget = "\(stockCodeData!.category)=\(stockCodeData!.code)"
        }else if cityData != nil {
            searchTarget = "\(cityData!.category)=\(cityData!.code)"
        }else {
            //searchTarget = "\(category)\(category)"
        }
        let pageIndex = "pageIndex=\(pageCount)"
        
        let url = "\(Endpoint.Heritage_List)\(searchTarget)&\(pageIndex)"
        
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stockCodeData != nil {
            return items.count
        }else if cityData != nil {
            return items.count
        }else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let row = items[indexPath.row]
        
        cell.countLabel.text = row["sn"]!.localized()
        cell.countLabel.font = UIFont().MapoFlowerIsland16
        cell.titleLabel.text = row["ccbaMnm1"]!.localized()
        cell.titleLabel.font = UIFont().MapoFlowerIsland16
        
        cell.categoryLabel.text = row["ccmaName"]!.localized()
        cell.categoryLabel.font = UIFont().MapoFlowerIsland14
        cell.categoryLabel.frame.size = cell.categoryLabel.intrinsicContentSize
        cell.cityLabel.text = row["ccbaCtcdNm"]!.localized()
        cell.cityLabel.font = UIFont().MapoFlowerIsland14
        cell.locationLabel.text = row["ccsiName"]!.localized()
        cell.locationLabel.font = UIFont().MapoFlowerIsland14
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        
        let row = items[indexPath.row]
        vc.items = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if items.count == indexPath.row {
                pageCount += 1
                fetcHeritageData()
                listTable.reloadData()
            }
        }
    }
}

extension ListTableViewController: XMLParserDelegate {
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
    
    func parserDidEndDocument(_ parser: XMLParser) {
        saveRealm()
    }
    
    func saveRealm() {
        
        let haritage = items
        
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
