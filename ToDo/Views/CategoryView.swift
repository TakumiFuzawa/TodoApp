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
    
    fileprivate func update() {
        self.numberOfTasks = TodoEntity.count(in: self.ViewContext, category: self.category)
    }
    
    var body: some View {
        
        let gradient = Gradient(colors: [category.color(), category.color().opacity(0.8)])
        
        let liner = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        
        return VStack(alignment: .leading) {
            
            Image(systemName: category.image()).font(.largeTitle).sheet(isPresented: $showList, onDismiss: {self.update()}) {
                TodoListView(category: self.category).environment(\.managedObjectContext, self.ViewContext)
            }
            Text(category.toString())
            Text("・\(numberOfTasks)タスク")
            Button(action: {
                self.addNewtask = true
            }) {
                Image(systemName: "plus")
            }.sheet(isPresented: $addNewtask, onDismiss: {self.update()}) {
                NewTaskView(category: self.category.rawValue).environment(\.managedObjectContext, self.ViewContext)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity, minHeight: 150)
        .foregroundColor(.white)
        .background(liner)
        .cornerRadius(20)
        .onTapGesture {
            self.showList = true
        }
        .onAppear {
            self.update()
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
