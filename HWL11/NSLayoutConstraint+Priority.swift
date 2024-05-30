//
//  NSLayoutConstraint+Priority.swift
//  HWL11
//
//  Created by Даниил Евгеньевич on 29.05.2024.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        
        self.priority = priority
        return self
    }
}
