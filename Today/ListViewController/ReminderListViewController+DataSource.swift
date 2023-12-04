//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by nat on 29/11/2023.
//

import UIKit

//  manage the data in the collection view. Also create and configure the cells that the collection view uses to display items in the list
extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompletedValue:String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        /*
        for reminder in Reminder.sampleData {
            reminderTitles.append(reminder.title)
        }
        snapshot.appendItems(reminderTitles)
        =
        */
        //  map returns a new array containing only the reminder titles, which populate as items in the snapshot
        snapshot.appendItems(reminders.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        
        //  applying the snapshot to the data source which reflects the changes in the user interface
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(withID: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    //  this function appepts a reminder identifier and returns the corresponding reminder from the reminders array
    func reminder(withID id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withID: id)
        return reminders[index]
    }
    
    //  this function accepts a reminder and updates the corresponding array element with the contents of the reminder
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withID: reminder.id)
        reminders[index] = reminder
    }
    
    //  this method will be called when the button is pressed
    func completReminder(withID id: Reminder.ID) {
        var reminder = reminder(withID: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func deleteReminder(withId id: Reminder.ID) {
        let index = reminders.indexOfReminder(withID: id)
        reminders.remove(at: index)
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction
    {
        let name = NSLocalizedString("Toogle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completReminder(withID: reminder.id)
            return true
        }
        return action
    }
    
    private func doneButtonConfiguration (for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration 
    {
        //  Use the ternary conditional operator to assign either "circle.fill" or "circle" to a constant named symbolName.
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        //During compilation, the system checks that the target, ReminderListViewController, has a didPressDoneButton(_:) method.
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        //  to display one image when it's in its normal state and a different image when its highlighted
        button.setImage(image, for: .normal)
        
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }
}
