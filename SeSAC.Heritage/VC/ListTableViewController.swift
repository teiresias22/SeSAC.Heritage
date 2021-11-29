import UIKit
import RealmSwift

class ListTableViewController: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    var elementName = "" //현재 Element
    var items: Array = [[String: String]]()
    var key: String!
    var ct: Int = 0
    
    var listInformation: String = ""
    var stockCodeData: StockCode?
    var cityData: City?
    var category: String = ""
    
    var pageCount: Int = 1
    var searchTarget: String = ""
    
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
            return items.count
        }else if cityData != nil {
            return items.count
        }else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let row = items[indexPath.row]
        
        cell.countLabel.text = row["sn"]!.localized()
        cell.countLabel.font = UIFont().MapoFlowerIsland16
        cell.titleLabel.text = row["ccbaMnm1"]!.localized()
        cell.titleLabel.font = UIFont().MapoFlowerIsland16
        
        cell.categoryLabel.text = row["ccmaName"]!.localized()
        cell.categoryLabel.font = UIFont().MapoFlowerIsland14
        cell.categoryLabel.frame.size = cell.categoryLabel.intrinsicContentSize
        cell.cityLabel.text = row["ccbaCtcdNm"]!.localized()
        cell.cityLabel.font = UIFont().MapoFlowerIsland14
        cell.locationLabel.text = row["ccsiName"]!.localized()
        cell.locationLabel.font = UIFont().MapoFlowerIsland14
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        
        let row = items[indexPath.row]
        vc.items = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
