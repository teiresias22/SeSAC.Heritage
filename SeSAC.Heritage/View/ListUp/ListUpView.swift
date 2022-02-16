//
//  ListUpView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/11.
//

import UIKit
import SnapKit

class ListUpView: UIView, ViewRepresentable {
    
    let segmentControl: UISegmentedControl = {
        let array: [String] = ["방문함", "즐겨찾기"]
        let control = UISegmentedControl(items: array)
        control.selectedSegmentTintColor = .customRed
        control.backgroundColor = .clear
        
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
            make.height.equalTo(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
         
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
