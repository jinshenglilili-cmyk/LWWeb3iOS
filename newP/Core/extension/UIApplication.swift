//
//  UIApplication.swift
//  newP
//
//  Created by Liwei on 2026/1/4.
//

import Foundation
import UIKit
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil,for: nil)
    }
}
