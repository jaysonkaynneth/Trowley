//
//  shoppingListViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 12/06/22.
//

import UIKit

class shoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //segue pindah ke modal
    @IBAction func addModalBtn(_ sender: Any) {
        performSegue(withIdentifier: "toShoplistModal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination as? ShoplistModalViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        
        if tableView == listTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ShoppingListCell
            cell?.listName.text = "Nama Barang"
            cell?.listQuantity.text = "Qty"
            cellToReturn = cell!
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

    @IBOutlet weak var listTabBarItem: UITabBarItem!
    @IBOutlet weak var shopListLabel: UILabel!
    @IBOutlet weak var shopHistoryLabel: UILabel!
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var historyTable: UITableView!
    
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

        shopHistoryLabel.font = .rounded(ofSize: 22, weight: .bold)
        shopHistoryLabel.text = "MY SHOPPING HISTORY"
    

    

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
