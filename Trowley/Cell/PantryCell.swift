//
//  PantryCell.swift
//  Trowley
//
//  Created by Jason Kenneth on 21/06/22.
//

import UIKit

class PantryCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemExpDate: UILabel!
    @IBOutlet weak var itemStock: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
