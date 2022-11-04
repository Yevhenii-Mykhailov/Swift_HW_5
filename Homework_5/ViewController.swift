//
//  ViewController.swift
//  Homework_5
//
//  Created by Yevhenii M on 04.11.2022.
//

import UIKit

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
        let alert = UIAlertController(title: "Shop items", message: "Add or remove shop items", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default) { [self] action in
            guard let textField = alert.textFields?.first,
                  let itemToSave = textField.text else { return }
            
            self.controller.addRecord(itemToSave)
            
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shopItem = self.storredItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = shopItem.name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let currentIndex = indexPath.row
        if editingStyle == .delete {
            storredItems.remove(at: currentIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.controller.removeRecord(currentIndex)
        }
    }
}

