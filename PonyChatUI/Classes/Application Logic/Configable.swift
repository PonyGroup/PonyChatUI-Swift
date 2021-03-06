//
//  Configable.swift
//  PonyChatUIProject
//
//  Created by 崔 明辉 on 15/10/27.
//
//

import Foundation

extension PonyChatUI.UserInterface {
    
    public struct LongPressEntity {
        public let title: String
        public let executingBlock: (message: PonyChatUI.Entity.Message, chatViewController: PonyChatUI.UserInterface.MainViewController?) -> Void
        public init(title: String, executingBlock: (message: PonyChatUI.Entity.Message, chatViewController: PonyChatUI.UserInterface.MainViewController?) -> Void) {
            self.title = title
            self.executingBlock = executingBlock
        }
    }
    
    public struct Configure {
        
        public static var sharedConfigure: Configure = Configure()
        
        public var cellGaps: CGFloat = 8.0
        
        public var nicknameShow: Bool = false
        public var nicknameStyle = [String: AnyObject]()
        public var nicknameEdge = UIEdgeInsets(top: 4, left: 10, bottom: 2, right: 10)
        
        public var avatarSize = CGSize(width: CGFloat(40.0), height: CGFloat(40.0))
        public var avatarEdge = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        public var avatarCornerRadius: CGFloat = 0.0
        
        public var textStyle = [String: AnyObject]()
        public var textEdge = UIEdgeInsets(top: 14, left: 18, bottom: 11, right: 18)
        public var textBackgroundSender = UIImage(named: "SenderTextNodeBkg", inBundle: NSBundle(forClass: PonyChatUICore.self), compatibleWithTraitCollection: nil)!.resizableImageWithCapInsets(UIEdgeInsets(top: 28, left: 20, bottom: 15, right: 20), resizingMode: .Stretch)
        public var textBackgroundReceiver = UIImage(named: "ReceiverTextNodeBkg", inBundle: NSBundle(forClass: PonyChatUICore.self), compatibleWithTraitCollection: nil)!.resizableImageWithCapInsets(UIEdgeInsets(top: 28, left: 20, bottom: 15, right: 20), resizingMode: .Stretch)
        
        public var longPressItems = [LongPressEntity]()
        
        public var systemTextStyle = [String: AnyObject]()
        
        init() {
            textStyle = defaultTextStyle()
            nicknameStyle = defaultNicknameStyle()
            systemTextStyle = defaultSystemTextStyle()
        }
        
        func defaultTextStyle() -> [String: AnyObject] {
            let font = UIFont.systemFontOfSize(16)
            let pStyle = NSMutableParagraphStyle()
            pStyle.paragraphSpacing = 0.25 * font.lineHeight
            pStyle.lineSpacing = 6.0
            pStyle.hyphenationFactor = 1.0
            return [NSFontAttributeName: font, NSParagraphStyleAttributeName: pStyle]
        }
        
        func defaultNicknameStyle() -> [String: AnyObject] {
            let font = UIFont.systemFontOfSize(13)
            let color = UIColor.grayColor()
            return [NSFontAttributeName: font, NSForegroundColorAttributeName: color]
        }
        
        func defaultSystemTextStyle() -> [String: AnyObject] {
            let font = UIFont.systemFontOfSize(14)
            let color = UIColor.whiteColor()
            return [NSFontAttributeName: font, NSForegroundColorAttributeName: color]
        }
        
    }
    
}