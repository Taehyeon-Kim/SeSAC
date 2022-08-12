//
//  CameraViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/12.
//

import UIKit

import YPImagePicker

final class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 권한 문구 등도 내부적으로 구현, 실제로 카메라를 쓸 대 권한을 요청
    @IBAction func YPImageButtonTapped(_ sender: UIButton) {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func photoLibraryButtonTapped(_ sender: UIButton) {
        
    }
}
