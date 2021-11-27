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
    var category = ""
    
    var searchTarget = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = listInformation.localized()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        listTable.delegate = self
        listTable.dataSource = self
        
        fetcMediaData()
        // Do any additional setup after loading the view.
    }
    
    func fetcMediaData() {
        //검색할대상 설정
        if stockCodeData != nil {
            searchTarget = "\(stockCodeData!.category)=\(stockCodeData!.code)"
        }else if cityData != nil {
            searchTarget = "\(cityData!.category)=\(cityData!.code)"
        }else {
            searchTarget = "\(category)\(category)"
        }
        let url = "\(Endpoint.Heritage_List)\(searchTarget)"
        
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        cell.listTableImage.backgroundColor = .customBlack
        cell.listTableTilte.text = "제목이 들어갈곳 입니다".localized()
        cell.listTableText1.text = "첫번째 내용이 들어갈 곳".localized()
        cell.listTableText2.text = "두번째 내용이 들어갈 곳".localized()
        cell.listTableText3.text = "세번째 내용이 들어갈 곳".localized()
        cell.listTableText4.text = "네번째 내용이 들어갈 곳".localized()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
                self.items.append([key : string])
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
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(items[0])
    }
}
