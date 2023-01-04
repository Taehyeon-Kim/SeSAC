//
//  Tamagotchi.swift
//  SwiftUIExample
//
//  Created by taekki on 2023/01/04.
//

import SwiftUI

// Opaque Type <-> Generic Type

// Generic Type
// 함수 내부에서는 어떤 타입이 들어오는지 알 수 없음
// 함수 호출 시, 즉 외부에서 실제 타입을 알 수 있음

// some -> 컴파일시에 실제 값을 찾아서 반환해줌

struct GrowButton: View {
  
  var sfSymbol: String = "star"
  var content: String
  var action: (() -> Void)
  
  private var Icon: Image { Image(systemName: sfSymbol) }

  var body: some View {
    Button(action: action) {
      Icon
      Text(content)
    }
    .padding(8)
    .foregroundColor(.white)
    .background(.black)
    .cornerRadius(8)
  }
}

struct Tamagotchi: View {
  
  // 구조체 내부적으로 값을 변경하고 싶다.
  @State var waterCount: Int = 0
  @State var riceCount: Int = 0
  
  var body: some View {
    VStack(spacing: 10) {
      Text("방실방실 다마고치")
        .bold()
      
      Text("Lv 1. 물방울 \(waterCount)개 · 밥알 \(riceCount)개")
        .foregroundColor(.gray)
      
      HStack {
        GrowButton(sfSymbol: "drop", content: "물주기") {
          waterCount += 10
        }
        GrowButton(sfSymbol: "star", content: "밥주기") {
          riceCount += 5
        }
      }
    }
  }
}

struct Tamagotchi_Previews: PreviewProvider {
    static var previews: some View {
        Tamagotchi()
    }
}
