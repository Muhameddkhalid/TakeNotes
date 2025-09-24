//
//  ViewController.swift
//  TakeNotes
//
//  Created by MacOS on 12/09/2025.
//

import UIKit
import CoreData

class NotesTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cellReuseIdentifier = "customCell"
    var notesArray = [Notes]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesArray = CoreDataManager.shared.fetchNotes()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "NotePage") as! NotesViewController
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNotePage" {
            let destinationVC = segue.destination as! NotesViewController
            if let indexPath = sender as? IndexPath {
                destinationVC.note = notesArray[indexPath.row]
            }
        }
    }
    
}

//MARK: - UITableViewMethods
extension NotesTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCell
        
        cell.titleLabel.text = notesArray[indexPath.row].title
        cell.bodyLabel.text = notesArray[indexPath.row].body
        if let noteTime = notesArray[indexPath.row].time {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            cell.timeLabel.text = formatter.string(from: noteTime)
        }
        cell.pinIcon.image = notesArray[indexPath.row].isPinned ? UIImage(systemName: "pin.fill") : nil
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNotePage", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteNode(array: notesArray, at: indexPath)
            notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: notesArray[indexPath.row].isPinned ? "unpin" : "pin") { (action, swipeButtonView, completion) in
            self.notesArray[indexPath.row].isPinned = !self.notesArray[indexPath.row].isPinned
            CoreDataManager.shared.saveContext()
            self.notesArray = CoreDataManager.shared.fetchNotes()
            self.tableView.reloadData()
            completion(true)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }
}

//MARK: - UISearchBarMethods
extension NotesTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        notesArray = CoreDataManager.shared.fetchNotes(filter: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        notesArray = CoreDataManager.shared.fetchNotes()
        tableView.reloadData()
    }
    
}
