//
//  TabBarButton.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/14.
//

import UIKit

class TabBarButton: UIView {
    
    @IBOutlet weak var tabBarButton: UIButton!
    @IBOutlet weak var tabBarActiveView: UIView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        loadUI()
    }
    
    func loadView() {
        let view = UINib(nibName: "TabBarButton", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        self.addSubview(view)
    }
    
    func loadUI() {
        tabBarButton.tintColor = .customBlue
        tabBarActiveView.layer.cornerRadius = 3
    }
}
