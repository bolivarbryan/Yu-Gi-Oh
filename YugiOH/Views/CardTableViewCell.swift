//
//  CardTableViewCell.swift
//  YugiOH
//
//  Created by Bryan A Bolivar M on 11/26/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
