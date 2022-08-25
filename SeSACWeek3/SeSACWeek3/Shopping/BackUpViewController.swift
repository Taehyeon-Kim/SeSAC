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
}
