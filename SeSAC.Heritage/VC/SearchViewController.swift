//
//  SearchViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/30.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<Heritage_List>!
    var searchHeritage: Results<Heritage_List>!{
        didSet {
            searchTableView.reloadData()
        }
    }
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 검색".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        tasks = localRealm.objects(Heritage_List.self)
        
        setSearchBar()
        // Do any additional setup after loading the view.
    }
    
    func setSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "숭례문"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let predicate = NSPredicate(format: "ccbaMnm1 CONTAINS[c] %@ OR ccbaMnm2 CONTAINS[c]  %@",searchController.searchBar.text!,searchController.searchBar.text as! CVarArg)
        searchHeritage = localRealm.objects(Heritage_List.self).filter(predicate)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return searchHeritage.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let row = self.searchHeritage[indexPath.row]
        cell.selectionStyle = .none
        
        cell.searchCellView.backgroundColor = .customBlue
        
        cell.countLabel.text = row.no.localized()
        cell.countLabel.textColor = .customBlack
        cell.countLabel.textAlignment = .center
        cell.countLabel.font = UIFont(name: "MapoFlowerIsland", size: 32)!
        
        cell.titleLabel.text = row.ccbaMnm1.localized()
        cell.titleLabel.textColor = .customBlack
        cell.titleLabel.font = UIFont().MapoFlowerIsland16
        
        cell.cityLabel.text = row.ccbaCtcdNm.localized()
        cell.cityLabel.textColor = .customBlack
        cell.cityLabel.font = UIFont().MapoFlowerIsland14
        
        cell.locationLabel.text = row.ccsiName.localized()
        cell.locationLabel.textColor = .customBlack
        cell.locationLabel.font = UIFont().MapoFlowerIsland14
        
        cell.categoryLabel.text = row.ccmaName.localized()
        cell.categoryLabel.textColor = .customBlack
        cell.categoryLabel.font = UIFont().MapoFlowerIsland14
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        
        let row = self.searchHeritage[indexPath.row]
        vc.items = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
