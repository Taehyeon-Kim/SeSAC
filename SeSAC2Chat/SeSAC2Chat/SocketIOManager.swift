//
//  SocketIOManager.swift
//  SeSAC2Chat
//
//  Created by taekki on 2022/11/23.
//

import Foundation
import SocketIO

final class SocketIOManager {
    
    static let shared = SocketIOManager()
    var listener: ((NSDictionary) -> Void)!
    
    // 서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private init() {
        let socketURL = URL(string: APIKey.socket)!
        manager = SocketManager(socketURL: socketURL, config: [
            // .log(true),
            .extraHeaders(["auth": APIKey.header]),
            .compress
        ])
        
        /// 디폴트로 제공하는 공간 사용
        socket = manager.defaultSocket // "http://api.sesac.co.kr:2022/"
        
        /// 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        /// 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        /// 이벤트 수신
        socket.on("sesac") { [weak self] dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let userId = data["userId"] as! String
            let createdAt = data["createdAt"] as! String
            
            // 나중에 noti로도 처리해보기
            // NotificationCenter.default.post(name: NSNotification.Name("msg"), object: self, userInfo: [
            //     "chat": chat,
            //     "name": name,
            //     "createdAt": createdAt,
            //     "userId": userId
            // ])
            
            print("CHECK >>>", chat, name, createdAt)
            self?.listener([
                "chat": chat,
                "name": name,
                "createdAt": createdAt,
                "userId": userId
            ])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
