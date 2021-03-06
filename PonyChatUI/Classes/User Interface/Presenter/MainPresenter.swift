//
//  MainPresenter.swift
//  PonyChatUIProject
//
//  Created by 崔 明辉 on 15/10/27.
//
//

import Foundation

extension PonyChatUI.UserInterface {
    
    public class MainPresenter {
        
        public let interactor = MainInteractor()
        weak var userInterface: MainViewController?
        
        init() {
            interactor.delegate = self
        }
        
        func insertMessage(count: Int) {
            if let userInterface = userInterface {
                userInterface.tableViewInsertRows(count)
            }
        }
        
        func appendMessage(count: Int) {
            if let userInterface = userInterface {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    userInterface.tableViewAppendRows(count)
                })
            }
        }
        
        func removeMessage(atIndex: Int) {
            if let userInterface = userInterface {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    userInterface.tableViewRemoveRow(atIndex)
                })
            }
        }
        
    }
    
}