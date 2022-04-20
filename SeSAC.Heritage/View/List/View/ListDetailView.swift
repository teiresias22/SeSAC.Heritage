//
//  ListDetailView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/10.
//

import UIKit
import SnapKit

class ListDetailView: UIView, ViewRepresentable {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    let contentView = UIView()
    
    let heritageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.font = .MapoFlowerIsland16
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    let heritageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        
        return view
    }()
    
    let heritageTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.font = .MapoFlowerIsland14
        label.textAlignment = .center
        
        return label
    }()
    
    let heritageCityLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.font = .MapoFlowerIsland14
        label.textAlignment = .center
        
        return label
    }()
    
    let detailImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .customBlack
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 80
        view.distribution = .fillEqually
        view.backgroundColor = .customWhite
        
        return view
    }()
    
    let visitedView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        
        return view
    }()
    
    let visitedButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "landmark"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.tintColor = .disabledButton
        
        return button
    }()
    
    let visitedLabel: UILabel = {
        let label = UILabel()
        label.text = "방문".localized()
        label.textAlignment = .center
        label.font = .MapoFlowerIsland14
        label.sizeToFit()
        label.textColor = .customBlack
        
        return label
    }()
    
    let wannaVistView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let wannaVistButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.tintColor = .disabledButton
        
        return button
    }()
    
    let wannaVistLabel: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기".localized()
        label.textAlignment = .center
        label.font = .MapoFlowerIsland14
        label.textColor = .customBlack
        
        return label
    }()
    
    let mapView = UIView()
    
    let mapButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "hiking"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.tintColor = .mapButtonActivate
        
        return button
    }()
    
    let mapLabel: UILabel = {
        let label = UILabel()
        label.text = "지도".localized()
        label.textAlignment = .center
        label.font = .MapoFlowerIsland14
        label.textColor = .customBlack
        
        return label
    }()

    
    let heritageContentText: UITextView = {
        let view = UITextView()
        view.font = UIFont.MapoFlowerIsland14
        view.textColor = .customBlack
        
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(heritageTitleLabel)
        contentView.addSubview(heritageStackView)
        heritageStackView.addArrangedSubview(heritageTypeLabel)
        heritageStackView.addArrangedSubview(heritageCityLabel)
        
        contentView.addSubview(detailImage)
        
        contentView.addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(visitedView)
        visitedView.addSubview(visitedButton)
        visitedView.addSubview(visitedLabel)
        
        buttonStackView.addArrangedSubview(wannaVistView)
        wannaVistView.addSubview(wannaVistButton)
        wannaVistView.addSubview(wannaVistLabel)
        
        buttonStackView.addArrangedSubview(mapView)
        mapView.addSubview(mapButton)
        mapView.addSubview(mapLabel)
        
        contentView.addSubview(heritageContentText)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(1.5)
        }
        
        heritageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        heritageStackView.snp.makeConstraints { make in
            make.top.equalTo(heritageTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }
        
        detailImage.snp.makeConstraints { make in
            make.top.equalTo(heritageStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.width)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(64)
        }
        
        visitedButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        visitedLabel.snp.makeConstraints { make in
            make.top.equalTo(visitedButton.snp.bottom)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
        }
        
        wannaVistButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        wannaVistLabel.snp.makeConstraints { make in
            make.top.equalTo(visitedButton.snp.bottom)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        mapLabel.snp.makeConstraints { make in
            make.top.equalTo(visitedButton.snp.bottom)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
        }
        
        heritageContentText.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}
