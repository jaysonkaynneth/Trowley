//
//  ViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 09/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var trowleyLabel: UILabel!
    @IBOutlet weak var pantryTabBarItem: UITabBarItem!
    @IBOutlet weak var trowleyTurtleCircle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodLabel.font = .rounded(ofSize: 22, weight: .regular)
        goodLabel.text = "Good Day,"
        
        trowleyLabel.font = .rounded(ofSize: 34, weight: .bold)
        trowleyLabel.text = "Trowleys!"
        
        pantryTabBarItem.image = UIImage(named: "PantryIcon")
        pantryTabBarItem.selectedImage = UIImage(named: "PantryIconSelected")
        
        trowleyTurtleCircle.image = UIImage(named: "TrowleyTurtle")
        
    }
    

}

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}

