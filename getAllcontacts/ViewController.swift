//
//  ViewController.swift
//  getAllcontacts
//
//  Created by Datanautic on 02/07/21.
//  Copyright © 2021 sivakiumar. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
enum ContactsFilter {
    case none
    case mail
    case message
}

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
 
    
    
    var phoneContacts = [PhoneContact]() // array of PhoneContact(It is model find it below)
        var filter: ContactsFilter = .none

    override func viewDidLoad() {
        super.viewDidLoad()
         self.loadContacts(filter: filter)
        // Do any additional setup after loading the view.
    }
    

         fileprivate func loadContacts(filter: ContactsFilter) {
              phoneContacts.removeAll()
              var allContacts = [PhoneContact]()
              for contact in PhoneContacts.getContacts(filter: filter) {
                  allContacts.append(PhoneContact(contact: contact))
              }

              var filterdArray = [PhoneContact]()
              if self.filter == .mail {
                  filterdArray = allContacts.filter({ $0.email.count > 0 }) // getting all email
              } else if self.filter == .message {
                  filterdArray = allContacts.filter({ $0.phoneNumber.count > 0 })
              } else {
                  filterdArray = allContacts
              }
              phoneContacts.append(contentsOf: filterdArray)

      for contact in phoneContacts {
        print("Name -> \(contact.name!)")
        print("Email -> \(contact.email)")
        print("Phone Number -> \(contact.phoneNumber)")
      }
            
        
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneContacts.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let Cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as? contactsCell else {
            return UITableViewCell()
        }
        
     
    Cell.namelabel.text = phoneContacts[indexPath.row].name
        
      let numberSTr =  phoneContacts[indexPath.row].phoneNumber.joined(separator: ",")
        
        Cell.numberLabel.text = numberSTr
        
        let emailStr = phoneContacts[indexPath.row].email.joined(separator: ",")
        
         Cell.emailLabel.text = emailStr

    return Cell

     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
     
        }
    
    
    
          




