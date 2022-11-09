//
//  NibProtocol.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import UIKit

protocol NibProtocol: Identifiable {
    static var nib: UINib { get }
}

extension NibProtocol {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
