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
    
    let leftView = UIView()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("종류별 문화유산", for: .normal)
        button.setTitleColor(.customWhite, for: .normal)
        button.titleLabel?.font = .MapoFlowerIsland16
        button.backgroundColor = .customBlack
        
        return button
    }()
    
    let leftUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customBlue
        
        return view
    }()
    
    let rightView = UIView()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("지역별 문화유산", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .MapoFlowerIsland14
        button.backgroundColor = .customWhite
        
        return button
    }()
    
    let rightUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customBlack
        
        return view
    }()
    
    let contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
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
        topStatickView.addArrangedSubview(leftView)
        leftView.addSubview(leftButton)
        leftView.addSubview(leftUnderLine)
        
        topStatickView.addArrangedSubview(rightView)
        rightView.addSubview(rightButton)
        rightView.addSubview(rightUnderLine)
        
        addSubview(contentCollectionView)
    }
    
    func setupConstraints() {
        topStatickView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(49)
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        leftUnderLine.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        leftUnderLine.snp.makeConstraints { make in
            make.top.equalTo(rightButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topStatickView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}

class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 8.0
        self.sectionInset = UIEdgeInsets(top: 5.0, left: 16.0, bottom: 5.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
 
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
