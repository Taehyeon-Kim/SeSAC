//
//  MyChatTableViewCell.swift
//  SeSAC2Chat
//
//  Created by jack on 2022/11/21.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var chatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        selectionStyle = .none
        
        profileView.backgroundColor = .systemYellow
        profileView.layer.cornerRadius = 8
        
        chatLabel.font = .systemFont(ofSize: 14)
        chatLabel.numberOfLines = 0
    }

   

}
