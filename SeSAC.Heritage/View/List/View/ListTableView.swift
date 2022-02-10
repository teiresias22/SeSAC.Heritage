//
//  ListTableView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/09.
//

import UIKit
import SnapKit

class ListTableView: UIView, ViewRepresentable {
    let listTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(listTableView)
        
    }
    
    func setupConstraints() {
        listTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
