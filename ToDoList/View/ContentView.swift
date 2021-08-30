//
//  ContentView.swift
//  ToDoList
//
//  Created by Victor Vieira on 26/08/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var firebaseManager: FirebaseManager
    @State var newTask = ""
    init(){
        firebaseManager = FirebaseManager()
    }
    
    var body: some View {
        VStack{
            Text("Tasks")
                .font(.title)
            HStack{
                TextField("type a new task", text: $newTask)
                Button(action: {
                    if(newTask != ""){
                        firebaseManager.createTaks(title: newTask)
                        newTask = ""
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(newTask == "" ? .gray : .blue )
                })
            }.padding()
            List{
                ForEach(firebaseManager.tasks){task in
                    HStack{
                        Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                firebaseManager.toggleCompleted(docId: task.id, completed: task.completed)
                            }
                        Text(task.title)
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach{ index in
                        firebaseManager.deleteTask(docId: firebaseManager.tasks[index].id)
                        
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
