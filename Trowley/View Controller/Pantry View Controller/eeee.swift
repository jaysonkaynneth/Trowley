//
//  PantryModalViewController.swift
//  Trowley
//
//  Created by Joshia Felim Efraim on 21/06/22.
//

import UIKit
import UserNotifications

class PantryModalViewController: UIViewController {
    
    //notification
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemAmountTF: UITextField!
    @IBOutlet weak var itemUnitTF: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var itemExpDatePicker: UIDatePicker!
    @IBOutlet weak var itemLocationPicker: UISegmentedControl!
    
    var date: String?
    var editItem : Food?
    var itemName: String = ""
    var itemAmount: Int = 0
    var itemUnit: String = ""
    var location: String = ""
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editItem != nil{
            itemNameTF.text = editItem?.name
            let tempAmount = editItem?.amount ?? 0
            itemAmountTF.text = String(tempAmount)
            itemUnitTF.text = editItem?.unit
            addBtn.setTitle("Edit", for: .normal)
        }
        
//        validator()
        checkForm()
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func checkForm()
        {
            if itemName != "" && itemAmount != 0 && itemUnit != ""
            {
                addBtn.isEnabled = true
            }
            
            else
            {
                addBtn.isEnabled = false
            }
        }
    
//    func validator() {
//        addBtn.isEnabled = false //hidden okButton
//        itemNameTF.addTarget(self, action: #selector(textFieldCheck),
//                                    for: .editingChanged)
//        itemAmountTF.addTarget(self, action: #selector(textFieldCheck),
//                                    for: .editingChanged)
//        itemUnitTF.addTarget(self, action: #selector(textFieldCheck),
//                                    for: .editingChanged)
//       }
//
//    @objc func textFieldCheck(sender: UITextField) {
//
//        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
//
//        guard
//          let itemName = itemNameTF.text, !itemName.isEmpty,
//          let itemAmount = itemAmountTF.text, !itemAmount.isEmpty,
//          let itemUnit = itemUnitTF.text, !itemUnit.isEmpty
//          else
//        {
//          self.addBtn.isEnabled = false
//          return
//        }
//        // enable okButton if all conditions are met
//        addBtn.isEnabled = true
//       }
    

    
    @IBAction func checkName(){
        itemName = itemNameTF.text ?? ""
        checkForm()
    }
    @IBAction func checkAmount(){
        itemAmount = Int(itemAmountTF.text!) ?? 0
        checkForm()
    }
    @IBAction func checkUnit(){
        itemUnit = itemUnitTF.text ?? ""
        checkForm()
    }

//    @IBAction func itemLocationPicker(_ sender: Any) {
//        switch itemLocationPicker.selectedSegmentIndex {
//        case 0:
//
//        case 1:
//
//        case 2:
//
//        default:
//            break;
//        }
//    }
    
    @IBAction func tapKeypad(_ sender: Any) {
            view.endEditing(true)
        }
    
    @IBAction func expDateSelect(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        date = datestyle.string(from: itemExpDatePicker.date)
    }
    
    func addToFridge() {
        
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if editItem != nil
        {
            editItem?.name = itemNameTF.text
            editItem?.amount = Int16(itemAmountTF.text!) ?? 0
            editItem?.unit = itemUnitTF.text
        }

        else
        {
            let datestyle = DateFormatter()
            datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
            datestyle.locale = NSLocale.current
            datestyle.dateFormat = "d MMM yyyy"
            let addItem = Food(context: self.context)
            addItem.name = itemNameTF.text
            addItem.expiry = date
            addItem.amount = Int16(itemAmountTF.text!) ?? 0
            addItem.unit = itemUnitTF.text
    //        addItem.location = itemLocationPicker
        }
        
        do
        {
            try context.save()
        }
        
        catch
        {
            let alert = UIAlertController(title: "Failed", message: "Please fill all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        }
        
        //notification------
        let notifDate = self.itemExpDatePicker.date
        let notifTitle = "Food is expiring today"
        let notifMessage = "\((itemNameTF.text) ?? "") is expiring today"
        let notifTitleSeminggu = "Food is expiring soon"
        let notifMessageSeminggu = "\((self.itemNameTF.text) ?? "" ) is expiring next week, use it soon! "
        
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async {
                if(settings.authorizationStatus == .authorized){
                    let content = UNMutableNotificationContent()
                    content.title = notifTitle
                    content.body = notifMessage
                    content.sound = UNNotificationSound.default
                    
                    
                    //notif hari H
                    var dateCompHariH = Calendar.current.dateComponents([.year, . month, . day,.hour, .minute], from: notifDate )
                    dateCompHariH.setValue(19, for: .hour)
                    dateCompHariH.setValue(58, for: .minute)
                    
                    let triggerHariH = UNCalendarNotificationTrigger(dateMatching: dateCompHariH, repeats: false)
                    let requestHariH = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerHariH)
                    
                    self.notificationCenter.add(requestHariH) { error in
                        if(error != nil){
                            print("Error" + error.debugDescription)
                            return
                        }
                    }
                    
                    //-----------------------
                    //notif -seminggu hari H
                    
                    let contentSeminggu = UNMutableNotificationContent()
                    contentSeminggu.title = notifTitleSeminggu
                    contentSeminggu.body = notifMessageSeminggu
                    contentSeminggu.sound = UNNotificationSound.default
                    
                    let tempDate = Calendar.current.date(byAdding: .day, value: -7, to: notifDate )
                    var dateCompSeminggu = Calendar.current.dateComponents([.year, . month , . day, .hour , .minute], from: tempDate!)
                    
                    dateCompSeminggu.setValue(19, for: .hour)
                    dateCompSeminggu.setValue(58, for: .minute)
                    
                    let triggerSeminggu = UNCalendarNotificationTrigger(dateMatching: dateCompSeminggu  , repeats: false)
                    let requestSeminggu = UNNotificationRequest(identifier: UUID().uuidString, content: contentSeminggu, trigger: triggerSeminggu)
                    
                    self.notificationCenter.add(requestSeminggu) { error in
                        if(error != nil){
                            print("Error" + error.debugDescription)
                            return
                        }
                    }
                    //                        let ac = UIAlertController(title: "Notification Scheduled", message: "At x", preferredStyle: .alert )
                    //                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                    //                        self.present(ac, animated: true)
                    
                }else{}
            }
        }
    }
}
