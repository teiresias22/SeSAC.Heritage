//
//  MapPinViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/01/01.
//

import UIKit

class MapPinViewController: UIViewController {
    @IBOutlet weak var targetName: UILabel!
    @IBOutlet weak var targetLocation: UILabel!
    @IBOutlet weak var targetCount: UILabel!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var goTarget: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupAnnotationDetail()
    }
    
    func setupAnnotationDetail() {
        targetName.text = "타이틀이 들어갈곳"
        targetLocation.text = "위치가 들어갈곳"
        targetCount.text = "국보 0호"
        target.text = "뭘 넣을지 아직 모르겠음"
        goTarget.setTitle("자세히보기", for: .normal)
    }
    
    
    
}
