//
//  BaseViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/08.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
    }
    
    func configure() {
        view.backgroundColor = .customWhite
    }
    
    func setupConstraints (){
        
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //토스트 메세지 출력
    func toastMessage(message: String, font: UIFont = .Montserrat14 ?? UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-150, y: self.view.frame.size.height-150, width: 300, height: 35))
        toastLabel.backgroundColor = .customGray
        toastLabel.textColor = .customWhite
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview() })
    }

}
