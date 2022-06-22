//
//  ShoppinglListcell.swift
//  Trowley
//
//  Created by Ganesh Ekatata Buana on 17/06/22.
//

import UIKit

class ShoppingListCell: UITableViewCell {

    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listQuantity: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
