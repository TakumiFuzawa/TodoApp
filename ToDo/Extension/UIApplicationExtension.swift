//
//  UIApplicationExtension.swift
//  ToDo
//
//  Created by Takumi Fuzawa on 2021/01/22.
//

import SwiftUI

extension UIApplication {
    func closekeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
