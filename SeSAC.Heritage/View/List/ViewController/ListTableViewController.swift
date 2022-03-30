import UIKit

class ListTableViewController: BaseViewController {
    let mainView = ListTableView()
    var viewModel: ListViewModel?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel?.target == "StockCode" {
            self.title = viewModel?.stockCodeData?.text.localized()
        } else {
            self.title = viewModel?.cityData?.city.localized()
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
        
        if viewModel?.target == "StockCode" {
            if viewModel?.stockCodeData!.code == 0 {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self)
            } else {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(viewModel!.stockCodeData!.code)'")
            }
        } else if viewModel?.cityData != nil {
            if viewModel?.cityData!.code == "00" {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self)
            } else {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(viewModel!.cityData!.code)'")
            }
        }
        return viewModel!.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        if viewModel?.target == "StockCode" {
            if viewModel?.stockCodeData!.code == 0 {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self)
            } else {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(viewModel!.stockCodeData!.code)'")
            }
        } else if viewModel?.cityData != nil {
            if viewModel?.cityData!.code == "00" {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self)
            } else {
                viewModel!.tasks = viewModel!.localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(viewModel!.cityData!.code)'")
            }
        }
        let row = viewModel!.tasks[indexPath.row]
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
            let taskToUpdate = self.viewModel!.tasks[indexPath.row]
            try! self.viewModel!.localRealm.write {
                if taskToUpdate.wantvisit {
                    self.toastMessage(message: "즐겨찾기 목록에서 제거했습니다.")
                } else {
                    self.toastMessage(message: "즐겨찾기 목록에 추가했습니다.")
                }
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
            let taskToUpdate = self.viewModel!.tasks[indexPath.row]
            try! self.viewModel!.localRealm.write {
                if taskToUpdate.visited {
                    self.toastMessage(message: "방문 목록에서 제거했습니다.")
                } else {
                    self.toastMessage(message: "방문 목록에 추가했습니다.")
                }
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
        viewModel!.items = viewModel!.tasks[indexPath.row]
        let vc = ListDetailViewController()
        vc.viewModel = viewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
