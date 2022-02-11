//
//  SearchView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/11.
//

import UIKit
import SnapKit

class SearchView: UIView, ViewRepresentable {
    let searchTableView = UITableView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(searchTableView)
    }
    
    func setupConstraints() {
        searchTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
