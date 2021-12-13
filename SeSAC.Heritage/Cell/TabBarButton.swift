//
//  TabBarButton.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/14.
//

import UIKit

class TabBarButton: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activeBar: UIView!
    @IBOutlet weak var barText: UILabel!
    
    
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
        barText.font = UIFont().MapoFlowerIsland12
        barText.textColor = .customBlack
        barText.textAlignment = .center
    }
    
    
    
}
