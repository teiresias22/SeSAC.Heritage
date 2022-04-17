//
//  ListView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/09.
//

import UIKit
import SnapKit

class ListView: UIView, ViewRepresentable {
    let topStatickView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fillEqually
        
        return view
    }()
    
    let stockCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("종류별 문화유산".localized(), for: .normal)
        button.setTitleColor(.customWhite, for: .normal)
        button.titleLabel?.font = .MapoFlowerIsland16
        button.backgroundColor = .customBlack
        
        return button
    }()
    
    let cityButton: UIButton = {
        let button = UIButton()
        button.setTitle("지역별 문화유산".localized(), for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .MapoFlowerIsland14
        button.backgroundColor = .customWhite
        
        return button
    }()
    
    let contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        if let flowLayout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(topStatickView)
        topStatickView.addArrangedSubview(stockCodeButton)
        topStatickView.addArrangedSubview(cityButton)
        
        addSubview(contentCollectionView)
    }
    
    func setupConstraints() {
        topStatickView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topStatickView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}
