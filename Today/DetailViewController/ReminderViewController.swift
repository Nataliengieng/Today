//
//  ReminderViewController.swift
//  Today
//
//  Created by nat on 30/11/2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        //  disable separators in the list configuration to remove the lines between the list cells
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    //  a failable initialiser, the result is an optional that contains either the initialised object if succeeds or nil if fails
    required init?(coder: NSCoder) {
        fatalError("Always initialise ReminderViewController using init(reminder:)")
    }
}
