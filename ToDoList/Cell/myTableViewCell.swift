//
//  myTableViewCell.swift
//  ToDoList
//
//  Created by t2023-m0053 on 2023/08/30.
//

import UIKit

class myTableViewCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
