//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Victor Vieira on 26/08/21.
//

import SwiftUI
import Firebase

@main
struct ToDoListApp: App {
    init(){
        FirebaseApp.configure()
        if (Auth.auth().currentUser == nil){
            print("Não está logado")
            Auth.auth().signInAnonymously()
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
