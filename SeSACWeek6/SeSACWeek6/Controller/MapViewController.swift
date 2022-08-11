//
//  MapViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation  // Location1. import

/*
 MapView
 - 지도와 위치 권한은 상관x
 - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해주어야 함
 - 중심, 범위 지정
 - 핀(어노테이션)
 */

/*
 권한: 반영이 조금씩 느릴 수 있음. 지웠다가 실행한다고 하더라도, 한 번 허용
 설정: 앱이 바로 안 뜰 수
 */

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    // Location2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location3. 프로토콜 연결
        locationManager.delegate = self
        
        checkUserDeviceLocationServiceAuthorization()
        setRegionAndAnnotation()
    }
    
    func setRegionAndAnnotation() {
        // 지도 중심 설정 : 애플맵 활용해 좌표 복사
        // 위도, 경도에 대한 정보
        // - 사용자의 위치 정보를 모르더라도 사용 가능한 정보
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // 지도에 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "이곳이 나의 캠퍼스다"
        mapView.addAnnotation(annotation)
    }
}

// 위치 관련된 User Defined 메서드
extension MapViewController {
    
    // Location7. iOS 버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    //
    // 위치 서비스가 켜져 있다면 권한을 요청하고, 꺼져 있다면 커스텀 알럿으로 상황 알려주기
    // CLAuthorizationStatus
    // - notDetermined: 앱 첫 실행시, 아직 안 고른 상태
    // - denied: 허용 안함 / 설정에서 추후 거부 / 위치 서비스 중지 / 비행기 모드(위치 서비스 사용 불가 상태)
    // - restricted: 앱에서 권한 자체가 없는 경우 / 자녀 보호 기능 같은 걸로 아예 제한
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            // 인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus       // 인스턴스 타입 프로퍼티
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()   // 타입 메서드
        }
        
        // 이제서야 iOS 위치 서비스 활성화 여부 체크: locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어 위치 권한 요청을 하지 못합니다.")
        }
    }
    
    // Location8. 사용자의 위치 권한 상태 확인
    // 사용자가 위치를 허용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인(단, 사전에 iOS 위치 서비스 활성화 상태 꼭 확인 필요)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()         // 앱을 사용하는 동안에 대한 위치 권한 요청
            //plist에 WhenInUse가 등록되어 있어야 request 메서드를 사용할 수 있다. 권한이 없으면 앱이 꺼지게 된다.
            locationManager.startUpdatingLocation()                 // 이 부분도 요청 필요
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            // 사용자가 위치를 혀용해 둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default:
            print("DEFAULT")
        }
    }
}

// Location4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    
    // Location5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
    }
    
    // Location6. 사용자의 위치를 못 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // 지도에 커스텀 핀 추가
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
    // ex. Kakao T - 탑승 위치 수정 시 택시 위치 변경되는 것
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        <#code#>
//    }
}
