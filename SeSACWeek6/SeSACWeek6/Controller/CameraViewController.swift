//
//  CameraViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/12.
//

import UIKit

import YPImagePicker

final class CameraViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    // UIImagePickerController 1.
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIImagePickerController 2.
        picker.delegate = self
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
                
                self.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용 불가 + 사용자에게 토스트/얼럿")
            return
        }
        
        picker.sourceType = .camera
        picker.allowsEditing = true // 편집화면 등장
        
        present(picker, animated: true)
    }
    
    @IBAction func photoLibraryButtonTapped(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("사용 불가 + 사용자에게 토스트/얼럿")
            return
        }
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false // 편집화면 등장
        
        present(picker, animated: true)
    }
    
    @IBAction func saveToPhotoLibrary(_ sender: Any) {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
}

// UIImagePickerController 3.
// 네비게이션 컨트롤러를 상속받고 있음.
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // UIImagePickerController 4. 사진을 선택하거나 카메라 촬영 직후 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        // 원본, 편집, 메타 데이터 등 - infoKey
        // - 갤러리 상에 있는 이미지는 originalImage
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = image
            dismiss(animated: true)
        }
    }
    
    // UIImagePickerController 5. 취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}
