//
//  Photo.swift
//  PGFramework
//
//  Created by Moeka Ihara on 2020/01/29.
//  Copyright © 2020 Playground. All rights reserved.
//

import Photos
import AVFoundation

extension Const {
    static let AnimationTime = 0.4

    static let Blank = ""
    static let Cancel = "キャンセル"
    static let OK = "OK"
    static let Error = "Error"
    static let DeniedAccessCamera = "カメラもしくは写真へのアクセスが許可されていません"
    static let AskToSettingView = "設定画面へ移行しますか?"
    static let AskToSelect = "選択してください"
    static let SelectFromAlbum = "アルバムから選択"
    static let TakeWithCamera = "カメラで撮影"
    static let DeletePhoto = "写真を削除"
    static let DeleteMovie = "動画を削除"

    static let PublicMovie = "public.movie"
}

extension BaseViewController:  UIImagePickerControllerDelegate {

    public func checkCameraAuth(allowed: @escaping () -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        let status2 = PHPhotoLibrary.authorizationStatus()

        if status == AVAuthorizationStatus.authorized &&
            status2 == .authorized {
            // アクセス許可あり
            allowed()
        } else if status == AVAuthorizationStatus.restricted ||
            status2 == .restricted {
            // ユーザー自身にカメラへのアクセスが許可されていない
            alertToSetting(title: Const.DeniedAccessCamera, message: Const.AskToSettingView)
        } else if status == AVAuthorizationStatus.notDetermined ||
            status2 == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { result in
                PHPhotoLibrary.requestAuthorization({ status in
                    if result && (status == .authorized) {
                        allowed()
                    } else {
                        return
                    }
                })
            })
        }else if status == AVAuthorizationStatus.denied ||
            status2 == .denied {
            alertToSetting(title: Const.DeniedAccessCamera,
                           message: Const.AskToSettingView)
        }else{
            print(Const.Error)
        }
    }

    public func moviePicker(deleteAction: @escaping (UIAlertAction) -> Void) {
        checkCameraAuth { [weak self] in
            guard let this = self else { return }
            let alert: UIAlertController = UIAlertController(title: Const.Blank,
                                                             message: Const.AskToSelect,
                                                             preferredStyle: .actionSheet)

            let galleryAction: UIAlertAction = UIAlertAction(title: Const.SelectFromAlbum,
                                                             style: .default,
                                                             handler:{ (action: UIAlertAction!) -> Void in
                                                                let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary

                                                                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                                                                    let libraryPicker = UIImagePickerController()
                                                                    libraryPicker.sourceType = sourceType
                                                                    libraryPicker.mediaTypes = [Const.PublicMovie]
                                                                    libraryPicker.delegate = this
                                                                    this.present(libraryPicker, animated: true, completion: nil)
                                                                }
            })
            let deleteAction = UIAlertAction(title: Const.DeleteMovie, style: .default, handler: deleteAction)
            let cancelAction = UIAlertAction(title: Const.Cancel, style: .cancel, handler: { (_) in })
            alert.addAction(galleryAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            this.present(alert, animated: true, completion: nil)
        }
    }

    public func useCamera(isDeletable: Bool?=nil,
                          deleteAction:((UIAlertAction) -> Void)?=nil) {
            checkCameraAuth {
                DispatchQueue.main.async { [weak self] in
                    guard let this = self else { return }
                    this.activeCamera(isDeletable: isDeletable,
                                      deleteAction: deleteAction)
                }
            }
    }

    public func activeCamera(isDeletable: Bool?=nil,
                             deleteAction:((UIAlertAction) -> Void)?=nil) {
        let alert: UIAlertController = UIAlertController(title: Const.Blank, message: Const.AskToSelect, preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = UIAlertAction(title: Const.TakeWithCamera, style: .default, handler:{ [weak self]
            (action: UIAlertAction!) -> Void in
            guard let this = self else { return }
            let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = this
                this.present(cameraPicker, animated: true, completion: nil)
            }
        })

        let galleryAction: UIAlertAction = UIAlertAction(title: Const.SelectFromAlbum, style: .default, handler:{ [weak self]
            (action: UIAlertAction!) -> Void in
            guard let this = self else { return }
            let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let libraryPicker = UIImagePickerController()
                libraryPicker.sourceType = sourceType
                libraryPicker.delegate = this
                this.present(libraryPicker, animated: true, completion: nil)
            }
        })

        let deleteAction = UIAlertAction(title: Const.DeletePhoto, style: .default, handler: deleteAction)
        let cancelAction: UIAlertAction = UIAlertAction(title: Const.Cancel, style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print(Const.Cancel)
        })
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        if isDeletable == true {
            alert.addAction(deleteAction)
        }
        present(alert, animated: true, completion: nil)
    }

    public func alert(message: String) {
        let vc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: Const.OK, style: .default, handler: nil))
        present(vc, animated: true, completion: nil)
    }

    public func alert(message: String, choiceHandler: @escaping ((UIAlertAction) -> Void)) {
        let vc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: Const.OK, style: .default, handler: choiceHandler))
        present(vc, animated: true, completion: nil)
    }

    public func alert(title: String?, message: String? = nil,
                      choice: String? = nil, choiceStyle: Int? = nil,
                      tintColor: UIColor? = nil, choiceHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: Const.Cancel, style: .cancel, handler: nil))
        if let choice = choice {
            ac.addAction(UIAlertAction(title: choice, style: .default, handler: { action in
                choiceHandler()
            }))
        }
        ac.view.tintColor = tintColor
        present(ac, animated: true, completion: nil)
    }

    public func alertToSetting(title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: Const.OK, style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        vc.addAction(UIAlertAction(title: Const.Cancel, style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }

    public func callActionSheet(titles: [String], choiceHandler: [() -> Void]) {
        var actions = [UIAlertAction]()
        for i in 0 ..< titles.count {
            let action = UIAlertAction(title: titles[i], style: .default) { action in
                let handler = choiceHandler[i]
                handler()
            }
            actions.append(action)
        }
        let alert: UIAlertController = UIAlertController(title: Const.Blank, message: Const.AskToSelect, preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: Const.Cancel, style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print(Const.Cancel)
        })
        alert.addAction(cancelAction)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
