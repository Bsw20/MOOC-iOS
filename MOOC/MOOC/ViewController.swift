//
//  ViewController.swift
//  MOOC
//
//  Created by Андрей Самаренко on 29.03.2021.
//

import SwiftUI

class ViewController: UIHostingController<AuthView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: AuthView())
    }
    
    required init() {
        super.init(rootView: AuthView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

