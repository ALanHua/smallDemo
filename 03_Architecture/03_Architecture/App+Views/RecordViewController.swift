//
//  RecordViewController.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/11/19.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController:  UIViewController{
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:Recorder?
    var folder: Folder? = nil
    var recording = Recording(name: "", uuid: UUID())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = timeString(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        audioRecorder = folder?.store?.fileURL(for: recording).flatMap({ url in
            Recorder(url: url, update: { (time) in
                if let t = time {
                    self.timeLabel.text = timeString(t)
                } else{
                    self.dismiss(animated: true)
                }
            })
        })
        
        if audioRecorder == nil {
            dismiss(animated: true)
        }
    
    }
    
    @IBAction func stop(_ sender: UIButton) {
        audioRecorder?.stop()
        modalTextAlert(title: .saveRecording, accept: .save, placeholder: .nameForRecording) {string in
            if let title = string {
                self.recording.saveName(title)
                self.folder?.add(self.recording)
            }else{
                self.recording.deleted()
            }
            self.dismiss(animated:true)
        }
    }
    
}

fileprivate extension String {
    static let saveRecording = NSLocalizedString("Save recording", comment: "Heading for audio recording save dialog")
    static let save = NSLocalizedString("Save", comment: "Confirm button text for audio recoding save dialog")
    static let nameForRecording = NSLocalizedString("Name for recording", comment: "Placeholder for audio recording name text field")
}
