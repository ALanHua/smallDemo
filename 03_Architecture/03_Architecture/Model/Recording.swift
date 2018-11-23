//
//  Recording.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/8/5.
//  Copyright © 2018年 none. All rights reserved.
//

import Foundation

class Recording: Item,Codable{
    
    var fileURL :URL?{
        return store?.fileURL(for: self)
    }
    
    
    override init(name: String, uuid: UUID) {
        super.init(name: name, uuid: uuid)
    }
    
    override func deleted() {
        store?.removeFile(for: self)
        super.deleted()
    }
    
    enum RecordingKeys : CodingKey {case name,uuid}
    
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: RecordingKeys.self)
        try c.encode(name, forKey: .name)
        try c.encode(uuid, forKey: .uuid)
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: RecordingKeys.self)
        let uuid = try c.decode(UUID.self, forKey: .uuid)
        let name = try c.decode(String.self, forKey: .name)
        super.init(name: name, uuid: uuid)
    }
    
    
}
