//
//  ToastView.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import Foundation
import SwiftMessages

class ToastView: UIView {
    static let shared: ToastView = ToastView()
    
    func showToast(_ errorType: ErrorType) {
        let toastView = MessageView.viewFromNib(layout: .cardView)
        var config = SwiftMessages.Config()
        
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .normal)
        
        toastView.configureDropShadow()
        toastView.backgroundView.alpha = 0.9
        toastView.button?.isHidden = true
        toastView.titleLabel?.textColor = .black
        toastView.bodyLabel?.textColor = .black
        
        var bgColor = UIColor()
        var icImage = UIImage()
        var titleToast = ""
        var messageToast = ""
        
        switch errorType {
        case .networkError:
            bgColor = R.color.redLight()!
            icImage = R.image.ic_toast_error()!
            titleToast = Constant.TITLE_NETWORK_ERROR
            messageToast = Constant.MESSAGE_NETWORK_ERROR
        case .noConnection:
            bgColor = R.color.orangeSoft()!
            icImage = R.image.ic_toast_warning()!
            titleToast = Constant.TITLE_NO_NETWORK
            messageToast = Constant.MESSAGE_NO_NETWORK
        }
        
        toastView.backgroundView.backgroundColor = bgColor
        toastView.configureContent(title: titleToast, body: messageToast, iconImage: icImage)
        
        SwiftMessages.show(config: config, view: toastView)
    }
}
