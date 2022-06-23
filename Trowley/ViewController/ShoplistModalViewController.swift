//
//  ShoplistModalViewController.swift
//  Trowley
//
//  Created by Joshia Felim Efraim on 21/06/22.
//

import UIKit

class ShoplistModalViewController: UIViewController {
    
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
    
    var editItem : Food?
    var name: String = ""
    var amount: Int = 0
    var unit: String = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func pressCancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
      
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
    
    @IBAction func tapAddButton()
        {
            
            if editItem != nil
            {
                editItem?.name = name
                editItem?.amount = Int16(amount)
                editItem?.unit = unit
                editItem?.isBought = false
            }

            else
            {
            name = itemNameTF.text ?? ""
            amount = Int(itemAmountTF.text!) ?? 0
            unit = itemUnitTF.text ?? ""
            
            let newFood = Food(context: context)
                newFood.name = name
                newFood.amount = Int16(amount)
                newFood.unit = unit 
                newFood.isBought = false
    
            }
          
            do
            {
                try context.save()
                let alert = UIAlertController(title: "Success", message: "Succesfully added item!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                present(alert, animated: true)
            }
            
            catch
            {
                let alert = UIAlertController(title: "Fail", message: "Please fill all fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                present(alert, animated: true)
            }
            
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
