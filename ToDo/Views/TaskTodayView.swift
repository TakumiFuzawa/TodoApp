//
//  TaskTodayView.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/21.
//

import SwiftUI

struct TaskTodayView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.time,
                                           ascending: true)],
        predicate: NSPredicate(format:"time BETWEEN {%@ , %@}", Date.today as NSDate, Date.tomorrow as NSDate),
        animation: .default)
    
    var todoList: FetchedResults<TodoEntity>
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("今日のタスク").font(.footnote).bold().padding()
            List(todoList) { todo in
                TodoDetailRowView(todo: todo)
            }
        }.background(Color(UIColor.systemBackground))
        .clipShape(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0))
    }
}

struct TaskTodayView_Previews: PreviewProvider {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        TaskTodayView().environment(\.managedObjectContext, context)
    }
}
