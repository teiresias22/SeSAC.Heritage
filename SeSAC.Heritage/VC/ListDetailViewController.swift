import UIKit
import RealmSwift
import Kingfisher

class ListDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var heritageTypeLabel: UILabel!
    @IBOutlet weak var heritageTitleLabel: UILabel!
    @IBOutlet weak var heritageCityLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var visitedView: UIView!
    @IBOutlet weak var visitedCheckButton: UIButton!
    @IBOutlet weak var visitedCheckLabel: UILabel!
    
    @IBOutlet weak var wannavisitView: UIView!
    @IBOutlet weak var wannavisitCheckButton: UIButton!
    @IBOutlet weak var wannavisitCheckLabel: UILabel!
    
    @IBOutlet weak var findWayView: UIView!
    @IBOutlet weak var findWayButton: UIButton!
    @IBOutlet weak var findWayLabel: UILabel!
    
    @IBOutlet weak var heritageContentLabel: UILabel!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    var items = Heritage_List()
    
    var elementName = ""
    var item = [[String:String]]()
    var key: String!
    var ct: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 상세".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        
        scrollView.backgroundColor = .clear
        visitedView.backgroundColor = .clear
        wannavisitView.backgroundColor = .clear
        findWayView.backgroundColor = .clear
        
        defaultPageSetup()
        fetcHeritageData()
        // Do any additional setup after loading the view.
    }
    
    func defaultPageSetup() {
        
        setButton(visitedCheckButton, "landmark")
        
        setButton(wannavisitCheckButton, "plus")
        
        setButton(findWayButton, "walking")
        
        setLabel(visitedCheckLabel, "방문")
        visitedCheckLabel.textAlignment = .center
        
        setLabel(wannavisitCheckLabel, "즐겨찾기")
        wannavisitCheckLabel.textAlignment = .center
        
        setLabel(findWayLabel, "지도")
        findWayLabel.textAlignment = .center
    }
    
    func setButton( _ target: UIButton, _ name: String){
        target.setImage(UIImage(named: name), for: .normal)
        target.contentMode = .scaleToFill
        target.setTitle("", for: .normal)
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
        
        if items.visited == true {
            visitedCheckButton.tintColor = .customBlue
        } else if items.wantvisit == true {
            wannavisitCheckButton.tintColor = .customYellow
        } else {
            target.tintColor = .customBlack
        }
    }
    
    func setTitle(_ target: UILabel, _ text: String) {
        target.text = text.localized()
        target.font = UIFont(name: "MapoFlowerIsland", size: 20)!
        target.adjustsFontSizeToFitWidth = true
        target.textAlignment = .center
    }
    
    func setLabel(_ target: UILabel, _ text: String){
        target.text = text.localized()
        target.font = UIFont().MapoFlowerIsland14
    }
    
    func fetcHeritageData() {
        //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
        let url = "\(Endpoint.Heritage_Detail)ccbaKdcd=\(items.ccbaKdcd)&ccbaAsno=\(items.ccbaAsno)&ccbaCtcd=\(items.ccbaCtcd)"
        
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
    }    
    
    @IBAction func visitedButtonClicked(_ sender: UIButton) {
        try! localRealm.write{
            items.visited = !items.visited
        }
        setVisitedButtonColor()
    }
    
    @IBAction func wannaVisitedButtonClicked(_ sender: UIButton) {
        try! localRealm.write{
            items.wantvisit = !items.wantvisit
        }
        setWannavisitButtonColor()
    }
    
    @IBAction func findWayButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Map", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.item = items
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
        
        setTitle(heritageTitleLabel, row["ccbaMnm1"]!)
        
        setLabel(heritageTypeLabel, "\(row["ccmaName"]!) 제\(items.sn)호")
        setLabel(heritageCityLabel, "\(row["ccbaCtcdNm"]!) \(row["ccsiName"]!)")
        
        let url = URL(string: row["imageUrl"] ?? "")
        detailImage.kf.setImage(with: url)
        detailImage.backgroundColor = .customBlack
        detailImage.contentMode = .scaleAspectFill
        
        heritageContentLabel.text = row["content"]!
        heritageContentLabel.font = UIFont().MapoFlowerIsland14
    }
}
