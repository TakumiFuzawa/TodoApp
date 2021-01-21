//
//  EditTaskView.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/19.
//

import SwiftUI

struct EditTaskView: View {
    
    var categories: [TodoEntity.Category] = [.ImpUrg_1st, .ImpNUrg_2nd, .NImpUrg_3rd, .NImpNUrg_4th]
    
    @State var showingSheet = false
    
    @ObservedObject var todo: TodoEntity
    
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save() {
        do {
            try  self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    fileprivate func delete() {
        viewContext.delete(todo)
        save()
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Form {
            Section(header: Text("タスク")) {
                TextField("タスクの入力", text: Binding($todo.task, "New Task"))
            }
            Section(header: Toggle(isOn: Binding(isNotNill: $todo.time, defaultValue: Date())){Text("時間を指定する")}) {
                if time != nil {
                    DatePicker(selection: Binding($todo.time, Date()), label: { Text("日時")})
                    
                }else {
                    Text("時間未設定").foregroundColor(.secondary)
                }
                
            }
            Picker(selection: $todo.category, label: Text("種類")) {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        CategoryImage(category)
                        Text(category.toString())
                    }.tag(category.rawValue)
                }
            }
            
            Section(header: Text("操作")) {
                Button(action: {
                    self.showingSheet = true
                } ){
                    HStack(alignment: .center) {
                        Image(systemName: "minus.circle.fill")
                        Text("削除")
                    }.foregroundColor(.red)
                }
            }
        }.navigationBarTitle("タスクの編集").navigationBarItems(trailing: Button(action: {
            self.save()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("閉じる")
        })
        .actionSheet(isPresented: $showingSheet) {
            ActionSheet(title: Text("タスクの削除"), message: Text("このタスクを削除します。よろしいですか？"), buttons: [.destructive(Text("削除")) {
                self.delete()
                self.presentationMode.wrappedValue.dismiss()
            },
            .cancel(Text("キャンセル"))
            
            ])
        }
    }
}


struct EditTaskView_Previews: PreviewProvider {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        
        let newTodo = TodoEntity(context: context)
        
        return NavigationView {
            EditTaskView(todo: newTodo).environment(\.managedObjectContext, context)
        }
    }
}
