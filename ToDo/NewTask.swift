//
//  NewTask.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/16.
//

import SwiftUI

struct NewTask: View {
    
    let category: TodoEntity.Category
    
    @State var newTask: String = ""
    
    fileprivate func addNewTask() {
        self.newTask = ""
    }
    
    fileprivate func cancelTask() {
        self.newTask = ""
    }
    
    var body: some View {
        HStack {
            TextField("新しいタスク", text: $newTask) {
                self.addNewTask()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                self.addNewTask()
            }) {
                Text("追加")
            }
            Button(action: {
                self.cancelTask()
            }) {
                Text("キャンセル").foregroundColor(.red)
            }
        }
        
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask(category: .ImpUrg_1st)
    }
}
