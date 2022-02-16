//
//  FirstView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/10.
//

import UIKit
import SnapKit

class FirstView: UIView, ViewRepresentable {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LaunchScreen")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "JHeritage".localized()
        label.textAlignment = .center
        label.font = UIFont(name: "MapoFlowerIsland", size: 40)!
        label.textColor = .customYellow
        
        return label
    }()
    
    let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "앱을 설정중에 있습니다.\n앱을 종료하지 마시고 잠시만 기다려주세요.".localized()
        label.numberOfLines = 0
        label.font = .MapoFlowerIsland16
        label.textColor = .customRed
        
        return label
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
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(noticeLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(20)
        }
    }
}
