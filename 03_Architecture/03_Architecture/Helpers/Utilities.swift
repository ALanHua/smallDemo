//
//  Utilities.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/8/1.
//  Copyright © 2018年 none. All rights reserved.
//
import Foundation
import UIKit

private let formatter: DateComponentsFormatter = {
   
    let formatter = DateComponentsFormatter()
    // 设置显示格式为9:31:30
    formatter.unitsStyle = .positional
    // 设置0占位符格式 09:31:30
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [
        .hour,
        .minute,
        .second
    ]
    return formatter
}()

func timeString(_ time:TimeInterval) -> String {
    return formatter.string(from: time)!
}


extension UIViewController {
    func modalTextAlert(title:String,accept:String = .ok,
        cancel:String = .cancel,placeholder:String,
        callback:@escaping (String?)->()) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = placeholder}
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel){ _ in
            callback(nil)
        })
        
        alert.addAction(UIAlertAction(title: accept, style: .default){ _ in
            callback(alert.textFields?.first?.text)
        })
        present(alert, animated: true)
    }
}


fileprivate extension String {
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}
