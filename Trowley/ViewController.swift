//
//  ViewController.swift
//  Trowley
//
//  Created by Jason Kenneth on 09/06/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    //    return data.count
        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? PantryCell)!
        cell.selectionStyle = .none
    //    cell.itemName.text = data[indexPath.row].name
        
    //    let datestyle = DateFormatter()
    //    datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
    //    datestyle.locale = NSLocale.current
    //    datestyle.dateFormat = "d MMM yyyy"
    //    let currDate = datestyle.string(from: Date())
    //    let stringToDate = datestyle.date(from: data[indexPath.row].expiry_date ?? currDate)
    //
    //    cell.expiryDate.text = datestyle.string(from: stringToDate!)
    //
    //    if Date() >= stringToDate ?? Date() {
    //        cell.backgroundColor = .init(red: 218/255, green: 85/255, blue: 82/255, alpha: 100)
    //    } else {
    //        cell.backgroundColor = .none
    //    }

        return cell
        
    }
    
    @IBOutlet weak var pantryTableView: UITableView!
//    @IBOutlet weak var goodLabel: UILabel!
//    @IBOutlet weak var trowleyLabel: UILabel!
//    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var yourStocksLabel: UILabel!
    @IBOutlet weak var pantryTabBarItem: UITabBarItem!
//    @IBOutlet weak var trowleyTurtleCircle: UIImageView!
    
    //add button (buat pindah ke modal)
    @IBOutlet weak var addModalBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
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
        
        pantryTableView.delegate = self
        pantryTableView.dataSource = self
        
        pantryTabBarItem.image = UIImage(named: "IconPantry")
        pantryTabBarItem.selectedImage = UIImage(named: "IconPantrySelected")
        pantryTabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 5, bottom: -7, right: 0)
        
//        trowleyTurtleCircle.image = UIImage(named: "TrowleyTurtle")
    }
    
    
    //segue pindah ke modal
    @IBAction func pressBtnAddModal(_ sender: Any) {
        performSegue(withIdentifier: "toAddModal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination as? PantryModalViewController
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

