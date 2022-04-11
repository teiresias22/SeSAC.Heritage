import UIKit
import SwiftUI

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"
    
    let contentViewCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.customGray?.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .customWhite
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.textColor = .customBlack
        label.font = .MapoFlowerIsland16
        label.numberOfLines = 0
        
        return label
    }()
    
    let stockView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .fill
        view.distribution = .fillEqually
        
        return view
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.textColor = .customBlack
        label.font = .MapoFlowerIsland14
        
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "".localized()
        label.textColor = .customBlack
        label.font = .MapoFlowerIsland14
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() {
        addSubview(contentViewCell)
        contentViewCell.addSubview(titleLabel)
        contentViewCell.addSubview(stockView)
        stockView.addArrangedSubview(cityLabel)
        stockView.addArrangedSubview(locationLabel)
    }
    
    func setConstraints() {
        contentViewCell.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(stockView.snp.leading).inset(-8)
        }
        
        stockView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(16)
            make.width.equalTo(80)
        }
        
    }

}
