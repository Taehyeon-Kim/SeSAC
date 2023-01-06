//
//  ExampleView.swift
//  UIKitWithSwiftUI
//
//  Created by taekki on 2023/01/06.
//

import SwiftUI

struct ExampleView: View {
  
  @State var apple: String
  
  var body: some View {
    VStack {
      Image(systemName: "sunset")
      Text(apple)
    }
  }
}

struct ExampleView_Previews: PreviewProvider {
  static var previews: some View {
    ExampleView(apple: "apple")
  }
}
