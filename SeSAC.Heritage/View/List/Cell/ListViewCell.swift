//
//  ListViewCell.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/09.
//

import UIKit

class ListViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.customBlue?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 40
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.MapoFlowerIsland14
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setViews() {
        addSubview(imageView)
        addSubview(label)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(80)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
        
    }
}
