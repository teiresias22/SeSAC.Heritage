//
//  ListUpViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/30.
//

import UIKit
import RealmSwift

class ListUpViewController: BaseViewController {
    let mainView = ListUpView()
    var viewModel = ListViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "내목록".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 18)!]
        
        setTableView()
        viewModel.tasks = viewModel.localRealm.objects(Heritage_List.self).filter("visited=true")
        mainView.segmentControl.selectedSegmentIndex = 0
        
        mainView.segmentControl.addTarget(self, action: #selector(segmentControlClicked(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainView.tableView.reloadData()
    }
    
    func setTableView(){
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    @objc func segmentControlClicked(_ target: UISegmentedControl){
        switch target.selectedSegmentIndex {
        case 0:
            viewModel.tasks = viewModel.localRealm.objects(Heritage_List.self).filter("visited=true")
            mainView.tableView.reloadData()
        default:
            viewModel.tasks = viewModel.localRealm.objects(Heritage_List.self).filter("wantvisit=true")
            mainView.tableView.reloadData()
        }
    }
}

extension ListUpViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.tasks.count == 0 {
            return 1
        } else {
            return viewModel.tasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if viewModel.tasks.count == 0 {
            cell.titleLabel.text = "선택된 문화유산 목록이 없습니다."
            cell.cityLabel.text = ""
            cell.locationLabel.text = ""
        } else {
            let row = self.viewModel.tasks[indexPath.row]
            cell.titleLabel.text = row.ccbaMnm1.localized()
            cell.cityLabel.text = row.ccbaCtcdNm.localized()
            cell.locationLabel.text = row.ccsiName.localized()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.tasks.count == 0 {
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = ListDetailViewController()
            let row = self.viewModel.tasks[indexPath.row]
            viewModel.items = row
            vc.viewModel = viewModel
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let wanavisit = UIContextualAction(style: .destructive, title: "WanaVist") { (UIContextualAction, UIView, success:@escaping (Bool) -> Void) in
            let taskToUpdate = self.viewModel.tasks[indexPath.row]
            try! self.viewModel.localRealm.write {
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
            let taskToUpdate = self.viewModel.tasks[indexPath.row]
            try! self.viewModel.localRealm.write {
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
}
