//
//  ViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 09/06/22.
//

import UIKit
import UserNotifications
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var dummyfridge = [Food]()
    var dummycup = [Food]()
    var data = [Food]()
    var foods: [Food]?
    //    var data = [Food]()
    var date: String?
    var amount: Double?
    var unit: String?
    var index: Int?
    var selectedIndex = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //notif
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    @IBOutlet weak var kitchenButt: UIButton!
    @IBOutlet weak var fridgeButt: UIButton!
    @IBOutlet weak var cupboardButt: UIButton!
    @IBOutlet weak var pantryEmpty: UIImageView!
    @IBOutlet weak var pantryTableView: UITableView!
    @IBOutlet weak var yourStocksLabel: UILabel!
    @IBOutlet weak var pantryTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //notification permission---
        notificationCenter.requestAuthorization(options: [.sound, .alert]) { permisssionGranted, error in
            if (!permisssionGranted){
                print("permission denied")
            }
        }
        //-------
        definesPresentationContext = true
        pantryTableView.reloadData()
        
        kitchenButt.setImage(UIImage(named: "KitchenButton"), for: .normal)
        kitchenButt.setImage(UIImage(named: "KitchenButtonPressed"), for: .selected)
        
        fridgeButt.setImage(UIImage(named: "FridgeButton"), for: .normal)
        fridgeButt.setImage(UIImage(named: "FridgeButtonPressed"), for: .selected)
        
        cupboardButt.setImage(UIImage(named: "CupButton"), for: .normal)
        cupboardButt.setImage(UIImage(named: "CupButtonPressed"), for: .selected)
        
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
            //            data = data.map { $0.value }
            //            data = data.map {
            //                StructFood.init(record: $0)
            //            }
            //            data = try context.fetch(Food.fetchRequest())
