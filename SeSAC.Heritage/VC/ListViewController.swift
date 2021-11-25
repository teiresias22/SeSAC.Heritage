import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire
import Kingfisher

class ListViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let listInformation = ListInformation()
    let localRealm = try! Realm()

    var elementName = "" //현재 Element
    var items: Array = [[String: String]]()
    var key: String!
    var ct: Int = 0
    
    var totalCnt: String = "" //문화유산 검색 목록
    var pageUnit: Int = 0 //한페이지당 검색수
    var pageCnt: Int = 1 //현재 페이지수
    var totalPageCnt: Int = 0 //최종 페이지수 [totalCnt / pageUnit]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 목록".localized()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        let nibName = UINib(nibName: ListCollectionViewCell.identifier, bundle: nil)
        listCollectionView.register(nibName, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)

         // Do any additional setup after loading the view.
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        collectionViewSet()
        fetcMediaData()
    }
    
    func collectionViewSet() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = listCollectionView.frame.width - (spacing * 3)
        let height = listCollectionView.frame.height - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2 , height: height / 2  )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        listCollectionView.collectionViewLayout = layout
        listCollectionView.backgroundColor = .clear
    }
    
    func fetcMediaData() {
        let url = Endpoint.Heritage_List
        let parser = XMLParser(contentsOf: URL(string: url)!)
        parser?.delegate = self
        parser?.parse()
    }
    
    
    
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listInformation.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        
        cell.backgroundColor = .customBlue
        cell.layer.cornerRadius = 8
        
        cell.listTitle.text = listInformation.list[indexPath.row].title.localized()
        cell.listText.text = listInformation.list[indexPath.row].text.localized()
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetSB = listInformation.list[indexPath.row].target
        
        if targetSB == "Map" {
            let sb = UIStoryboard(name: "Map", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let sb = UIStoryboard(name: "ListCategory", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ListCategoryViewController") as! ListCategoryViewController
            let row = listInformation.list[indexPath.row].title
            vc.listInformation = row
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ListViewController: XMLParserDelegate {
    
    //XMLParser가 시작 태그를 만나면 호출됨
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "sn" || elementName == "no" || elementName == "ccmaName" || elementName == "crltsnoNm" || elementName == "ccbaMnm1" || elementName == "ccbaMnm2" || elementName == "ccbaCtcdNm" || elementName == "ccsiName" || elementName == "ccbaAdmin" || elementName == "ccbaKdcd"  || elementName == "ccbaCtcd"  || elementName == "ccbaAsno"  || elementName == "ccbaCncl"  || elementName == "ccbaCpno"  || elementName == "longitude"  || elementName == "latitude" {
            self.key = elementName
        }
        
        if elementName == "totalCnt" {
            self.totalCnt = elementName
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
        if key == "6" {
            ct = ct + 1
        }
        //items는 Key : Value로 구성된 값인데 이걸 Realm에 어떻게 저장하지??
    }
    
    //XMLParser가 종료 태그를 만나면 호출됨
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.key = nil
    }
}
