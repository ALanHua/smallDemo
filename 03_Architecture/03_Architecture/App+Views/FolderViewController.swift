//
//  FolderViewController.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/11/19.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class FolderViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // ....
        
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ""
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        // .....
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 编辑表格按钮，默认是删除按钮
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // ....
        
    }
    
    // MARK: UIStateRestoring
    override func encodeRestorableState(with coder: NSCoder) {
        
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
    }
    
    
}


fileprivate extension String {
    static let uuidPathKey  = "uuidPath"
    static let showRecorder = "showRecorder"
    static let showPlayer   = "showPlayer"
    static let showFolder   = "showFolder"
    
    // 本地化字符串
    static let recordings   = NSLocalizedString("Recordings", comment: "Heading for the list of recorded audio items and folders.")
    static let createFolder = NSLocalizedString("Create Folder", comment: "Header for folder creation dialog")
    static let folderName   = NSLocalizedString("Folder Name", comment: "Placeholder for text field where folder name should be entered.")
    static let create       = NSLocalizedString("Create", comment: "Confirm button for folder creation dialog")
}
