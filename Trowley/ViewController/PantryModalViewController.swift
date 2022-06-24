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
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var itemExpDatePicker: UIDatePicker!
    @IBOutlet weak var itemLocationPicker: UISegmentedControl!
    
    var date: String?
    var editItem : Food?
    var itemName: String = ""
    var itemAmount: Int = 0
    var itemUnit: String = ""
    var location: String = ""
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        if editItem != nil{
            itemNameTF.text = editItem?.name
            let tempAmount = editItem?.amount ?? 0
            itemAmountTF.text = String(tempAmount)
            itemUnitTF.text = editItem?.unit
            addBtn.setTitle("Edit", for: .normal)
        }
        
        validator()
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
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
    

    
 

    
    @IBAction func tapKeypad(_ sender: Any) {
            view.endEditing(true)
        }
    
    @IBAction func expDateSelect(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        date = datestyle.string(from: itemExpDatePicker.date)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if editItem != nil
        {
            editItem?.name = itemNameTF.text
            editItem?.amount = Int16(itemAmountTF.text!) ?? 0
            editItem?.unit = itemUnitTF.text
        }

        else
        {
            let datestyle = DateFormatter()
            datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
            datestyle.locale = NSLocale.current
            datestyle.dateFormat = "d MMM yyyy"
            let addItem = Food(context: self.context)
            addItem.name = itemNameTF.text
            addItem.expiry = date
            addItem.amount = Int16(itemAmountTF.text!) ?? 0
            addItem.unit = itemUnitTF.text
    //        addItem.location = itemLocationPicker
        }
        
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
