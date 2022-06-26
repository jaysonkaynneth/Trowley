//
//  CupboardViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 25/06/22.
//

import UIKit
 
class CupboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var data = [CupFood]()
    var date: String?
    var amount: Double?
    var unit: String?
    var index: Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //notif
    let notificationCenter = UNUserNotificationCenter.current()
    

    @IBOutlet weak var kitchenButt: UIButton!
    @IBOutlet weak var fridgeButt: UIButton!
    @IBOutlet weak var cupboardButt: UIButton!
    
    @IBOutlet weak var pantryTableView: UITableView!
    @IBOutlet weak var yourStocksLabel: UILabel!
    @IBOutlet weak var pantryTabBarItem: UITabBarItem!

//    @IBOutlet weak var addModalBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //notification permission---
        notificationCenter.requestAuthorization(options: [.sound, .alert]) { permisssionGranted, error in
            if (!permisssionGranted){
                print("permission denied")
            }
        }
        //-------

        pantryTableView.reloadData()
                
        kitchenButt.setImage(UIImage(named: "KitchenButton"), for: .normal)
        fridgeButt.setImage(UIImage(named: "FridgeButton"), for: .normal)
        cupboardButt.setImage(UIImage(named: "CupButtonPressed"), for: .normal)

        pantryTableView.delegate = self
        pantryTableView.dataSource = self
        
        yourStocksLabel.font = .rounded(ofSize: 32, weight: .bold)
        yourStocksLabel.text = "My Pantry"
        
        pantryTabBarItem.image = UIImage(named: "IconPantry")
        pantryTabBarItem.selectedImage = UIImage(named: "IconPantrySelected")

        fetchItem()
    }
    
    func fetchItem() {
        do {
            
            data = try context.fetch(CupFood.fetchRequest())
            DispatchQueue.main.async {
                            self.pantryTableView.reloadData()
                        }
                
            } catch {
                
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            updateView()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return data.count
        //return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "CupStockCell", for: indexPath) as? CupboardCell)!
        cell.selectionStyle = .none
        
        cell.itemName.text = data[indexPath.row].name
        
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        let currDate = datestyle.string(from: Date())
        let stringToDate = datestyle.date(from: data[indexPath.row].expiry ?? currDate)
        cell.itemExpDate.text = "expiry date: \(datestyle.string(from: stringToDate!))"
            
        let tempAmount = data[indexPath.row].amount
        let tempUnit = data[indexPath.row].unit
        cell.itemStock.text = "\(String(tempAmount)) \(tempUnit ?? "")"
    
        if Date() >= stringToDate ?? Date() {
            cell.backgroundColor = .init(red: 218/255, green: 85/255, blue: 82/255, alpha: 100)
        } else {
            cell.backgroundColor = .none
        }
        return cell
        
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? CupModalViewController {
            updateView()
        }
    }
    
    func updateView() {
        fetchItem()
        pantryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                      trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
       {
           
           let deleteItem = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
               
               DispatchQueue.main.async {
                   self.showDeleteWarning(for: indexPath)
               }
               
               success(true)
           })
           deleteItem.backgroundColor = .init(red: 192/255, green: 77/255, blue: 121/255, alpha: 100)
           
           
           let editAction = UIContextualAction(style: .normal, title: "Edit") {
               (action, view, completionHandler) in
               
               self.index = indexPath.row
               
               self.performSegue(withIdentifier: "toCupAddModal", sender: self)
           }
           editAction.backgroundColor = .init(red: 39/255, green: 82/255, blue: 72/255, alpha: 100)
           return UISwipeActionsConfiguration(actions: [deleteItem, editAction])
       }
    
    func showDeleteWarning(for indexPath: IndexPath) {
        let deleteAlert = UIAlertController(title: "Are you sure?", message: "This action cannot be undone", preferredStyle: UIAlertController.Style.alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            DispatchQueue.main.async {
                self.context.delete(self.data[indexPath.row])
                do {
                    try self.context.save()
                        
                    } catch {
                        
                    }
                self.data.remove(at: indexPath.row)
                self.pantryTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        })
        

        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(deleteAction)

        
        present(deleteAlert, animated: true, completion: nil)
    }
    
    
    //segue pindah ke modal
//    @IBAction func pressBtnAddModal(_ sender: Any) {
//        performSegue(withIdentifier: "toAddModal", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination as? PantryModalViewController
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCupAddModal"{
            let Foods = data[index ?? 0]

            let destinationVC = segue.destination as! CupModalViewController
            destinationVC.editItem = Foods
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        // Create a variable that you want to send
        if segue.identifier == "toCupAddModal"{
            let Foods = data[index ?? 0]

            let destinationVC = segue.destination as! CupModalViewController
            destinationVC.editItem = Foods
        }
        
    }
    @IBAction func addModalBtn() {
//        let addStockVC = storyboard?.instantiateViewController(identifier: "AddStockID") as! PantryModalViewController
//        addStockVC.modalPresentationStyle = .popover
//
//        let navigationController = UINavigationController(rootViewController: addStockVC)
//
//        present(navigationController, animated: true)
        
        performSegue(withIdentifier: "toCupModal", sender: nil)
    }

}
