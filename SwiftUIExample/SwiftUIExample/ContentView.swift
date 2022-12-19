//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by taekki on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(Color.red)
            Text("안녕하세요!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
