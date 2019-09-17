//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by Spctn on 9/11/19.
//  Copyright © 2019 idocnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.contentSize = imageView.image!.size
        
//        imageView.frame.size = imageView.image!.size
//
//        setZoomParamerter(scrollView.bounds.size)
//        centerImage()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(adjustInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(adjustInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillLayoutSubviews() {
//        setZoomParamerter(scrollView.bounds.size)
//        centerImage()
    }
    
    private func centerImage(){
        let scrollSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        
        let verticalSpace = imageSize.height > scrollSize.height ? 0 : (scrollSize.height - imageSize.height) / 2
        
        let horizontalSpace = imageSize.height > scrollSize.height ? 0 : (scrollSize.width - imageSize.width) / 2
        
        print("width: \(horizontalSpace), height: \(verticalSpace)")
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    private func setZoomParamerter(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    @objc func adjustInsetForKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let show = (notification.name == UIResponder.keyboardWillShowNotification)
            ? true
            : false
        
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }

}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

