import UIKit
import RealmSwift

class ListViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    @IBOutlet weak var myPageButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var listPageButton: UIButton!
    
    let listInformation = ListInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "JHeritage".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        
        let nibName = UINib(nibName: ListCollectionViewCell.identifier, bundle: nil)
        listCollectionView.register(nibName, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)

         // Do any additional setup after loading the view.
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        setTabBarButton(myPageButton, "나의")
        setTabBarButton(mapButton, "지도")
        setTabBarButton(listPageButton, "목록")
        
        collectionViewSet()
        
        //print(">>\(UserDefaults.standard.object(forKey: "AppleLanguages"))<<")
    }
    
    func collectionViewSet() {
        let screenScale = UIScreen.main.bounds.size.width
        let layout = UICollectionViewFlowLayout()
        
        if screenScale <= 400 {
            let spacing: CGFloat = 4
            let width = listCollectionView.frame.width - (spacing * 3)
            let height = listCollectionView.frame.height - (spacing * 3)
            layout.itemSize = CGSize(width: width / 2.25 , height: height / 2.4)
            
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            
        } else {
            let spacing: CGFloat = 8
            let width = listCollectionView.frame.width - (spacing * 3)
            let height = listCollectionView.frame.height - (spacing * 3)
            layout.itemSize = CGSize(width: width / 2, height: height / 2)
            
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
        }
        layout.scrollDirection = .vertical
        
        listCollectionView.collectionViewLayout = layout
        listCollectionView.backgroundColor = .clear
    }
    
    func setTabBarButton( _ target: UIButton, _ name: String){
        target.translatesAutoresizingMaskIntoConstraints = false
        target.titleLabel?.adjustsFontForContentSizeCategory = true
        //target.setImage(UIImage(systemName: name), for: .normal)
        //target.tintColor = .customBlack
        target.setTitle(name, for: .normal)
        target.setTitleColor(.customBlack, for: .normal)
        target.semanticContentAttribute = .forceLeftToRight
        target.contentVerticalAlignment = .center
        target.contentHorizontalAlignment = .leading
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
        cell.listImage.image = UIGraphicsImageRenderer(size: CGSize(width: 50, height: 50)).image { _ in
            UIImage(named: "\(listInformation.list[indexPath.row].image)")?.withTintColor(.white).draw(in: CGRect(x: 0, y: 0, width: 50, height: 50))
        }
        cell.listText.text = listInformation.list[indexPath.row].text.localized()
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetSB = listInformation.list[indexPath.row].target
        
        if targetSB == "Search" {
            let sb = UIStoryboard(name: "Search", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if targetSB == "ListUp"{
            let sb = UIStoryboard(name: "ListUp", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ListUpViewController") as! ListUpViewController
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
