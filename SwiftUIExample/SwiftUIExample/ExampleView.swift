//
//  ExampleView.swift
//  SwiftUIExample
//
//  Created by taekki on 2022/12/19.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/) // 하나의 View
                .font(.title)
                .foregroundColor(.blue)
                .fontWeight(.heavy)
            Spacer()
            Text("Hello, World!") // 하나의 View
                .underline()
                .strikethrough()
            Spacer()
            Spacer()
            Spacer()
            Text("Hello, World!\n두번째줄\n세번째줄") // 하나의 View
                .font(.caption)
                .italic()
                .lineLimit(2)
                .kerning(10)
        }
        .padding(10)
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
