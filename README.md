# 📝 TakeNotesApp

A simple iOS note-taking app built using UIKit and CoreData. Notes can be pinned, unpinned, edited, deleted, and shared. It features a clean user interface and supports searching notes by title or content.

---

## 🚀 Features

- 📌 Pin & unpin notes
- 🗑️ Swipe to delete
- 📤 Share notes via iOS share sheet using `UIActivityViewController`
- 🔍 Search notes (title and content)
- 🧠 Notes are split into **title** (first line) and **content** (rest of the text)
- 📱 Splash screen implemented via LaunchScreen.storyboard
- 📅 Shows formatted creation time/date
- 📂 Data is persisted using CoreData

---
## 📸 Demo Video

📽️ 

[https://github.com/username/TakeNotes/blob/main/assets/demo_video.mp4?raw=true](https://github.com/user-attachments/assets/ae514fdf-dedb-4860-9743-847b6650b6d8)


---
## 🧱 Architecture

- **MVC (Model-View-Controller)** pattern
- **Core Data** for local persistence
- Custom `UITableViewCell` for note display
- Navigation via `UINavigationController`
- UISearchBar for real-time filtering

---
## 🛠 How to Run
1. Clone this repo
2. Open `NotesApp.xcodeproj` in Xcode
3. Build & run on iPhone Simulator or device
 
---
## 🧰 Tech Stack

- 💻 Language: Swift 5
- 📱 UI Framework: UIKit
- 💾 Persistence: CoreData
- 🛠 IDE: Xcode 16.3
- 📱 Platform: iOS 18.4+
