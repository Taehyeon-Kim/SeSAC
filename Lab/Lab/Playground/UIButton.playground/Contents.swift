import UIKit
import PlaygroundSupport

let button = UIButton()
button.frame = CGRect(x: 0, y: 0, width: 300, height: 52)

var config = UIButton.Configuration.filled()
config.baseBackgroundColor = .red
config.title = "카메라"
config.subtitle = "여기보세요~ 하나 둘 셋!"
config.image = UIImage(systemName: "star.fill")
button.configuration = config


@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    static func taekkiStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "taekki-button"
        configuration.subtitle = "so cool ~"
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .blue
        configuration.image = UIImage(systemName: "star")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.cornerStyle = .capsule
        configuration.showsActivityIndicator = true
        return configuration
    }
}

button.configuration = .taekkiStyle()


@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    enum SobokButtonStyle {
        case basic
        case sub
        case disabled
        
        var backgroundColor: UIColor? {
            switch self {
            case .basic:
                return UIColor(red: 24/255, green: 206/255, blue: 198/255, alpha: 1.0)
            case .sub:
                return UIColor(red: 228/255, green: 246/255, blue: 246/255, alpha: 1.0)
            case .disabled:
                return UIColor(red: 227/255, green: 232/255, blue: 235/255, alpha: 1.0)
            }
        }
        
        var foregroundColor: UIColor? {
            switch self {
            case .basic:
                return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            case .sub:
                return UIColor(red: 0/255, green: 171/255, blue: 182/255, alpha: 1.0)
            case .disabled:
                return UIColor(red: 161/255, green: 169/255, blue: 174/255, alpha: 1.0)
            }
        }
    }
    
    static func sobokStyle(style: SobokButtonStyle) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "확인"
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = style.foregroundColor
        configuration.baseBackgroundColor = style.backgroundColor
        configuration.background.cornerRadius = 12
        return configuration
    }
}

button.configuration = .sobokStyle(style: .basic)

button.configuration = .sobokStyle(style: .sub)

button.configuration = .sobokStyle(style: .disabled)
