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
        self.title = "나의 문화유산".lowercased()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
        
        segmentedControl.backgroundColor = .customBlue
        segmentedControl.setTitle("방문했어요", forSegmentAt: 0)
        segmentedControl.setTitle("방문하고싶어요", forSegmentAt: 1)
                
        setListUpTable()
        // Do any additional setup after loading the view.
    }
    
    func setListUpTable() {
        listUpTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        listUpTable.delegate = self
        listUpTable.dataSource = self
    }
    
    @IBAction func segmentControlClicked(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0 : segmentValue = true
            listUpTable.reloadData()
            print("firstClicked", segmentValue)

        case 1 : segmentValue = false
            listUpTable.reloadData()
            print("secondClicked", segmentValue)
        default : break
        }
    }
    
}

extension ListUpViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentValue == true{
            tasks = localRealm.objects(Heritage_List.self).filter("visited=true")
        } else {
            tasks = localRealm.objects(Heritage_List.self).filter("wantvisit=true")
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListUpTableViewCell.identifier, for: indexPath) as? ListUpTableViewCell else { return UITableViewCell() }
        let row = self.tasks[indexPath.row]
        
        cell.titleLabel.text = row.ccbaMnm1.localized()
        cell.cityLabel.text = row.ccbaCtcdNm.localized()
        cell.locationLabel.text = row.ccsiName.localized()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        
        let row = tasks[indexPath.row]
        vc.items = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
