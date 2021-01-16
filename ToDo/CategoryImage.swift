//
//  CategoryImage.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/15.
//

import SwiftUI

struct CategoryImage: View {
    var body: some View {
        Image(systemName: "tortoise.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .padding(2.0)
            .frame(width: 30, height: 30)
            .background(Color(#colorLiteral(red: 0.1615069807, green: 0.7159221768, blue: 1, alpha: 1)))
            .cornerRadius(6.0)
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage().scaledToFit()
    }
}
