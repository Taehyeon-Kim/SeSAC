//
//  RepresentableView.swift
//  SwiftUIExample
//
//  Created by taekki on 2023/01/06.
//

import SwiftUI

// UIViewController(Class) -> convert -> View(Struct)
// Wrapping 해주는 구조체 == Packaging
struct SampleViewControllerRepresentable: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    //
  }

  func makeUIViewController(context: Context) -> UIViewController {
    return SampleViewController()
  }
}

struct RepresentableView: View {
    var body: some View {
      SampleViewControllerRepresentable()
        .ignoresSafeArea()
    }
}

struct RepresentableView_Previews: PreviewProvider {
    static var previews: some View {
        RepresentableView()
    }
}
