//
//  ViewControllerEx.swift
//  Homework_5
//
//  Created by Yevhenii M on 04.11.2022.
//

import AudioToolbox
import UIKit

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
            let systemSoundID : SystemSoundID = 1003     
            AudioServicesPlayAlertSound(systemSoundID)
        }
    }
}
