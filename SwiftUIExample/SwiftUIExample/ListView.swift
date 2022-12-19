//
//  ListView.swift
//  SwiftUIExample
//
//  Created by taekki on 2022/12/19.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List {
            DatePicker(selection: .constant(Date()), label: { Text("Date") })
            Text("Hello, World!")
            Text("Hello, World!")
            DatePicker(selection: .constant(Date()), label: { Text("WOW") })
            Text("Hello, World!")
                .font(.headline)
                .foregroundColor(Color.purple)
                .padding([.top, .leading, .bottom])
            Text("Hello, World!")
                .font(.caption) // 뷰 설정 우선
            ForEach(0..<50) {
                Text("Hello, World! \($0)")
            }
        }
        .listStyle(.plain)
        .font(.largeTitle)
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