//            let request = Food.fetchRequest() as NSFetchRequest<Food>
//            let pred = NSPredicate(format: "location = 0")
//            request.predicate = pred
            data = try context.fetch(Food.fetchRequest())
            DispatchQueue.main.async {
                self.pantryTableView.reloadData()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFridgeItem() {
        do {
            //            data = data.map { $0.value }
            //            data = data.map {
            //                StructFood.init(record: $0)
            //            }
            //            data = try context.fetch(Food.fetchRequest())
            let request = Food.fetchRequest() as NSFetchRequest<Food>
            let pred = NSPredicate(format: "location = 1")
            request.predicate = pred
            self.foods = try context.fetch(Food.fetchRequest())
            DispatchQueue.main.async {
                self.pantryTableView.reloadData()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCupItem() {
        do {
            //            data = data.map { $0.value }
            //            data = data.map {
            //                StructFood.init(record: $0)
            //            }
            //            data = try context.fetch(Food.fetchRequest())
            let request = Food.fetchRequest() as NSFetchRequest<Food>
            let pred = NSPredicate(format: "location = 2")
            request.predicate = pred
            self.foods = try context.fetch(Food.fetchRequest())
            DispatchQueue.main.async {
                self.pantryTableView.reloadData()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //    let filter = "location"
    //    let predicate = NSPredicate(format: "location = %@", filter)
    //    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Food")
    //    fetchRequest.predicate = predicate
    //
    //    do{
    //        let fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
    //        print("Fetch results")
    //        if  let task = fetchedResults.first as? TodoListItem{
    //            print(task)
    //        }
    //    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return countObjectbasedOnIndex().count
//        return self.foods?.count ?? 0
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? PantryCell)!
        cell.selectionStyle = .none
        
//        cell.itemName.text = self.foods![indexPath.row].name
        cell.itemName.text = data[indexPath.row].name
        
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        let currDate = datestyle.string(from: Date())
//        let stringToDate = datestyle.date(from: self.foods![indexPath.row].expiry ?? currDate)
        let stringToDate = datestyle.date(from: data[indexPath.row].expiry ?? currDate)
        cell.itemExpDate.text = "Expired by: \(datestyle.string(from: stringToDate!))"
        
        let tempAmount = data[indexPath.row].amount
        let tempUnit = data[indexPath.row].unit
//        let tempAmount = self.foods![indexPath.row].amount
//        let tempUnit = self.foods![indexPath.row].unit
        cell.itemStock.text = "\(String(tempAmount)) \(tempUnit ?? "")"
        
        if Date() >= stringToDate ?? Date() {
            cell.backgroundColor = .init(red: 218/255, green: 85/255, blue: 82/255, alpha: 100)
        } else {
            cell.backgroundColor = .none
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == 0 {
            if data[indexPath.row].location != 0 {
                return 0
            }
        }
        
        if selectedIndex == 1 {
            if data[indexPath.row].location != 1 {
                return 0
            }
        }
        
        if selectedIndex == 2 {
            if data[indexPath.row].location != 2 {
                return 0
            }
        }
        return 44
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? PantryModalViewController {
            updateView()
        }
    }
    
    func updateView() {
        fetchItem()
        pantryTableView.reloadData()
        if data.count != 0{
            pantryEmpty.alpha = 0
        } else {
            pantryEmpty.alpha = 100
        }
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
        deleteItem.image = UIImage(systemName: "trash")
        deleteItem.backgroundColor = .init(red: 197/255, green: 69/255, blue: 69/255, alpha: 100)
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            
            self.index = indexPath.row
            
            self.performSegue(withIdentifier: "toAddModal", sender: self)
        }
        editAction.image = UIImage(systemName: "square.and.pencil")
        editAction.backgroundColor = .init(red: 53/255, green: 113/255, blue: 98/255, alpha: 100)
        return UISwipeActionsConfiguration(actions: [deleteItem, editAction])
    }
    
    func showDeleteWarning(for indexPath: IndexPath) {
        let deleteAlert = UIAlertController(title: "Delete Item", message: "This action cannot be undone.", preferredStyle: UIAlertController.Style.alert)
        
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            DispatchQueue.main.async {
//                self.context.delete(self.foods![indexPath.row])
                self.context.delete(self.data[indexPath.row])
                do {
                    try self.context.save()
                } catch {
                    
                }
                self.data.remove(at: indexPath.row)
//                self.foods!.remove(at: indexPath.row)
                self.pantryTableView.deleteRows(at: [indexPath], with: .fade)
                self.updateView()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        })
        
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        
        
        
        present(deleteAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddModal"{
//            let Food = foods![index ?? 0]
            let Food = data[index ?? 0]
            
            let destinationVC = segue.destination as! PantryModalViewController
            destinationVC.editItem = Food
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a variable that you want to send
        if segue.identifier == "toAddModal"{
//            let Food = foods![index ?? 0]
            let Food = data[index ?? 0]
            
            let destinationVC = segue.destination as! PantryModalViewController
            destinationVC.editItem = Food
        }
        
    }
    
    @IBAction func kitchenButt(_ sender: Any) {
        kitchenButt.isSelected = !kitchenButt.isSelected
        kitchenButt.isSelected = true
        fridgeButt.isSelected = false
        cupboardButt.isSelected = false
        selectedIndex = 0
        fetchItem()
        pantryTableView.reloadData()
    }
    
    @IBAction func fridgeButt(_ sender: Any) {
        fridgeButt.isSelected = !fridgeButt.isSelected
        kitchenButt.isSelected = false
        fridgeButt.isSelected = true
        cupboardButt.isSelected = false
        selectedIndex = 1
//        data = dummyfridge
//        fetchFridgeItem()
        fetchItem()
        pantryTableView.reloadData()
    }
    
    @IBAction func cupButt(_ sender: Any) {
        cupboardButt.isSelected = !cupboardButt.isSelected
        kitchenButt.isSelected = false
        fridgeButt.isSelected = false
        cupboardButt.isSelected = true
        selectedIndex = 2
//        data = dummycup
//        fetchCupItem()
        fetchItem()
        pantryTableView.reloadData()
    }
    
    
    @IBAction func addModalBtn() {
        
        performSegue(withIdentifier: "toPantryModal", sender: nil)
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

