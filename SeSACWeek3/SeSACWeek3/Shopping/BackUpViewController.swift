//
//  BackUpViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/08/25.
//

import UIKit

import SnapKit
import Then
import Zip

final class BackUpViewController: UIViewController {
    
    private let mainView = BackUpView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backUpButton.addTarget(self, action: #selector(backup), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restore), for: .touchUpInside)
    }
}

extension BackUpViewController {

    @objc func backup() {

        var urlPaths = [URL]()

        // 1. Document 위치 확인을 먼저 한다.
        // - 저장을 해야해서 위치를 알아보는 과정!
        guard let documentDirectoryPath = getDocumentDirectoryPath() else {
            print("Document 위치에 오류가 있습니다.")
            return
        }

        // 2. Realm 파일의 경로를 확인한다. document 위치 뒤에 default.realm 붙여서 확인하면 됨
        // - URL 타입
        // - 그러면 그냥 realm 경로 가져오는 function 쓰면 안되는건가?
        // - 밑에 있는 과정 때문에 그런걸까?
        let realmFilePath = documentDirectoryPath.appendingPathComponent("default.realm")

        // 3. 백업 파일 확인 과정 (Realm 파일 없으면 백업 불가)
        // realm 파일이 없을 수도 있다. - 사용자가 어떠한 파일도 저장하지 않은 경우
        guard FileManager.default.fileExists(atPath: realmFilePath.path) else {
            print("백업할 파일이 없습니다.")
            return
        }

        // 4. url 기반으로 압축을 들어갈거다!!
        urlPaths.append(realmFilePath)

        
        // 5. 자, 압축해보자.
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "Shopping_List")
            print("zip 파일 저장 위치: \(zipFilePath)")
            showActivityViewController()

        } catch {
            print("압축을 실패했습니다.")
        }

        // 6. ActivityViewController
        // - 성공을 했을 경우에만 띄울거다.
        showActivityViewController()
    }

    func showActivityViewController() {
        // 도큐먼트 경로 가져와라.
        guard let documentDirectoryPath = getDocumentDirectoryPath() else {
            print("Document 위치에 오류가 있습니다.")
            return
        }

        // 백업 파일은 zip 키워드가 붙어있을 것이다.
        // - URL 형태 : Realm File에 대한 것 (세부 경로)
        let backUpFileURL = documentDirectoryPath.appendingPathComponent("Shopping_List.zip")
        let viewController = UIActivityViewController(activityItems: [backUpFileURL], applicationActivities: [])
        self.present(viewController, animated: true)
    }
    
    
    // 복구 버튼을 눌렀을 때에는 Document Picker를 가져와서 백업 파일을 확인할 수 있어야 한다.
    @objc func restore() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}

extension BackUpViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("취소!!")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            print("파일을 찾을 수 없어요.")
            return
        }
        
        guard let path = getDocumentDirectoryPath() else {
            print("도큐먼트 위치를 찾을 수 없어요.")
            return
        }
        
        // 샌드박스로 파일을 가져와야하는데
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 파일 이미 존재하면 그냥 겹쳐 쓰는거지
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("Shopping_List.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                }, fileOutputHandler: { unzippedFile in
                    print("복구완료! : ", unzippedFile)
                })
                
            } catch {
                print("압축 해제 실패! 복구 실패!!!")
            }
        } else {
            
            do {
                // 없으면 파일을 옮겨와야함
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("Shopping_List.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                }, fileOutputHandler: { unzippedFile in
                    print("복구완료! : ", unzippedFile)
                })
                
            } catch {
                print("압축 해제 실패! 복구 실패!!!")
            }
            
        }
    }
}
