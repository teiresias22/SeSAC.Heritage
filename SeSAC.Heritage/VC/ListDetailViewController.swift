import UIKit
import Kingfisher

class ListDetailViewController: UIViewController {
    
    @IBOutlet weak var visitedCheckButton: UIButton!
    @IBOutlet weak var visitedCheckLabel: UILabel!
    
    @IBOutlet weak var wannavisitCheckButton: UIButton!
    @IBOutlet weak var wannavisitCheckLabel: UILabel!
    
    @IBOutlet weak var findWayButton: UIButton!
    @IBOutlet weak var findWayLabel: UILabel!
    
    @IBOutlet weak var detailSmallLabel1: UILabel!
    @IBOutlet weak var detailSmallLable2: UILabel!
    
    @IBOutlet weak var detailBigLabel1: UILabel!
    @IBOutlet weak var detailBigLabel2: UILabel!
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    var items = [String:String]()
    
    var elementName = ""
    var item = [[String:String]]()
    var key: String!
    var ct: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 상세".localized()
        
        print(items)
        
        setButton(visitedCheckButton, "landmark", (.customRed ?? .black))
        setButton(wannavisitCheckButton, "plus", (.customBlue ?? .black))
        setButton(findWayButton, "walking", (.customYellow ?? .black))
        
        setLabel(visitedCheckLabel, "방문했어요")
        setLabel(wannavisitCheckLabel, "방문하고 싶어요")
        setLabel(findWayLabel, "길찾기")
        
        fetcHeritageData()
        // Do any additional setup after loading the view.
    }
    
    func setButton( _ target: UIButton, _ name: String , _ color: UIColor){
        target.setImage(UIImage(named: name), for: .normal)
        target.contentMode = .scaleToFill
        target.setTitle("", for: .normal)
        target.tintColor = color
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
    }
    
    func setLabel(_ target: UILabel, _ text: String){
        target.text = text.localized()
    }
    
    func fetcHeritageData() {
        //필수 파라미터 ccbaKdcd: 종목코드, ccbaAsno: 지정번호, ccbaCtcd: 시도코드
        let url = "\(Endpoint.Heritage_Detail)ccbaKdcd=\(items["ccbaKdcd"]!)&ccbaAsno=\(items["ccbaAsno"]!)&ccbaCtcd=\(items["ccbaCtcd"]!)"
        
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
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
    
        setLabel(detailSmallLabel1, row["ccmaName"]!)
        setLabel(detailSmallLable2, row["ccceName"]!)
        
        setLabel(detailBigLabel1, row["ccbaMnm1"]!)
        setLabel(detailBigLabel2, row["ccbaLcad"]!)
        
        let url = URL(string: row["imageUrl"]!)
        detailImage.kf.setImage(with: url)
        detailImage.contentMode = .scaleAspectFill
        
        detailTextView.text = row["content"]!
    }
}
