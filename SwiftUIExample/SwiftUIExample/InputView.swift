//
//  InputView.swift
//  SwiftUIExample
//
//  Created by taekki on 2023/01/05.
//

import SwiftUI

struct UserTextView: View {
  // 부모 뷰에서 값을 전달받을 때 많이 사용
  // 다른 객체에 데이터 전달 시 사용
  @Binding var text: String
  
  var body: some View {
    Text(text)
  }
}

// UIView 객체(UIKit 요소)를 SwiftUI 내에서 사용할 수 있음
struct ChatTextView: UIViewRepresentable {
  // makeUIView의 return type을 명확하게 명시해주면
  // updateUIView의 첫번째 인자인 UIViewType의 구체적으로 정해지기 때문에
  // 특정 타입의 프로퍼티와 메서드를 호출해서 사용할 수 있게 된다.
  
  @Binding var nickname: String
  
  // SwiftUI 객체가 렌더링될때 계속 호출
  func updateUIView(_ uiView: UIViewType, context: Context) {
    uiView.text = nickname // Binding 프로퍼티로 받아온 값을 업데이트
  }
  
  func makeUIView(context: Context) -> UITextView {
    let textView: UITextView = {
      let textView = UITextView()
      textView.backgroundColor = [UIColor.red, UIColor.blue, UIColor.green].randomElement()
      return textView
    }()
    
    return textView
  }
}

struct InputView: View {
  
  @State private var nickname = "InputView의 State 프로퍼티"
  
  var body: some View {
    VStack {
      // TextField("닉네임을 입력해주세요", text: $nickname, axis: .vertical)
      //   .textFieldStyle(.roundedBorder)
      //   .padding(10)
      //   .lineLimit(0)
      // UserTextView(text: $nickname)
      ChatTextView(nickname: $nickname)
    }
  }
}

struct InputView_Previews: PreviewProvider {
  static var previews: some View {
    InputView()
  }
}
