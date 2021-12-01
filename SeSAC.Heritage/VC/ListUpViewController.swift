//
//  ListUpViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/30.
//

import UIKit
import RealmSwift

class ListUpViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var listUpTable: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    var segmentValue: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "나의 문화유산".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        tasks = localRealm.objects(Heritage_List.self).filter("visited=true")
        
        segmentedControl.backgroundColor = .customBlue
        segmentedControl.setTitle("방문했어요", forSegmentAt: 0)
        segmentedControl.setTitle("방문하고싶어요", forSegmentAt: 1)
        
        listUpTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        listUpTable.delegate = self
        listUpTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listUpTable.reloadData()
    }
    
    @IBAction func segmentControlClicked(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0 : segmentValue = true
                 tasks = localRealm.objects(Heritage_List.self).filter("visited=true")
                 listUpTable.reloadData()
        case 1 : segmentValue = false
                 tasks = localRealm.objects(Heritage_List.self).filter("wantvisit=true")
                 listUpTable.reloadData()
        default : break
        }
    }
}

extension ListUpViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tasks != nil {
            return tasks.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListUpTableViewCell.identifier, for: indexPath) as? ListUpTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        if tasks != nil {
            let row = self.tasks[indexPath.row]
            cell.titleLabel.text = row.ccbaMnm1.localized()
            cell.cityLabel.text = row.ccbaCtcdNm.localized()
            cell.locationLabel.text = row.ccsiName.localized()
        } else {
            cell.titleLabel.text = "마크한 문화유산이 아직 없습니다. \n문화유산을 둘러보시는게 어떨까요?"
            cell.titleLabel.numberOfLines = 0
            cell.cityLabel.text = ""
            cell.locationLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tasks != nil {
            let sb = UIStoryboard(name: "ListDetail", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
            let row = tasks[indexPath.row]
            vc.items = row
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let sb = UIStoryboard(name: "List", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tasks != nil {
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
            return UISwipeActionsConfiguration(actions: [visit, wanavisit])
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }

}
