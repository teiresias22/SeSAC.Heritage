//
//  ListMapView.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/11.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class ListMapView: UIView, ViewRepresentable {
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        
        return view
    }()
    
    let heritageLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "building.columns.fill"), for: .normal)
        button.setTitle("", for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .customBlack
        button.backgroundColor = .customYellow
        
        return button
    }()
    
    let userLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.setTitle("", for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .customBlack
        button.backgroundColor = .customBlue
        
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
        addSubview(mapView)
        addSubview(heritageLocationButton)
        addSubview(userLocationButton)
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        heritageLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(40)
        }
        
        userLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.equalTo(heritageLocationButton.snp.trailing).offset(20)
            make.width.height.equalTo(40)
        }
    }
}
