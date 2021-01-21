//
//  CategoryView.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/16.
//

import SwiftUI

struct CategoryView: View {
    
    var category: TodoEntity.Category
    
    @State var numberOfTasks = 0
    
    @State var showList = false
    
    @Environment(\.managedObjectContext) var ViewContext
    
    @State var addNewtask = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image(systemName: category.image()).font(.largeTitle).sheet(isPresented: $showList) {
                TodoListView(category: self.category).environment(\.managedObjectContext, self.ViewContext)
            }
            Text(category.toString())
            Text("・\(numberOfTasks)タスク")
            Button(action: {
                self.addNewtask = true
            }) {
                Image(systemName: "plus")
            }.sheet(isPresented: $addNewtask) {
                NewTaskView(category: self.category.rawValue).environment(\.managedObjectContext, self.ViewContext)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity, minHeight: 150)
        .foregroundColor(.white)
        .background(category.color())
        .cornerRadius(20)
        .onTapGesture {
            self.showList = true
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        
        VStack {
            
            CategoryView(category: .ImpUrg_1st, numberOfTasks: 3)
            CategoryView(category: .ImpNUrg_2nd)
            CategoryView(category: .NImpUrg_3rd)
            CategoryView(category: .NImpNUrg_4th)
            
        }.environment(\.managedObjectContext, context)
    }
}
