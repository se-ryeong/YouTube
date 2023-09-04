//
//  Extension.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import Foundation
import UIKit

extension UITextField {
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: .defaultPadding, height: self.frame.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = ViewMode.always
        self.rightViewMode = ViewMode.always
    }
}

extension CGFloat {
    static let defaultPadding:CGFloat = 16
}
