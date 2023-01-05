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

struct InputView: View {
  
  @State private var nickname = ""
  
  var body: some View {
    VStack {
      TextField("닉네임을 입력해주세요", text: $nickname)
        .textFieldStyle(.roundedBorder)
        .padding(10)
      UserTextView(text: $nickname)
    }
  }
}

struct InputView_Previews: PreviewProvider {
  static var previews: some View {
    InputView()
  }
}
