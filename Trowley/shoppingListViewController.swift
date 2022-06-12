//
//  shoppingListViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 12/06/22.
//

import UIKit

class shoppingListViewController: UIViewController {

    @IBOutlet weak var listTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        listTabBarItem.selectedImage = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
