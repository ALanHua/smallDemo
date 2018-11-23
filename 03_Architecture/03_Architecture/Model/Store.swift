//
//  Store.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/8/5.
//  Copyright © 2018年 none. All rights reserved.
//

import Foundation

// 这个类不能被继承和重写
final class Store{
//  private
    static private let documentDirectory = getDocumentDirectoryURL()
    let baseURL:URL?
    let placeholder:URL? // 单元测试使用
    private(set) var rootFolder: Folder // 根文件
//  public
    static let changedNotification = Notification.Name("StoreChanged")
    //  单例
    static  let shared = Store(url: documentDirectory)
    init(url:URL?) {
        self.baseURL     = url
        self.placeholder = nil
        
        if let u = url,
            let data = try? Data(contentsOf: u.appendingPathComponent(.storeLocation)),
            let folder = try? JSONDecoder().decode(Folder.self, from: data){
            self.rootFolder = folder
        }else{
            self.rootFolder = Folder(name: "", uuid: UUID())
        }
        // 将rootFolder的存储指定为自己
       self.rootFolder.store = self
    }
    // 拿到文件的存储路径
    func fileURL(for recording:Recording) -> URL? {
        return baseURL?.appendingPathComponent(recording.uuid.uuidString + ".m4a") ?? placeholder
    }
    // 存储json表
    func save(_ notifying:Item,userInfo: [AnyHashable: Any]) {
        if let url = baseURL,
           let data = try? JSONEncoder().encode(rootFolder){
            try! data.write(to: url.appendingPathComponent(.storeLocation))
        }
        NotificationCenter.default.post(name: Store.changedNotification, object: notifying,userInfo: userInfo)
    }
    
    func item(atUUIDPath path:[UUID]) -> Item? {
       return rootFolder.item(atUUIDPath: path[0...])
    }
    
    func removeFile(for recording: Recording) {
        if let url = fileURL(for: recording),
            url != placeholder{
            _ = try? FileManager.default.removeItem(at: url)
        }
    }
    
}

extension Store {
    
    static private func getDocumentDirectoryURL() -> URL {
        let fileManager = FileManager.default
        let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return url
    }
}

fileprivate extension String {
    static let storeLocation = "store.json"
}
