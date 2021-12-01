import UIKit
import RealmSwift

class ListTableViewController: UIViewController {
    @IBOutlet weak var listTable: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!

    var listInformation: String = ""
    
    var stockCodeData: StockCode?
    var cityData: City?
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = listInformation.localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
                
        listTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        listTable.delegate = self
        listTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stockCodeData != nil {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(stockCodeData!.code)'")
        }else if cityData != nil {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(cityData!.code)'")
        }
        
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        if stockCodeData != nil {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(stockCodeData!.code)'")
            
        } else if cityData != nil {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(cityData!.code)'")
        }
        let row = tasks[indexPath.row]
        cell.selectionStyle = .none
        
        cell.countLabel.text = row.no.localized()
        cell.titleLabel.text = row.ccbaMnm1.localized()
        cell.categoryLabel.text = row.ccmaName.localized()
        cell.categoryLabel.frame.size = cell.categoryLabel.intrinsicContentSize
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
        return UISwipeActionsConfiguration(actions: [wanavisit])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
        return UISwipeActionsConfiguration(actions: [visit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        let row = tasks[indexPath.row]        
        vc.items = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
