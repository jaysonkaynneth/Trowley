//
//  ShoppingHistoryCell.swift
//  Trowley
//
//  Created by Ganesh Ekatata Buana on 19/06/22.
//

import UIKit

class ShoppingHistoryCell: UITableViewCell {

    @IBOutlet weak var listDate: UILabel!
    @IBOutlet weak var listStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
