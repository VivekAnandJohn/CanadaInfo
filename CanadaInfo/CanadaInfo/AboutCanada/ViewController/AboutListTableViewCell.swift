//
//  AboutListTableViewCell.swift
//  CanadaInfo
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class AboutListTableViewCell: UITableViewCell {
    //label for displaying Description
    @IBOutlet var lblDescription: UILabel!
    //image for displaying icon
    @IBOutlet var imgIcon: UIImageView!
    //label for displaying title
    @IBOutlet var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
