//
//  TodoDetailRowView.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/16.
//

import SwiftUI

struct TodoDetailRowView: View {
    
    @ObservedObject var todo: TodoEntity
    
    var hideIcon = false
    
    var body: some View {
        
        HStack {
            
            if !hideIcon {
                CategoryImage(TodoEntity.Category(rawValue: todo.category))
            }
            
            CheckBox(checked: Binding(get: {
                self.todo.state == TodoEntity.State.done.rawValue
            }, set: {
                self.todo.state = $0 ? TodoEntity.State.done.rawValue : TodoEntity.State.todo.rawValue
            })) {
                if self.todo.state == TodoEntity.State.done.rawValue {
                    Text(self.todo.task ?? "no title").strikethrough()
                } else {
                    Text(self.todo.task ?? "No title")
                }
            }.foregroundColor(self.todo.state == TodoEntity.State.done.rawValue ? .secondary : .primary)
            
            //ジェスチャー機能（スワイプでチェックできる）
        }.gesture(DragGesture().onChanged({ value in
            if value.predictedEndTranslation.width > 200 {
                if self.todo.state != TodoEntity.State.done.rawValue {
                    self.todo.state = TodoEntity.State.done.rawValue
                }
            } else if value.predictedEndTranslation.width < -200 {
                if self.todo.state != TodoEntity.State.todo.rawValue {
                    self.todo.state = TodoEntity.State.todo.rawValue
                }
            }
        }))
    }
}

struct TodoDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newTodo = TodoEntity(context: context)
        
        newTodo.task = "新規顧客をどうやって増やすか"
        newTodo.state = TodoEntity.State.done.rawValue
        newTodo.category = 0
        let newTodo1 = TodoEntity(context: context)
        newTodo1.task="クレームへの対応"
        newTodo.category = 1
        let newTodo2 = TodoEntity(context: context)
        newTodo2.task="無意味な接待や付き合い"
        newTodo2.category = 2
        let newTodo3 = TodoEntity(context: context)
        newTodo3.task="長時間、必要以上の息抜き"
        newTodo3.category = 3
        return VStack(alignment: .leading) {
            VStack {
                TodoDetailRowView(todo: newTodo)
                TodoDetailRowView(todo: newTodo, hideIcon: true)
                TodoDetailRowView(todo: newTodo1)
                TodoDetailRowView(todo: newTodo2)
                TodoDetailRowView(todo: newTodo3)
            }.environment(\.managedObjectContext, context)
        }
    }
}
