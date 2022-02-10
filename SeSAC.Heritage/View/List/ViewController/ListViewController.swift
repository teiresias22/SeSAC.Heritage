// Todo
// ViewModel 분리하기

import UIKit
import RealmSwift
import FirebaseInstallations

class ListViewController: BaseViewController {
    let mainView = ListView()
    var viewModel = ListViewModel()
    
    let listInformation = ListInformation()
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    var target: String = "StockCode"
    
    private let ListViewCellId = "ListViewCellId"
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JHeritage".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 18)!]
        
        setCollectionView()
        
        mainView.cityButton.addTarget(self, action: #selector(cityButtonClicked), for: .touchUpInside)
        mainView.stockCodeButton.addTarget(self, action: #selector(stockCodeButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Installations.installations().delete { error in
            if let error = error {
                print("Error deleting installations: \(error)")
                return
            }
            print("Installation deleted");
        }
    }
    
    func setCollectionView(){
        mainView.contentCollectionView.delegate = self
        mainView.contentCollectionView.dataSource = self
        
        mainView.contentCollectionView.register(ListViewCell.self, forCellWithReuseIdentifier: ListViewCellId)
    }
    
    @objc func cityButtonClicked(){
        setButtonActive(mainView.cityButton)
        setButtonDeActive(mainView.stockCodeButton)
        target = "City"
        mainView.contentCollectionView.reloadData()
    }
    
    @objc func stockCodeButtonClicked(){
        setButtonActive(mainView.stockCodeButton)
        setButtonDeActive(mainView.cityButton)
        target = "StockCode"
        mainView.contentCollectionView.reloadData()
    }
    
    func setButtonActive(_ target: UIButton){
        target.titleLabel?.font = .MapoFlowerIsland16
        target.setTitleColor(.customWhite, for: .normal)
        target.backgroundColor = .customBlack
    }
    
    func setButtonDeActive(_ target: UIButton){
        target.titleLabel?.font = .MapoFlowerIsland14
        target.setTitleColor(.customBlack, for: .normal)
        target.backgroundColor = .customWhite
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if target == "StockCode" {
            return stockCodeInformation.stockCode.count
        }else {
            return cityInformation.city.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = mainView.contentCollectionView.dequeueReusableCell(withReuseIdentifier: ListViewCellId, for: indexPath) as? ListViewCell else { return UICollectionViewCell() }
        
        if target == "StockCode" {
            
            if let url = URL(string: stockCodeInformation.stockCode[indexPath.row].image){
                item.imageView.kf.setImage(with: url)
            } else {
                item.imageView.image = UIImage(systemName: "star")
                item.imageView.backgroundColor = .customYellow
            }
            item.label.text = stockCodeInformation.stockCode[indexPath.row].text.lowercased()
            
        } else if target == "City" {
            
            if let url = URL(string: cityInformation.city[indexPath.row].image){
                item.imageView.kf.setImage(with: url)
            } else {
                item.imageView.image = UIImage(systemName: "star")
                item.imageView.backgroundColor = .customBlue
            }
            item.label.text = cityInformation.city[indexPath.row].city.lowercased()
        }
        item.backgroundColor = .clear
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListTableViewController()
        
        if target == "StockCode" {
            let row = stockCodeInformation.stockCode[indexPath.row]
            vc.stockCodeData = row
        } else {
            let row = cityInformation.city[indexPath.row]
            vc.cityData = row
        }
        vc.viewModel = viewModel
        vc.listInformation = target
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
