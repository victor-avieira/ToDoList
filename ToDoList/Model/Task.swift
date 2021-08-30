//
//  Task.swift
//  ToDoList
//
//  Created by Victor Vieira on 26/08/21.
//

import Foundation

struct Task: Identifiable{
    var id: String
    var title: String
    var completed: Bool
    var createdTime: Date
}
