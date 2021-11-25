import UIKit

class ListCategoryViewController: UIViewController {

    @IBOutlet weak var listCategoryCollectionView: UICollectionView!
    
    var listInformation: String = ""
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = listInformation.localized()
        
        let nibName = UINib(nibName: ListCategoryCollectionViewCell.identifier, bundle: nil)
        listCategoryCollectionView.register(nibName, forCellWithReuseIdentifier: ListCategoryCollectionViewCell.identifier)
        
        listCategoryCollectionView.dataSource = self
        listCategoryCollectionView.delegate = self
        collectionViewSet()
        
        // Do any additional setup after loading the view.
    }
    
    func collectionViewSet() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = listCategoryCollectionView.frame.width - (spacing * 5)
        
        layout.itemSize = CGSize(width: width / 4 , height: width / 2.5  )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing * 2, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        listCategoryCollectionView.collectionViewLayout = layout
        listCategoryCollectionView.backgroundColor = .clear
    }
    
}

extension ListCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listInformation == "종류별 문화재" {
            return stockCodeInformation.stockCode.count
        } else if listInformation == "지역별 문화재" {
            return cityInformation.city.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ListCategoryCollectionViewCell.identifier, for: indexPath) as? ListCategoryCollectionViewCell else { return UICollectionViewCell() }
        item.backgroundColor = .clear
        
        if listInformation == "종류별 문화재" {
            if let url = URL(string: stockCodeInformation.stockCode[indexPath.row].image){
                item.listCategoryImage.kf.setImage(with: url)
            } else {
                item.listCategoryImage.image = UIImage(systemName: "star")
                item.listCategoryImage.backgroundColor = .customYellow
            }
            item.listCategoryLabel.text = stockCodeInformation.stockCode[indexPath.row].text.lowercased()
        } else if listInformation == "지역별 문화재" {
            if let url = URL(string: cityInformation.city[indexPath.row].image){
                item.listCategoryImage.kf.setImage(with: url)
            } else {
                item.listCategoryImage.image = UIImage(systemName: "star")
                item.listCategoryImage.backgroundColor = .customBlue
            }
            item.listCategoryLabel.text = cityInformation.city[indexPath.row].city.lowercased()
        } else {
            item.listCategoryImage.backgroundColor = .customBlack
            item.listCategoryLabel.text = "서비스 준비중입니다."
        }
        
        item.listCategoryImage.layer.borderWidth = 6
        item.listCategoryImage.layer.borderColor = UIColor.customRed?.cgColor
        let width = item.frame.width
        item.listCategoryImage.layer.cornerRadius = width/2
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListTable", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
        if listInformation == "종류별 문화재" {
            let row = stockCodeInformation.stockCode[indexPath.row].text
            vc.category = row
        } else if listInformation == "지역별 문화재" {
            let row = cityInformation.city[indexPath.row].city
            vc.category = row
        } else {
            let row = "준비중"
            vc.category = row
        }
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
