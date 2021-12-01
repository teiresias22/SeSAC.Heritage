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
        
        cell.countLabel.text = row.no.localized()
        cell.titleLabel.text = row.ccbaMnm1.localized()
        cell.cityLabel.text = row.ccbaCtcdNm.localized()
        cell.locationLabel.text = row.ccsiName.localized()
        cell.categoryLabel.text = row.ccmaName.localized()
        
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let wanavisit = UIContextualAction(style: .destructive, title: "WanaVist") { (UIContextualAction, UIView, success:@escaping (Bool) -> Void) in
            let taskToUpdate = self.tasks[indexPath.row]
            try! self.localRealm.write {
                taskToUpdate.wantvisit = !taskToUpdate.wantvisit
            }
            tableView.reloadData()
            success (true)
        }
        wanavisit.image = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: "plus")?.withTintColor(.customWhite ?? .white).draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        }
        wanavisit.backgroundColor = .customBlue
        
        let visit = UIContextualAction(style: .destructive, title: "Visited") { (UIContextualAction, UIView, success:@escaping (Bool) -> Void) in
            let taskToUpdate = self.tasks[indexPath.row]
            try! self.localRealm.write {
                taskToUpdate.visited = !taskToUpdate.visited
            }
            tableView.reloadData()
            success (true)
        }
        visit.image = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: "landmark")?.withTintColor(.customWhite ?? .white).draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        }
        visit.backgroundColor = .customYellow
        return UISwipeActionsConfiguration(actions: [wanavisit, visit])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    
}
