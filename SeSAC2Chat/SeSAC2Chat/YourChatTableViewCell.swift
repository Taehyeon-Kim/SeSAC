//
//  YourChatTableViewCell.swift
//  SeSAC2Chat
//
//  Created by jack on 2022/11/21.
//

import UIKit

class YourChatTableViewCell: UITableViewCell {

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var chatLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        profileNameLabel.font = .systemFont(ofSize: 14)
        profileView.backgroundColor = .systemGray
        profileView.layer.cornerRadius = 8
        profileView.contentMode = .scaleToFill
        chatLabel.font = .systemFont(ofSize: 14)
        chatLabel.numberOfLines = 0
    }

}
