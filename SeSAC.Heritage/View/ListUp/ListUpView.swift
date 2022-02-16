//
//  ListUpView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/11.
//

import UIKit
import SnapKit

class ListUpView: UIView, ViewRepresentable {
    @IBOutlet weak var listUpTable: UITableView!

    let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.selectedSegmentTintColor = .customRed
        control.backgroundColor = .clear
        control.setTitle("방문", forSegmentAt: 0)
        control.setTitle("즐겨찾기", forSegmentAt: 1)
        
        return control
    }()
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(segmentControl)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).inset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
