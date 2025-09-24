//
//  CellPage.swift
//  TakeNotes
//
//  Created by MacOS on 17/09/2025.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    
    var note: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let existingNote = note {
            titleField.text = existingNote.title
            bodyField.text = existingNote.body
        } else {
            titleField.becomeFirstResponder()
        }
        
        bodyField.textContainerInset = .zero
        bodyField.textContainer.lineFragmentPadding = 0
    }
    
    @IBAction func shareButtonClicked(_ sender: UIBarButtonItem) {
        guard let title = titleField.text, let body = bodyField.text else { return }
            
            let textToShare = "\(title)\n\n\(body)"
            let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
            present(activityVC, animated: true, completion: nil)
    }
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        
        //alert box
        guard let title = titleField.text, !title.isEmpty else{
            let alert = UIAlertController(title: "Title is Empty", message: "you can't make empty note", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
            return
        }
        if let note = note {
            CoreDataManager.shared.updateNote(note, title: title, body: bodyField.text)
        }
        else {
            CoreDataManager.shared.addNote(title: title, body: bodyField.text)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
