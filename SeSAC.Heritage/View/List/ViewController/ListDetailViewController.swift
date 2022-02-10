// todo
// contentView 높이 자동 조절
// 지도 좌표가 표시되지 않는다면 맵버튼 비활성화 & TostMessage 띄우기

import UIKit
import RealmSwift
import Kingfisher

class ListDetailViewController: BaseViewController {
    let mainView = ListDetailView()
    var viewModel: ListViewModel?
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    var items = Heritage_List()
    
    var elementName = ""
    var item = [[String:String]]()
    var key: String!
    var ct: Int = 0
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 상세".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 18)!]
        
        fetcHeritageData()
        checkButtonActive()
        
        mainView.visitedButton.addTarget(self, action: #selector(visitedButtonClicked), for: .touchUpInside)
        mainView.wannaVistButton.addTarget(self, action: #selector(wannaVisitButtonClicked), for: .touchUpInside)
        mainView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
    }
    
    func fetcHeritageData() {
        //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
        let url = "\(Endpoint.Heritage_Detail)ccbaKdcd=\(items.ccbaKdcd)&ccbaAsno=\(items.ccbaAsno)&ccbaCtcd=\(items.ccbaCtcd)"
        
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
    }
    
    func checkButtonActive(){
        if items.visited {
            mainView.visitedButton.tintColor = .customBlue
        }
        
        if items.wantvisit {
            mainView.visitedButton.tintColor = .customYellow
        }
    }
    
    @objc func visitedButtonClicked() {
        try! localRealm.write{
            items.visited = !items.visited
        }
        
        if items.visited {
            mainView.visitedButton.tintColor = .customBlue
        } else {
            mainView.visitedButton.tintColor = .customBlack
        }
    }
    
    @objc func wannaVisitButtonClicked() {
        try! localRealm.write{
            items.wantvisit = !items.wantvisit
        }
        
        if items.wantvisit {
            mainView.wannaVistButton.tintColor = .customYellow
        } else {
            mainView.wannaVistButton.tintColor = .customBlack
        }
    }
    
    @objc func mapButtonClicked() {
        
        let vc = ListMapViewController()
        vc.viewModel = viewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ListDetailViewController: XMLParserDelegate {
    //XMLParser가 시작 태그를 만나면 호출됨
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ccmaName" || elementName == "ccbaMnm1" || elementName == "ccbaMnm2" || elementName == "gcodeName" || elementName == "bcodeName" || elementName == "mcodeName" || elementName == "scodeName" || elementName == "ccbaQuan" || elementName == "ccbaAsdt" || elementName == "ccbaCtcdNm"  || elementName == "ccsiName"  || elementName == "ccbaLcad"  || elementName == "ccceName"  || elementName == "ccbaPoss"  || elementName == "ccbaAdmin"  || elementName == "ccbaCncl"  || elementName == "imageUrl"  || elementName == "content"{
            self.key = elementName
        }
    }
    
    // 태그의 Data가 String으로 들어옴
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.key != nil {
            if self.key == "ccmaName" {
                self.item.append([key : string])
            } else {
                self.item[ct][key] = string
            }
        }
    }
    
    //XMLParser가 종료 태그를 만나면 호출됨
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.key = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        let row = item[0]
        
        mainView.heritageTitleLabel.text = row["ccbaMnm1"]
        mainView.heritageTypeLabel.text = "\(row["ccmaName"]!) 제\(items.sn)호"
        mainView.heritageCityLabel.text = "\(row["ccbaCtcdNm"]!) \(row["ccsiName"]!)"
        
        let url = URL(string: row["imageUrl"] ?? "")
        mainView.detailImage.kf.setImage(with: url)
        mainView.heritageContentText.text = row["content"]!
    }
}
