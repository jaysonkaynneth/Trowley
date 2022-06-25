//
//  PantryModalViewController.swift
//  Trowley
//
//  Created by Joshia Felim Efraim on 21/06/22.
//

import UIKit
import UserNotifications

class PantryModalViewController: UIViewController {
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemAmountTF: UITextField!
    @IBOutlet weak var itemUnitTF: UITextField!
    @IBOutlet weak var itemExpDatePicker: UIDatePicker!
    @IBOutlet weak var itemLocationPicker: UISegmentedControl!
    
    var date: String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    //notif
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Item"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(dismissMe))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector(addbuttons))
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        itemNameTF.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        itemAmountTF.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        itemUnitTF.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
    }
    
    @objc func dismissMe() {
        self.dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if itemNameTF.text == "" || itemAmountTF.text == "" || itemUnitTF.text == "" {

            self.navigationItem.rightBarButtonItem?.isEnabled = false
           }else{

               self.navigationItem.rightBarButtonItem?.isEnabled = true
           }
       }
    
    @IBAction func expDateSelect(_ sender: Any) {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        date = datestyle.string(from: itemExpDatePicker.date)
    }

    
    @IBAction func pressCancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @objc func addbuttons() {
        let datestyle = DateFormatter()
        datestyle.timeZone = TimeZone(abbreviation: "GMT+7")
        datestyle.locale = NSLocale.current
        datestyle.dateFormat = "d MMM yyyy"
        let addItem = Food(context: self.context)
        addItem.name = itemNameTF.text
        addItem.expiry = date
//        addItem.amount = itemAmountTF
        addItem.unit = itemUnitTF.text
//        addItem.location = itemLocationPicker
        
        do {
            
                try context.save()
                
            } catch {
                
            }
        
        
        //notif
            let notifDate = self.itemExpDatePicker.date
            let notifTitle = "Food is expiring today"
            let notifMessage = "\((itemNameTF.text) ?? "" ) is expiring today"
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
                        dateCompHariH.setValue(0, for: .hour)
                        dateCompHariH.setValue(1, for: .minute)
                        
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
                        
                        dateCompSeminggu.setValue(0, for: .hour)
                        dateCompSeminggu.setValue(1, for: .minute)
                        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
