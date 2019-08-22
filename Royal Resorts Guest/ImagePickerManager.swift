//
//  ImagePickerManager.swift
//  ImagePicker
//
//  Created by Attila Roy on 10/03/15.

import Foundation
import UIKit

typealias ImagePickerManagerCallback = (_ image: UIImage, _ source: UIImagePickerController.SourceType) -> ()

class ImagePickerManager: NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // singleton manager
    class var sharedManager :ImagePickerManager {
        struct Singleton {
            static let instance = ImagePickerManager()
        }
        return Singleton.instance
    }
    
    // the view controller that presents the Image picker
    fileprivate var parentViewController: UIViewController?
    
    // completion handler
    fileprivate var completionHandler: ImagePickerManagerCallback?
    
    // action sheet for Image Picker
    fileprivate let actionSheet = UIActionSheet(title: nil, delegate: nil, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take Photo", "Choose Existing")
    
    func presentImagePicker(_ viewController: UIViewController, completionHandler: @escaping ImagePickerManagerCallback) -> () {
        
        // save the completion handler
        self.completionHandler = completionHandler
        
        // save the parent view controller
        parentViewController = viewController
        
        // present the action sheet
        actionSheet.delegate = self
        actionSheet.show(in: (parentViewController?.view)!)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // get the source type for image picker controller
        var sourceType: UIImagePickerController.SourceType
        
        switch actionSheet.buttonTitle(at: buttonIndex)! {
        case "Choose Existing":
            appDelegate.gstrBorderColorImg = "f29301"
            sourceType = UIImagePickerController.SourceType.photoLibrary
        case "Take Photo":
            appDelegate.gstrBorderColorImg = "f29301"
            sourceType = UIImagePickerController.SourceType.camera
        default:
            sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
            appDelegate.gstrBorderColorImg = "f29301"
            //return
        }
        
        if sourceType == UIImagePickerController.SourceType.savedPhotosAlbum{
        
        }else if sourceType == UIImagePickerController.SourceType.camera{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = sourceType
                // present the image picker controller
                parentViewController?.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                print("Sorry cant take picture")
            }
        }else if sourceType == UIImagePickerController.SourceType.photoLibrary{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            // present the image picker controller
            parentViewController?.present(imagePickerController, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // fire completion handler
        completionHandler?(info[UIImagePickerController.InfoKey.editedImage] as! UIImage, picker.sourceType)
        
        // dismiss the image picker
        dismissImagePicker()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }
    
    func dismissImagePicker() {
        parentViewController?.dismiss(animated: true, completion: nil)
    }
    
}


