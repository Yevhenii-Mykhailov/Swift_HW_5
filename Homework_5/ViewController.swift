//
//  ViewController.swift
//  Homework_5
//
//  Created by Yevhenii M on 04.11.2022.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var storredItems: [ShoppingItem] = []
    let controller = ShoppingItemController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        self.storredItems = controller.getAllShopItems()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        createAlert()
    }
    
    private func configure() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func createAlert() {
        let alert = UIAlertController(title: "Add shop item", message: nil, preferredStyle: .alert)
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 270, height:18))
        label.textAlignment = .center
        label.textColor = .red
        label.font = label.font.withSize(12)
        alert.view.addSubview(label)
        label.isHidden = true
        
        let add = UIAlertAction(title: "Add", style: .default) { [self] action in
            guard let textField = alert.textFields?.first,
                  let itemToSave = textField.text else { return }
            
            if itemToSave != "" {
                self.controller.addRecord(itemToSave)
                let systemSoundID : SystemSoundID = 1004
                AudioServicesPlayAlertSound(systemSoundID)
            } else {
                label.text = ""
                label.text = "Please enter shop item to add."
                label.isHidden = false
                self.present(alert, animated: true, completion: nil)
            }
            
            self.storredItems = controller.getAllShopItems()
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Add new element"
        })
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}

