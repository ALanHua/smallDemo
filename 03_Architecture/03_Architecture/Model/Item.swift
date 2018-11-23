//
//  Item.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/8/5.
//  Copyright © 2018年 none. All rights reserved.
//

import Foundation

class Item {
    // UUID 8-4-4-4-12 32位的十六进制序列
    let uuid : UUID
    private(set) var name:String
    weak var store:Store?
    weak var parent:Folder?{
        didSet{
            store = parent?.store
        }
    }
    
    var uuidPath: [UUID] {
        var path = parent?.uuidPath ?? []
        path.append(uuid)
        return path
    }
    
    
    init(name:String,uuid:UUID) {
        self.name = name
        self.uuid = uuid
        self.store = nil
    }
    
    func saveName(_ newName:String) {
        name = newName
        if let p = parent {
            let (oldIndex,newIndex) = p.reSort(changedItem: self)
            store?.save(self, userInfo: [
                Item.changeReasonKey : Item.renamed,
                Item.oldValueKey : oldIndex,
                Item.newValueKey : newIndex
            ])
        }
    }
    
    func deleted() {
        parent = nil
    }
    
    func item(atUUIDPath path: ArraySlice<UUID>) -> Item? {
        guard let first = path.first,
        first == uuid else {
            return nil
        }
        return self
    }
    
}

extension Item {
    static let changeReasonKey = "reason"
    static let newValueKey = "newValue"
    static let oldValueKey = "oldValue"
    static let parentFolderKey = "parentFolder"
    static let renamed = "renamed"
    static let added = "added"
    static let removed = "removed"
}
