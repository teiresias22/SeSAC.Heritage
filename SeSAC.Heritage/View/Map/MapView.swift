//
//  MapView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/11.
//

import UIKit
import SnapKit
import MapKit

class MapView: UIView, ViewRepresentable {
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        
        return view
    }()
    
    let userLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "street"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.contentMode = .scaleToFill
        button.setTitle("", for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.cornerRadius = 20
        button.tintColor = .customBlack
        button.backgroundColor = .customBlue
        
        return button
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loader.gif"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.contentMode = .scaleToFill
        button.setTitle("", for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.cornerRadius = 20
        button.tintColor = .customBlack
        button.backgroundColor = .customYellow
        
        return button
    }()
    
    let textField: UITextField = {
        let textfield = UITextField()
        
        return textfield
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
        addSubview(mapView)
        addSubview(userLocationButton)
        addSubview(filterButton)
        addSubview(textField)
        
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        userLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(40)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.leading.equalTo(userLocationButton.snp.trailing).offset(20)
            make.width.height.equalTo(40)
        }
        
        textField.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.height.equalTo(0)
        }
    }
}
