//
//  PantryModalViewController.swift
//  Trowley
//
//  Created by Joshia Felim Efraim on 21/06/22.
//

import UIKit

class PantryModalViewController: UIViewController {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemAmountTF: UITextField!
    @IBOutlet weak var itemUnitTF: UITextField!
    @IBOutlet weak var itemExpDatePicker: UIDatePicker!
    @IBOutlet weak var itemLocationPicker: UISegmentedControl!
    
    var date: String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Item"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(dismissMe))
        
        
        addBtn.isEnabled = false
        itemNameTF.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        itemAmountTF.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        itemUnitTF.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
    }
    
    @objc func dismissMe() {
        self.dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if itemNameTF.text == "" || itemAmountTF.text == "" || itemUnitTF.text == "" {

            addBtn.isEnabled = false
           }else{

               addBtn.isEnabled = true
           }
       }
    
    @IBAction func expDateSelect(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        date = datestyle.string(from: itemExpDatePicker.date)
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        let addItem = Food(context: self.context)
        addItem.name = itemNameTF.text
        addItem.expiry = date
//        addItem.amount = itemAmountTF
        addItem.unit = itemUnitTF.text
//        addItem.location = itemLocationPicker
        
        do {
            
                try context.save()
                
            } catch {
                
            }
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
