//
//  ViewController.swift
//  MOOC
//
//  Created by Андрей Самаренко on 29.03.2021.
//

import SwiftUI

class ViewController: UIHostingController<SignInView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SignInView())
    }
    
    required init() {
        super.init(rootView: SignInView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

