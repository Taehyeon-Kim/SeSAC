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

/*
 1. 구조체
 2. 연산 프로퍼티 -> 항상 body가 그려질 때 전부 다시 그려야 함
 -> 다시 그려지는 패턴이 다름
 */

/*
 * 재사용 메커니즘이 동작하는가 아닌가
 - V H Z Stack : 전체 데이터를 메모리에 담아두고 스크롤 할 때 보여줌 / 스크롤 시에는 적합한 객체가 아닐 수 있음
 - LazyVStack LazyHStack : 화면에 렌더링 될 때 데이터를 메모리에 담고 그린다.
 */

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

// View가 다시 렌더링되지 않음
struct ExampleText: View {
  var body: some View {
    Text("방실방실 다마고치 \(Int.random(in: 1...100))")
      .bold()
  }
}

struct Tamagotchi: View {
  
  // 구조체 내부적으로 값을 변경하고 싶다.
  @State private var waterCount: Int = 0
  @State private var riceCount: Int = 0
  @State private var isPresented: Bool = false
  
  // 연산 프로퍼티로 View 분리
  // 재연산
  var characterName: some View {
    Text("방실방실 다마고치 \(Int.random(in: 1...100))")
      .bold()
  }
  
  var body: some View {
    VStack(spacing: 10) {
      // 3D
      ZStack {
        characterName
          .padding(100)
          .background(.red)
        
        characterName
          .padding(50)
          .background(.yellow)
      }
      
      characterName
      ExampleText()
      Text("Lv 1. 물방울 \(waterCount)개 · 밥알 \(riceCount)개")
        .foregroundColor(.gray)
      
      HStack {
        GrowButton(sfSymbol: "drop", content: "물주기") {
          waterCount += 10
        }
        GrowButton(sfSymbol: "circle", content: "밥주기") {
          riceCount += 5
        }
        GrowButton(sfSymbol: "pencil", content: "통계보기") {
          isPresented = true
        }
        .sheet(isPresented: $isPresented) {         // $ -> Convert into binding type
          ExampleView()
        }
      }
    }
    .onAppear {
      // ViewDidLoad에서 하고 싶은 일들을 여기서 실행시킨다면 오류가 생길 수 있음
      print("ViewDidAppear")
    }
    .onDisappear {
      print("ViewDidDisappear")
    }
  }
}

struct Tamagotchi_Previews: PreviewProvider {
    static var previews: some View {
        Tamagotchi()
    }
}
