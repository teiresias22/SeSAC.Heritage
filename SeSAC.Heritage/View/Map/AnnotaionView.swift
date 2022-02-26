//
//  AnnotaionView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/27.
//

import UIKit
import SnapKit

class AnnotaionView: UIView, ViewRepresentable {
    let heritageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.font = .MapoFlowerIsland16
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    let heritageTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.font = .MapoFlowerIsland14
        label.textAlignment = .center
        
        return label
    }()
    
    let goDetailButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    let visitedButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "landmark"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.tintColor = .customBlack
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    let wannaVistButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.contentMode = .scaleToFill
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.tintColor = .customBlack
        
        return button
    }()
    
    let seeDetailButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.contentMode = .scaleToFill
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.tintColor = .customBlack
        
        return button
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
        
    }
    
    func setupConstraints() {
        
    }
}
