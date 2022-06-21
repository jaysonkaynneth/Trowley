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
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var yourStocksLabel: UILabel!
    @IBOutlet weak var pantryTabBarItem: UITabBarItem!
    @IBOutlet weak var trowleyTurtleCircle: UIImageView!
    
    //add button (buat pindah ke modal)
    @IBOutlet weak var addModalBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodLabel.font = .rounded(ofSize: 22, weight: .regular)
        goodLabel.text = "Good Day,"
        
        trowleyLabel.font = .rounded(ofSize: 34, weight: .bold)
        trowleyLabel.text = "Trowleys!"
        
        tipsLabel.font = .rounded(ofSize: 22, weight: .bold)
        tipsLabel.text = "TIPS FROM ROWLEY🐢"
        
        yourStocksLabel.font = .rounded(ofSize: 22, weight: .bold)
        yourStocksLabel.text = "YOUR STOCKS"
        
        pantryTabBarItem.image = UIImage(named: "IconPantry")
        pantryTabBarItem.selectedImage = UIImage(named: "IconPantrySelected")
        pantryTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 5, bottom: -7, right: 0)
        
        trowleyTurtleCircle.image = UIImage(named: "TrowleyTurtle")
    }
    
    
    //segue pindah ke modal
    @IBAction func pressBtnAddModal(_ sender: Any) {
        performSegue(withIdentifier: "toAddModal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination as? PantryModalViewController
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

