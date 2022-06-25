//
//  shoppingListViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 12/06/22.
//

import UIKit


class shoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    //segue pindah ke modal
    @IBAction func addModalBtn(_ sender: Any) {
        performSegue(withIdentifier: "toShoplistModal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddModal"{
            let Foods = data[index ?? 0]

            let destinationVC = segue.destination as! ShoplistModalViewController
            destinationVC.editItem = Foods
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == listTable{
            data[indexPath.row].isBought.toggle()
            
            do {
                try context.save()
                tableView.reloadData()
            }
            catch {
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cellToReturn = UITableViewCell()
        
        if tableView == listTable{
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ShoppingListCell)!
            
            cell.listName.text = data[indexPath.row].name
            let tempAmount = data[indexPath.row].amount
            let tempUnit = data[indexPath.row].unit
            cell.listQuantity.text = "\(String(tempAmount)) \(tempUnit ?? "")"
            
            if data[indexPath.row].isBought == true{
                cell.checkImage.tintColor = UIColor.systemGreen
            }
            else{
                cell.checkImage.tintColor = UIColor.lightGray
            }
            
            cellToReturn = cell

            return cellToReturn
            }
        
        else if tableView == historyTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? ShoppingHistoryCell
            cell?.listDate.text = "DD/MM/YYYY"
            cell?.listStatus.text = "Completed"
            cellToReturn = cell!
            return cellToReturn
            }
        
        return cellToReturn
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        // Create a variable that you want to send
        if segue.identifier == "AddModal"{
            let Foods = data[index ?? 0]

            let destinationVC = segue.destination as! ShoplistModalViewController
            destinationVC.editItem = Foods
        }
        
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            
            self.index = indexPath.row
            
            self.performSegue(withIdentifier: "AddModal", sender: self)
        }
        
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let alert = UIAlertController(title: "Item Deletion", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                
                let deleteObject = self.data[indexPath.row]
                self.context.delete(deleteObject)
    
                do
                {
                    try self.context.save()
                    self.updateView()
                }
                
                catch
                {
                    
                }
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    @IBOutlet weak var listTabBarItem: UITabBarItem!
    @IBOutlet weak var shopListLabel: UILabel!
    @IBOutlet weak var shopHistoryLabel: UILabel!
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var historyTable: UITableView!
    
    var data = [Food]()
    var name: String?
    var amount: Int?
    var unit: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var index: Int?
    
    func fetchItem() {
        do {
            
            data = try context.fetch(Food.fetchRequest())
            DispatchQueue.main.async {
                self.listTable.reloadData()
                        }
                
            } catch {
                
        }
    }
    
    func updateView() {
        fetchItem()
        listTable.reloadData()
        historyTable.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        listTabBarItem.selectedImage = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        
        shopListLabel.font = .rounded(ofSize: 32, weight: .bold)
        shopListLabel.text = "List"
        

        shopHistoryLabel.font = .rounded(ofSize: 32, weight: .bold)
        shopHistoryLabel.text = "History"
        
        listTable.delegate = self
        listTable.dataSource = self
        self.listTable.register(UINib(nibName: "ShoppingListCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        historyTable.delegate = self
        historyTable.dataSource = self
        self.historyTable.register(UINib(nibName: "ShoppingHistoryCell", bundle: nil), forCellReuseIdentifier: "historyCell")
    
        updateView()
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
