//
//  ShoplistModalViewController.swift
//  Trowley
//
//  Created by Joshia Felim Efraim on 21/06/22.
//

import UIKit

class ShoplistModalViewController: UIViewController {
    // MARK: - Outlet and variables
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemAmountTF: UITextField!
    @IBOutlet weak var itemUnitTF: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func checkName(){
        name = itemNameTF.text ?? ""
        checkForm()
    }
    @IBAction func checkAmount(){
        amount = Int(itemAmountTF.text!) ?? 0
        checkForm()
    }
    @IBAction func checkUnit(){
        unit = itemUnitTF.text ?? ""
        checkForm()
    }
    
    @IBAction func tapKeypad(_ sender: Any) {
        view.endEditing(true)
    }
    
    var editItem : ItemList?
    var name: String = ""
    var amount: Int = 0
    var unit: String = ""
    var data = [Food]()
    var foodName = [String]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // MARK: - Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItem()
        fetchName()
        
        if editItem != nil{
            itemNameTF.text = editItem?.name
            let tempAmount = editItem?.amount ?? 0
            itemAmountTF.text = String(tempAmount)
            itemUnitTF.text = editItem?.unit
            addButton.setTitle("Edit", for: .normal)
            
            name = itemNameTF.text ?? ""
            amount = Int(itemAmountTF.text!) ?? 0
            unit = itemUnitTF.text ?? ""
        }
        checkForm()
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Fetch item and name
    func fetchItem() {
        do {
            data = try context.fetch(Food.fetchRequest())
        }
        catch {
            print("Fail to fetch item")
        }
        print(data)
        
    }
    
    func fetchName() {
        if data.count == 0 {
        }
        else{
            let tempCount = data.count - 1
            for i in 0...tempCount {
                foodName.append(data[i].name ?? "Name")
            }
        }
    }
    // MARK: - Check form
    func checkForm()
    {
        if name != "" && amount != 0 && unit != ""
        {
            addButton.isEnabled = true
        }
        
        else
        {
            addButton.isEnabled = false
        }
    }
    // MARK: - Cancel and add buttons
    @IBAction func pressCancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    
    @IBAction func tapAddButton()
    {
        let newFood = ItemList(context: context)
        if editItem != nil
        {
            editItem?.name = name
            editItem?.amount = Int16(amount)
            editItem?.unit = unit
            let deleteObject = newFood
            self.context.delete(deleteObject)
        }
        
        else
        {
            name = itemNameTF.text ?? ""
            amount = Int(itemAmountTF.text!) ?? 0
            unit = itemUnitTF.text ?? ""
            
            newFood.name = name
            newFood.amount = Int16(amount)
            newFood.unit = unit
            newFood.isBought = false
            
        }
        
        if foodName.count == 0 {
        }
        else{
            let tempCount = foodName.count - 1
            for i in 0...tempCount{
                if name.lowercased() == foodName[i].lowercased(){
                    let alert = UIAlertController(title: "Duplicate Item", message: "You already have this item in your pantry. Are you sure to add item?", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self]  _ in
                        alert.dismiss(animated: true)
                        
                        if editItem != nil
                        {
                            editItem?.name = name
                            editItem?.amount = Int16(amount)
                            editItem?.unit = unit
                            let deleteObject = newFood
                            self.context.delete(deleteObject)
                        }
                        
                        else
                        {
                            name = itemNameTF.text ?? ""
                            amount = Int(itemAmountTF.text!) ?? 0
                            unit = itemUnitTF.text ?? ""
                            
                            newFood.name = name
                            newFood.amount = Int16(amount)
                            newFood.unit = unit
                            newFood.isBought = false
                        }
                        
                        self.dismiss(animated: true)
                    }))
                    
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                        let deleteObject = newFood
                        self.context.delete(deleteObject)
                        alert.dismiss(animated: true)
                    }))
                    
                    self.present(alert, animated: true)
                }
            }
        }
        
        do
        {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Succesfully added item!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
        
        catch
        {
            let alert = UIAlertController(title: "Fail", message: "Failed to save item.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
        
    }
    
}
