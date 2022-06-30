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
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    // MARK: - Outlet and variables
    @IBOutlet weak var listTabBarItem: UITabBarItem!
    @IBOutlet weak var shopListLabel: UILabel!
    @IBOutlet weak var shopHistoryLabel: UILabel!
    @IBOutlet weak var toBuy: UILabel!
    @IBOutlet weak var itemsBought: UILabel!
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var historyTable: UITableView!
    @IBOutlet weak var emptyShoplist: UIImageView!
    @IBOutlet weak var emptyCart: UIImageView!
    
    var data = [ItemList]()
    var name: String?
    var amount: Int?
    var unit: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var index: Int?
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? ShoplistModalViewController {
            updateView()
        }
    }
    // MARK: - Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        listTabBarItem.selectedImage = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        
        shopListLabel.font = .rounded(ofSize: 32, weight: .bold)
        shopListLabel.text = "To Shop"
        
        
        shopHistoryLabel.font = .rounded(ofSize: 32, weight: .bold)
        shopHistoryLabel.text = "Cart"
        
        toBuy.font = .rounded(ofSize: 16, weight: .light)
        toBuy.text = "Items to buy"
        
        itemsBought.font = .rounded(ofSize: 16, weight: .light)
        itemsBought.text = "Items bought"
        
        listTable.delegate = self
        listTable.dataSource = self
        self.listTable.register(UINib(nibName: "ShoppingListCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        historyTable.delegate = self
        historyTable.dataSource = self
        self.historyTable.register(UINib(nibName: "ShoppingListCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        updateView()
    }
    
    //segue pindah ke modal
    @IBAction func addModalBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toShoplistModal", sender: nil)
    }
    @IBAction func refreshButt(_ sender: UIButton) {
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddModal"{
            let Foods = data[index ?? 0]
            
            let destinationVC = segue.destination as! ShoplistModalViewController
            destinationVC.editItem = Foods
        }
        
        if segue.identifier == "toPantryModal"{
            let Foods = data[index ?? 0]
            
            let destinationVC = segue.destination as! PantryModalViewController
            destinationVC.storeItem = Foods
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    // MARK: - Did select row at
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        data[indexPath.row].isBought.toggle()
        
        do {
            try context.save()
            updateView()
        }
        catch {
            
        }
    }
    // MARK: - Cell for row at
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
        return cellToReturn
    }
    // MARK: - Height for row at
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == listTable{
            if data[indexPath.row].isBought == true {
                return 0
            }
        }
        else if tableView == historyTable{
            if data[indexPath.row].isBought == false {
                return 0
            }
        }
        
        return 44
    }
    // MARK: - Prepare for segue
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a variable that you want to send
        if segue.identifier == "AddModal"{
            let Foods = data[index ?? 0]
            
            let destinationVC = segue.destination as! ShoplistModalViewController
            destinationVC.editItem = Foods
        }
        
        if segue.identifier == "toPantryModal"{
            let Foods = data[index ?? 0]
            
            let destinationVC = segue.destination as! PantryModalViewController
            destinationVC.storeItem = Foods
        }
        
    }
    // MARK: - Cell Swipe Actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == listTable{
            
            let editAction = UIContextualAction(style: .normal, title: "Edit") {
                (action, view, completionHandler) in
                
                self.index = indexPath.row
                
                self.performSegue(withIdentifier: "AddModal", sender: self)
            }
            editAction.image = UIImage(systemName: "square.and.pencil")
            editAction.backgroundColor = .init(red: 53/255, green: 113/255, blue: 98/255, alpha: 100)
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                
                let alert = UIAlertController(title: "Delete Item", message: "This action cannot be undone.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    
                    let deleteObject = self.data[indexPath.row]
                    self.context.delete(deleteObject)
                    
                    do
                    {
                        try self.context.save()
                        self.updateView()
                    }
                    
                    catch{}
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                
                self.present(alert, animated: true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .init(red: 197/255, green: 69/255, blue: 69/255, alpha: 100)
            
            return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            
        }
        
        if tableView == historyTable{
            
            let stashAction = UIContextualAction(style: .normal, title: "Stash") {
                (action, view, completionHandler) in
                
                self.index = indexPath.row
                self.performSegue(withIdentifier: "toPantryModal", sender: self)
                let deleteObject = self.data[indexPath.row]
                self.context.delete(deleteObject)
                
            }
            stashAction.image = UIImage(systemName: "archivebox")
            stashAction.backgroundColor = .init(red: 162/255, green: 170/255, blue: 173/255, alpha: 100)
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                
                let alert = UIAlertController(title: "Delete Item", message: "This action cannot be undone.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    
                    let deleteObject = self.data[indexPath.row]
                    self.context.delete(deleteObject)
                    
                    do
                    {
                        try self.context.save()
                        self.updateView()
                    }
                    
                    catch{}
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                
                self.present(alert, animated: true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .init(red: 197/255, green: 69/255, blue: 69/255, alpha: 100)
            
            return UISwipeActionsConfiguration(actions: [deleteAction, stashAction])
            
            
        }
        return UISwipeActionsConfiguration(actions: [])
    }
    // MARK: - Fetch Item
    func fetchItem() {
        do {
            data = try context.fetch(ItemList.fetchRequest())
            DispatchQueue.main.async {
                self.listTable.reloadData()
                self.historyTable.reloadData()
            }
        }
        catch {}
        
    }
    // MARK: - Update View
    func updateView() {
        fetchItem()
        listTable.reloadData()
        historyTable.reloadData()
        if data.count != 0 {
            emptyShoplist.alpha = 0
            emptyCart.alpha = 0
        }
        else {
            emptyShoplist.alpha = 100
            emptyCart.alpha = 100
        }
    }
    
}
