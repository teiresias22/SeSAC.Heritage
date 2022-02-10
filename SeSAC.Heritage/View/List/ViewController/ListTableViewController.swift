import UIKit
import RealmSwift

class ListTableViewController: BaseViewController {
    let mainView = ListTableView()
    var viewModel: ListViewModel?
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!

    var listInformation: String = ""
    var stockCodeData: StockCode?
    var cityData: City?
    var category: String = ""
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listInformation == "StockCode" {
            self.title = "종류별 문화유산".localized()
        } else {
            self.title = "지역별 문화유산".localized()
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 18)!]
        
        setupView()
    }
    
    func setupView() {
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        mainView.listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        mainView.listTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stockCodeData != nil {
            if stockCodeData!.code == 0 {
                tasks = localRealm.objects(Heritage_List.self)
            } else {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(stockCodeData!.code)'")
            }
        }else if cityData != nil {
            if cityData!.code == "00" {
                tasks = localRealm.objects(Heritage_List.self)
            } else {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(cityData!.code)'")
            }
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        if stockCodeData != nil {
            if stockCodeData!.code == 0 {
                tasks = localRealm.objects(Heritage_List.self)
            } else {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(stockCodeData!.code)'")
            }
        } else if cityData != nil {
            if cityData!.code == "00" {
                tasks = localRealm.objects(Heritage_List.self)
            } else {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(cityData!.code)'")
            }
        }
        let row = tasks[indexPath.row]
        cell.selectionStyle = .none
        
        cell.titleLabel.text = row.ccbaMnm1.localized()
        cell.cityLabel.text = row.ccbaCtcdNm.localized()
        cell.locationLabel.text = row.ccsiName.localized()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListDetailViewController()
        let row = tasks[indexPath.row]        
        vc.items = row
        vc.viewModel = viewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
