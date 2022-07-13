import Foundation

/*
 기존의 배열이라고 하면 동일한 타입만 담을 수 있었지만 (물론 Any로 하면 되겠지만...)
 
 좀 더 확장된 상자(식판, 모음)을 만들기 위해서,
 좀 더 여러 가지 타입을 하나의 묶음으로 다루기 위해서
 다른 형태를 살펴보도록 하자.
 */

/*
 ✅ 부모-자식의 관계는 상대적인 것이다.
 Super Class(부모 클래스)
 Sub Class(자식 클래스) -> Sub Classing 자식을 만드는 과정
 Base Class(어디에서도 상속받고 있지 않는 클래스)
 */

class Monster {
    var clothes = "Orange + Christmas"
    var speed = 5
    var power = 20
    var expoint: Double = 5000
    
    func attack() {
        print("Monster - 공격!!!")
    }
}

var easyMonster = Monster()  // 초기화 (인스턴스) , easyMonster라는 공간에 올라가 있는 상태

easyMonster.clothes
easyMonster.power

//easyMonster.attack()
//easyMonster.attack()

class BossMonster: Monster {
    var levelLimit = 500
    
    func bossAttack() {
        print("스페셜 공격")
    }
    
    // 재정의(오버라이딩)
    // 부모의 것을 각색해서 쓰겠다.
    override func attack() {
//        super.attack()
        print("BossMonster - 공격")
    }
}

var finalBoss = BossMonster()
finalBoss.bossAttack()
finalBoss.attack()
finalBoss.levelLimit
finalBoss.speed

// 📌 UIKit도 상속 구조로 클래스를 만들어져 있다.
// 📌 Struct는 상속과 오버라이딩이 되지 않는다.

var nickname = "고래밥"
var subNickname = "고래밥"

subNickname = "칙촉"
print(nickname, subNickname)

var miniMonster = Monster()
print(miniMonster.power)

var bossMonster = miniMonster
bossMonster.power = 5000

print(miniMonster.power)
print(bossMonster.power)

/*
 구조체는 값 타입
 클래스는 참조 타입
 */

// 클래스는 자신의 원래 공간에 메모리 주소만 담고 있음. 값은 다른 곳에 저장되어 있음.
