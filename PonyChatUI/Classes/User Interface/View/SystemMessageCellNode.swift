//
//  SystemMessageCellNode.swift
//  PonyChatUIProject
//
//  Created by 崔 明辉 on 15/10/29.
//
//

import Foundation
import AsyncDisplayKit

extension PonyChatUI.UserInterface {
    
    class SystemMessageCellNode: MessageCellNode {
        
        let textNode = ASTextNode()
        let backgroundNode = ASDisplayNode()
        
        var typedMessageItem: PonyChatUI.Entity.SystemMessage? {
            if let messageItem = messageItem as? PonyChatUI.Entity.SystemMessage {
                return messageItem
            }
            else {
                return nil
            }
        }
        
        override func configureNodes() {
            super.configureNodes()
            backgroundNode.backgroundColor = UIColor(white: 0.800, alpha: 1.0)
            backgroundNode.layer.cornerRadius = 4.0
            contentNode.addSubnode(backgroundNode)
            contentNode.addSubnode(textNode)
        }
        
        override func configureDatas() {
            super.configureDatas()
            if let messageItem = typedMessageItem {
                let attributedString = bundleImageAttributedString(NSAttributedString(string: messageItem.text,
                    attributes: messagingConfigure.systemTextStyle))
                textNode.attributedString = attributedString
            }
        }
        
        override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
            let maxWidth = constrainedSize.width - 32 * 2
            textNode.measure(CGSize(width: maxWidth, height: constrainedSize.height))
            contentNode.frame = CGRectMake(0, 0, constrainedSize.width, textNode.calculatedSize.height + 5.0 * 2 + messagingConfigure.cellGaps)
            return CGSizeMake(constrainedSize.width, textNode.calculatedSize.height + 5.0 * 2 + messagingConfigure.cellGaps)
        }
        
        override func layout() {
            textNode.frame = CGRect(x: constrainedSizeForCalculatedSize.width / 2.0 - textNode.calculatedSize.width / 2.0, y: 5.0, width: textNode.calculatedSize.width, height: textNode.calculatedSize.height)
            backgroundNode.frame = CGRect(x: textNode.frame.origin.x - 8.0, y: textNode.frame.origin.y - 3.0, width: textNode.frame.size.width + 16.0, height: textNode.frame.size.height + 6.0)
        }
        
        func bundleImageAttributedString(originAttributedString: NSAttributedString) -> NSAttributedString {
            let regularExpression = try! NSRegularExpression(pattern: "\\[(.*?)\\]", options: NSRegularExpressionOptions())
            let matches = regularExpression.matchesInString(originAttributedString.string, options: NSMatchingOptions(), range: NSMakeRange(0, originAttributedString.string.characters.count))
            let mutableAttributedString: NSMutableAttributedString = originAttributedString.mutableCopy() as! NSMutableAttributedString
            for match in matches.reverse() {
                let imageName = (originAttributedString.string as NSString).substringWithRange(match.rangeAtIndex(1))
                if let image = UIImage(named: imageName, inBundle: nil, compatibleWithTraitCollection: nil) {
                    if let font = messagingConfigure.systemTextStyle[NSFontAttributeName] as? UIFont {
                        let imageHeight = min(image.size.height, font.ascender)
                        let centerOffset = (imageHeight - font.lineHeight) / 2.0
                        let s = NSTextAttachment()
                        s.image = image
                        s.bounds = CGRectMake(0, centerOffset, imageHeight, imageHeight)
                        let ss = NSAttributedString(attachment: s)
                        mutableAttributedString.replaceCharactersInRange(match.range, withAttributedString: ss)
                    }
                }
            }
            return mutableAttributedString.copy() as! NSAttributedString
        }
        
    }
    
}