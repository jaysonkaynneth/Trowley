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
    var name: String = ""
    var amount: Int = 0
    var unit: String = ""
    var location: String = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Item"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(dismissMe))
        
        validator()
        
    }
    
    func validator() {
        addBtn.isEnabled = false //hidden okButton
        itemNameTF.addTarget(self, action: #selector(textFieldCheck),
                                    for: .editingChanged)
        itemAmountTF.addTarget(self, action: #selector(textFieldCheck),
                                    for: .editingChanged)
        itemUnitTF.addTarget(self, action: #selector(textFieldCheck),
                                    for: .editingChanged)
       }
    
    @objc func textFieldCheck(sender: UITextField) {

        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)

        guard
          let itemName = itemNameTF.text, !itemName.isEmpty,
          let itemAmount = itemAmountTF.text, !itemAmount.isEmpty,
          let itemUnit = itemUnitTF.text, !itemUnit.isEmpty
          else
        {
          self.addBtn.isEnabled = false
          return
        }
        // enable okButton if all conditions are met
        addBtn.isEnabled = true
       }
    

    
 
    @objc func dismissMe() {
        self.dismiss(animated: true)
    }

    
    @IBAction func expDateSelect(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        date = datestyle.string(from: itemExpDatePicker.date)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        let addItem = Food(context: self.context)
        addItem.name = itemNameTF.text
        addItem.expiry = date
        addItem.amount = Int16(amount)
        addItem.unit = itemUnitTF.text
//        addItem.location = itemLocationPicker
        
        do
        {
            try context.save()
        }
        
        catch
        {
            let alert = UIAlertController(title: "Failed", message: "Please fill all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        }
    }
}
