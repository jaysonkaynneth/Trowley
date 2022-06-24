//
//  ViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 09/06/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [Food]()
    var date: String?
    var amount: Double?
    var unit: String?
    var index: Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    

    @IBOutlet weak var kitchenButt: UIButton!
    @IBOutlet weak var fridgeButt: UIButton!
    @IBOutlet weak var cupboardButt: UIButton!
    
    @IBOutlet weak var pantryTableView: UITableView!
    @IBOutlet weak var yourStocksLabel: UILabel!
    @IBOutlet weak var pantryTabBarItem: UITabBarItem!
//    @IBOutlet weak var trowleyTurtleCircle: UIImageView!
//    @IBOutlet weak var goodLabel: UILabel!
//    @IBOutlet weak var trowleyLabel: UILabel!
//    @IBOutlet weak var tipsLabel: UILabel!
    
    //add button (buat pindah ke modal)
//    @IBOutlet weak var addModalBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pantryTableView.reloadData()
//        goodLabel.font = .rounded(ofSize: 22, weight: .regular)
//        goodLabel.text = "Good Day,"
//
//        trowleyLabel.font = .rounded(ofSize: 34, weight: .bold)
//        trowleyLabel.text = "Trowleys!"
//
//        tipsLabel.font = .rounded(ofSize: 22, weight: .bold)
//        tipsLabel.text = "TIPS FROM ROWLEY🐢"
//
//        yourStocksLabel.font = .rounded(ofSize: 22, weight: .bold)
//        yourStocksLabel.text = "YOUR STOCKS"
//        trowleyTurtleCircle.image = UIImage(named: "TrowleyTurtle")
                
        kitchenButt.setTitle("Kitchen", for: .normal)
        
        fridgeButt.setTitle("Fridge", for: .normal)
        
        cupboardButt.setTitle("Cupboard", for: .normal)

        
        
        
        pantryTableView.delegate = self
        pantryTableView.dataSource = self
        
        yourStocksLabel.font = .rounded(ofSize: 32, weight: .bold)
        yourStocksLabel.text = "My Pantry"
        
        pantryTabBarItem.image = UIImage(named: "IconPantry")
        pantryTabBarItem.selectedImage = UIImage(named: "IconPantrySelected")
//        pantryTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

        fetchItem()
    }
    
    func fetchItem() {
        do {
            
            data = try context.fetch(Food.fetchRequest())
            DispatchQueue.main.async {
                            self.pantryTableView.reloadData()
                        }
                
            } catch {
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return data.count
        //return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? PantryCell)!
        cell.selectionStyle = .none
        cell.itemName.text = data[indexPath.row].name
        
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        let currDate = datestyle.string(from: Date())
        let stringToDate = datestyle.date(from: data[indexPath.row].expiry ?? currDate)
        
        let tempAmount = data[indexPath.row].amount
        let tempUnit = data[indexPath.row].unit
        cell.itemStock.text = "\(String(tempAmount)) \(tempUnit ?? "")"
    
        cell.itemExpDate.text = "expiry date: \(datestyle.string(from: stringToDate!))"
    
        if Date() >= stringToDate ?? Date() {
            cell.backgroundColor = .init(red: 218/255, green: 85/255, blue: 82/255, alpha: 100)
        } else {
            cell.backgroundColor = .none
        }

        return cell
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? PantryModalViewController {
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
           let editAction = UIContextualAction(style: .normal, title: "Edit") {
               (action, view, completionHandler) in
               
               self.index = indexPath.row
               
               self.performSegue(withIdentifier: "toAddModal", sender: self)
           }
           
           let deleteItem = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
               
               DispatchQueue.main.async {
                   self.showDeleteWarning(for: indexPath)
               }
               
               success(true)
           })
           deleteItem.backgroundColor = .init(red: 218/255, green: 85/255, blue: 82/255, alpha: 100)
           return UISwipeActionsConfiguration(actions: [editAction, deleteItem])
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
        
        if segue.identifier == "toAddModal"{
            let Foods = data[index ?? 0]

            let destinationVC = segue.destination as! PantryModalViewController
            destinationVC.editItem = Foods
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        // Create a variable that you want to send
        if segue.identifier == "toAddModal"{
            let Foods = data[index ?? 0]

            let destinationVC = segue.destination as! PantryModalViewController
            destinationVC.editItem = Foods
        }
        
    }
    @IBAction func addModalBtn() {
        let addStockVC = storyboard?.instantiateViewController(identifier: "AddStockID") as! PantryModalViewController
        addStockVC.modalPresentationStyle = .popover

        let navigationController = UINavigationController(rootViewController: addStockVC)
        
        present(navigationController, animated: true)
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


