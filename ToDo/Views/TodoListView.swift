//
//  TodoList.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/16.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.time,ascending: true)],animation: .default)
    var todoList: FetchedResults<TodoEntity>
    
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let entity = todoList[index]
            viewContext.delete(entity)
        }
        do {
            try viewContext.save()
        } catch {
            print("Delete Error. \(offsets)")
        }
    }
    
    let category: TodoEntity.Category
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoList) { todo in
                        if todo.category == self.category.rawValue {
                            NavigationLink(destination: EditTaskView(todo: todo)) {
                                TodoDetailRowView(todo: todo, hideIcon: true)
                            }
                            
                        }
                    }.onDelete(perform: deleteTodo)
                }
                QuickNewTaskView(category: category).padding()
                
            }.navigationBarTitle(category.toString()).navigationBarItems(trailing: EditButton())
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    
    static let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    static let context = container.viewContext
    
    static var previews: some View {
        
        // テストデータの全削除
        let request = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "TodoEntity"))
        
        try! container.persistentStoreCoordinator.execute(request,with: context)
        
        // データを追加
        TodoEntity.create(in: context,
                          category: .ImpUrg_1st, task: "問題解決")
        TodoEntity.create(in: context,
                          category: .ImpNUrg_2nd, task: "瞑想")
        TodoEntity.create(in: context,
                          category: .NImpUrg_3rd, task: "意味のない会議")
        TodoEntity.create(in: context,
                          category: .NImpNUrg_4th, task: "暇つぶし")
        
        return TodoListView(category: .ImpUrg_1st).environment(\.managedObjectContext, context)
        
    }
}
