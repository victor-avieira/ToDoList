//
//  FirebaseManager.swift
//  ToDoList
//
//  Created by Victor Vieira on 26/08/21.
//

import Foundation
import Firebase

class FirebaseManager: ObservableObject{
   @Published var tasks = [Task]()
    private let database = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    init(){
        fetchTasks()
    }
    func createTaks(title: String){
        if(user != nil){
            database.collection("task").addDocument(data:
                                                        ["title" : title,
                                                    "completed" : false,
                                                    "createdTime" : Date()]
            )
        }
        
    }
    
    func toggleCompleted(docId: String, completed: Bool){
        if(user != nil){
            database.collection("task").document(docId).updateData(["completed" : !completed])        }
        
    }
    
    func deleteTask(docId: String){
        if(user != nil){
            database.collection("task").document(docId).delete()
        }
    }
    
    func fetchTasks(){
        if user != nil {
            database.collection("task").order(by: "createdTime", descending: false).addSnapshotListener({snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("no documents")
                    return
                }
                self.tasks = documents.map{docSnapshot -> Task in
                    let docId = docSnapshot.documentID
                    let title = docSnapshot["title"] as? String ?? ""
                    let completed = docSnapshot["completed"] as? Bool ?? false
                    let createdTime = docSnapshot["createdTime"] as? Date ?? Date()
                    
                    return Task(id: docId, title: title, completed: completed, createdTime: createdTime)
                    
                }
            })
        }
    }
}
