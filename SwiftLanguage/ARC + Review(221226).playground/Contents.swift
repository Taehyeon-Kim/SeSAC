import UIKit

class Guild {
    var guildName: String
    var owner: User?
    
    init(guildName: String) {
        self.guildName = guildName
        print("Guild init")
    }
    
    deinit {
        print("Guild deinit")
    }
}

class User {
    var nickname: String
    var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("User init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var sesac: Guild? = Guild(guildName: "SeSAC")   // Guild - RC 1

var nickname: User? = User(nickname: "새싹이")    // User - RC 1

sesac?.owner = nickname // User - RC2
nickname?.guild = sesac // Guild - RC2

sesac?.owner = nil
nickname = nil
sesac = nil

