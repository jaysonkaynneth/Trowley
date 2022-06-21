//
//  PantryModalViewController.swift
//  Trowley
//
//  Created by Joshia Felim Efraim on 21/06/22.
//

import UIKit

class PantryModalViewController: UIViewController {
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemAmountTF: UITextField!
    @IBOutlet weak var itemUnitTF: UITextField!
    @IBOutlet weak var itemExpDatePicker: UIDatePicker!
    @IBOutlet weak var itemLocationPicker: UISegmentedControl!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressCancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
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
