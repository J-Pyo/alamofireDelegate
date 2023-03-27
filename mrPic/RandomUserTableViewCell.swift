//
//  RandomUserTableViewCell.swift
//  mrPic
//
//  Created by 홍정표 on 2023/03/26.
//

import UIKit
import SnapKit

class RandomUserTableViewCell: UITableViewCell {
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var imgView = UIImageView()
    var nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(cellView)
        
        cellView.addSubview(imgView)
        cellView.addSubview(nameLabel)
        
        
        cellView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
        }
        
        imgView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalTo(cellView).offset(20)
            make.centerY.equalTo(cellView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(imgView).offset(60)
            make.centerY.equalTo(cellView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
