import UIKit
import FirebaseInstallations

class ListViewController: BaseViewController {
    let mainView = ListView()
    var viewModel = ListViewModel()
    
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
    
    private func setCollectionView(){
        mainView.contentCollectionView.delegate = self
        mainView.contentCollectionView.dataSource = self
        
        mainView.contentCollectionView.register(ListViewCell.self, forCellWithReuseIdentifier: ListViewCellId)
    }
    
    @objc func cityButtonClicked(){
        setButtonActive(mainView.cityButton)
        setButtonDeActive(mainView.stockCodeButton)
        viewModel.target = "City"
        mainView.contentCollectionView.reloadData()
    }
    
    @objc func stockCodeButtonClicked(){
        setButtonActive(mainView.stockCodeButton)
        setButtonDeActive(mainView.cityButton)
        viewModel.target = "StockCode"
        mainView.contentCollectionView.reloadData()
    }
    
    private func setButtonActive(_ target: UIButton){
        target.titleLabel?.font = .MapoFlowerIsland16
        target.setTitleColor(.customWhite, for: .normal)
        target.layer.cornerRadius = 24
        target.layer.borderWidth = 1
        target.layer.borderColor = UIColor.customGray?.cgColor
        target.backgroundColor = .customBlack
    }
    
    private func setButtonDeActive(_ target: UIButton){
        target.titleLabel?.font = .MapoFlowerIsland14
        target.setTitleColor(.customBlack, for: .normal)
        target.layer.cornerRadius = 0
        target.layer.borderWidth = 0
        target.layer.borderColor = UIColor.customWhite?.cgColor
        target.backgroundColor = .customWhite
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.target == "StockCode" {
            return viewModel.stockCodeInformation.stockCode.count
        }else {
            return viewModel.cityInformation.city.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = mainView.contentCollectionView.dequeueReusableCell(withReuseIdentifier: ListViewCellId, for: indexPath) as? ListViewCell else { return UICollectionViewCell() }
        
        if viewModel.target == "StockCode" {
            
            if let url = URL(string: viewModel.stockCodeInformation.stockCode[indexPath.row].image){
                item.imageView.kf.setImage(with: url)
            } else {
                item.imageView.image = UIImage(systemName: "star")
                item.imageView.backgroundColor = .customYellow
            }
            item.label.text = viewModel.stockCodeInformation.stockCode[indexPath.row].text.lowercased()
            
        } else if viewModel.target == "City" {
            
            if let url = URL(string: viewModel.cityInformation.city[indexPath.row].image){
                item.imageView.kf.setImage(with: url)
            } else {
                item.imageView.image = UIImage(systemName: "star")
                item.imageView.backgroundColor = .customBlue
            }
            item.label.text = viewModel.cityInformation.city[indexPath.row].city.lowercased()
        }
        item.backgroundColor = .clear
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.target == "StockCode" {
            viewModel.stockCodeData = viewModel.stockCodeInformation.stockCode[indexPath.row]
        } else {
            viewModel.cityData = viewModel.cityInformation.city[indexPath.row]
        }
        let vc = ListTableViewController()
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
