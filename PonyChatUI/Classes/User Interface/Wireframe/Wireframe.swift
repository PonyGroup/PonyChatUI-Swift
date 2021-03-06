//
//  Wireframe.swift
//  PonyChatUIProject
//
//  Created by 崔 明辉 on 15/10/27.
//
//

import Foundation

extension PonyChatUI.UserInterface {
    
    public class Wireframe {
        
        let preloadWindow = UIWindow()
        
        public func main(messageManager: PonyChatUI.MessageManager, messagingConfigure: Configure? = nil, footerView: UIView? = nil) ->
            (PonyChatUI.UserInterface.MainViewController, UIView) {
            let mainViewController = MainViewController()
            mainViewController.eventHandler.interactor.manager = messageManager
            messageManager.delegate = mainViewController.eventHandler.interactor
            mainViewController.footerView = footerView
            return (mainViewController, mainViewController.view)
        }
        
        public func preload(
            messageManager: PonyChatUI.MessageManager,
            messagingConfigure: Configure? = nil,
            footerView: UIView? = nil,
            size: CGSize,
            completion:(PonyChatUI.UserInterface.MainViewController, UIView) -> Void)
            -> Void {
                preloadWindow.windowLevel = UIWindowLevelNormal - 1
                preloadWindow.hidden = false
                preloadWindow.frame = CGRect(x: 0, y: -9999.0, width: size.width, height: size.height)
                let _main = main(messageManager, messagingConfigure: messagingConfigure, footerView: footerView)
                if let footerViewHeight = footerView?.frame.size.height {
                    _main.0.footerViewHeight = footerViewHeight
                }
                preloadWindow.rootViewController = _main.0
                _main.0.messagingView.reloadDataWithCompletion { () -> Void in
                    _main.0.tableViewAutoScroll(force: true, animated: false)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(100 * NSEC_PER_MSEC)), dispatch_get_main_queue()) { () -> Void in
                        completion(_main.0, _main.1)
                        _main.0.viewWillLayoutSubviews()
                        self.preloadWindow.rootViewController = nil
                    }
                }
        }
        
    }
    
}