import UIKit
import RealmSwift

class ListViewController: UIViewController {
    @IBOutlet weak var TabBarButtonCollection: UICollectionView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let listInformation = ListInformation()
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    var target: String = "StockCode"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JHeritage".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        
        let nibName1 = UINib(nibName: ListCollectionViewCell.identifier, bundle: nil)
        TabBarButtonCollection.register(nibName1, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
        let nibName2 = UINib(nibName: ListCategoryCollectionViewCell.identifier, bundle: nil)
        listCollectionView.register(nibName2, forCellWithReuseIdentifier: ListCategoryCollectionViewCell.identifier)

         // Do any additional setup after loading the view.
        listCollectionView.delegate = self
        TabBarButtonCollection.delegate = self
        
        listCollectionView.dataSource = self
        TabBarButtonCollection.dataSource = self
        
        listCollectionViewSet()
        TabBarButtonCollectionViewSet()
        
        //print(">>\(UserDefaults.standard.object(forKey: "AppleLanguages"))<<")
    }
    func TabBarButtonCollectionViewSet() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 4
        let width = listCollectionView.frame.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: 42)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        TabBarButtonCollection.collectionViewLayout = layout
        TabBarButtonCollection.backgroundColor = .clear
    }
    
    
    func listCollectionViewSet() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = listCollectionView.frame.width - (spacing * 5)
        
        layout.itemSize = CGSize(width: width / 4 , height: width / 2.5  )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing * 2, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        listCollectionView.collectionViewLayout = layout
        listCollectionView.backgroundColor = .clear
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == TabBarButtonCollection {
            return listInformation.list.count
        } else {
            if target == "StockCode" {
                return stockCodeInformation.stockCode.count
            }else {
                return cityInformation.city.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == TabBarButtonCollection {
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
            item.listTitle.text = listInformation.list[indexPath.row].title.localized()
                        
            return item
        } else {
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ListCategoryCollectionViewCell.identifier, for: indexPath) as? ListCategoryCollectionViewCell else { return UICollectionViewCell() }
            item.backgroundColor = .clear
            
            if target == "StockCode" {
                if let url = URL(string: stockCodeInformation.stockCode[indexPath.row].image){
                    item.listCategoryImage.kf.setImage(with: url)
                } else {
                    item.listCategoryImage.image = UIImage(systemName: "star")
                    item.listCategoryImage.backgroundColor = .customYellow
                }
                item.listCategoryLabel.text = stockCodeInformation.stockCode[indexPath.row].text.lowercased()
                item.listCategoryImage.layer.borderWidth = 2
                item.listCategoryImage.layer.borderColor = UIColor.customYellow?.cgColor
            } else if target == "City" {
                if let url = URL(string: cityInformation.city[indexPath.row].image){
                    item.listCategoryImage.kf.setImage(with: url)
                } else {
                    item.listCategoryImage.image = UIImage(systemName: "star")
                    item.listCategoryImage.backgroundColor = .customBlue
                }
                item.listCategoryLabel.text = cityInformation.city[indexPath.row].city.lowercased()
                item.listCategoryImage.layer.borderWidth = 2
                item.listCategoryImage.layer.borderColor = UIColor.customBlue?.cgColor
            }
            item.listCategoryLabel.font = UIFont().MapoFlowerIsland14
            
            let width = item.frame.width
            item.listCategoryImage.layer.cornerRadius = width/2
            
            return item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == TabBarButtonCollection {
            target = listInformation.list[indexPath.row].target
            
            TabBarButtonCollection.reloadData()
            listCollectionView.reloadData()
        } else {
            let sb = UIStoryboard(name: "ListTable", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
            
            if target == "StockCode" {
                let row = stockCodeInformation.stockCode[indexPath.row]
                vc.stockCodeData = row
            } else {
                let row = cityInformation.city[indexPath.row]
                vc.cityData = row
            }
            
            vc.listInformation = target
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
