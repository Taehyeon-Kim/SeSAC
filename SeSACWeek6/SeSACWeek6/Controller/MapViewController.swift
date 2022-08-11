//
//  MapViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/11.
//

import UIKit
import MapKit

/*
 MapView
 - 지도와 위치 권한은 상관x
 - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해주어야 함
 - 중심, 범위 지정
 - 핀
 */

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
