//
//  Colors.swift
//  MenuApp
//
//  Created by Milos Petrusic on 9.11.22..
//

import UIKit

enum Colors {
    case menuOrange
    
    func color() -> UIColor {
        switch self {
        case .menuOrange:
            return UIColor(named: "menuOrange")!
        }
    }
}
