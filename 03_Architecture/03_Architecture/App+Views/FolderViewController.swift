//
//  FolderViewController.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/11/19.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class FolderViewController: UITableViewController {
    
    var folder: Folder = Store.shared.rootFolder {
        didSet{
           tableView.reloadData()
            // 判断是不是根目录
            if folder === folder.store?.rootFolder{
                title = .recordings
            }else{
                title = folder.name
            }
        }
    }
    
    var selectedItem:Item?{
        if let indexPath = tableView.indexPathForSelectedRow {
            return folder.contents[indexPath.row]
        }
        return nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 支持导航栏返回按钮
        navigationItem.leftItemsSupplementBackButton = true
        // 设置返回按钮类型
        navigationItem.leftBarButtonItem = editButtonItem
        // 设置消息监听
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeNotification(_:)), name: Store.changedNotification, object: nil)
    }
    // MARK: - #selector
    @objc func handleChangeNotification(_ notification: Notification){
        if let item = notification.object as? Folder,item === folder{
            let reason = notification.userInfo?[Item.changeReasonKey] as? String
            if reason == Item.removed,let nc = navigationController{
                nc.setViewControllers(nc.viewControllers.filter{$0 !== self},
                                      animated: false )
            }else{
                folder = item
            }
        }
        // Handle changes to children of the current folder
        guard let userInfo = notification.userInfo,userInfo[Item.parentFolderKey]
            as? Folder === folder else {
            return
        }
        
        // Handle changes to contents
        if let changeReason = userInfo[Item.changeReasonKey] as? String{
            let oldValue = userInfo[Item.oldValueKey]
            let newValue = userInfo[Item.newValueKey]
            switch(changeReason,newValue,oldValue){
            case let(Item.removed, _ ,(oldIndex as Int)?):
                tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .right)
                
            case let(Item.added,(newIndex as Int)?,_ ):
                tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .left)
                
            case let(Item.removed,(newIndex as Int)?,(oldIndex as Int)):
                tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
                tableView.reloadRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
            default:
               tableView.reloadData()
            }
            
        }else{
            tableView.reloadData()
        }
        
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
