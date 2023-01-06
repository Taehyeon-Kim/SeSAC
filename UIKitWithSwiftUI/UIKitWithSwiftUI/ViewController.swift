//
//  ViewController.swift
//  UIKitWithSwiftUI
//
//  Created by taekki on 2023/01/06.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    let vc = UIHostingController(rootView: ExampleView(apple: "HELLo"))
    show(vc, sender: self)
  }
}

