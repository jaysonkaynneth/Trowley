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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ShoppinglListcell
        cell?.listName.text = "Nama Barang"
        cell?.listQuantity.text = "Qty"
        return cell ?? UITableViewCell()
    }

    @IBOutlet weak var listTabBarItem: UITabBarItem!
    @IBOutlet weak var shopListLabel: UILabel!
    @IBOutlet weak var shopHistoryLabel: UILabel!
    @IBOutlet weak var listTable: UITableView!
    
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
        self.listTable.register(UINib(nibName: "ShoppinglListcell", bundle: nil), forCellReuseIdentifier: "listCell")
    

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
