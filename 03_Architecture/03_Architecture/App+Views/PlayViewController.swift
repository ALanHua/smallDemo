//
//  PlayViewController.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/11/19.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController:  UIViewController{
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var noRecordingLabel: UILabel!
    @IBOutlet var activeItemElements: UIView!
    
    var audioPlayer:Player?
    var recording: Recording? {
        didSet {
            updateForChangedRecording()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        updateForChangedRecording()
        
        NotificationCenter.default.addObserver(self, selector: #selector(storeChanged(notification:)), name: Store.changedNotification, object: nil)
        
    }
    
    @objc func storeChanged(notification: Notification) {
        guard let item = notification.object as? Item,
            item === recording else {
            updateForChangedRecording()
        }
    }
    
    func updateForChangedRecording(){
        if let r = recording,let url = r.fileURL {
            audioPlayer = Player(url: url, update: { [weak self] time in
                if let t = time {
                    self?.updateProgressDisplays(progress: t, duration: self?.audioPlayer?.duration ?? 0)
                }else{
                    self?.recording = nil
                }
            })
            if let ap = audioPlayer {
                updateProgressDisplays(progress: 0, duration: ap.duration)
                title = r.name
                nameTextField?.text = r.name
                activeItemElements?.isHidden = false
                noRecordingLabel?.isHidden = true
            }else{
                recording = nil
            }
        }else {
            updateProgressDisplays(progress: 0, duration: 0)
            audioPlayer = nil
            title = ""
            activeItemElements?.isHidden = true
            noRecordingLabel?.isHidden = false
        }
        
        
    }

    func updateProgressDisplays(progress: TimeInterval, duration: TimeInterval){
        progressLabel?.text = timeString(progress)
        durationLabel?.text = timeString(duration)
        progressSlider?.maximumValue = Float(duration)
        progressSlider?.value = Float(progress)
        updatePlayButton()
    }
    
    func updatePlayButton(){
        if audioPlayer?.isPlaying == true {
            playButton?.setTitle(.pause, for: .normal)
        } else if audioPlayer?.isPaused == true {
            playButton?.setTitle(.resume, for: .normal)
        } else {
            playButton?.setTitle(.play, for: .normal)
        }
    }
}

fileprivate extension String {
    static let uuidPathKey = "uuidPath"
    //    MARK:字符串翻译，本地化
    static let pause = NSLocalizedString("Pause", comment: "")
    static let resume = NSLocalizedString("Resume playing", comment: "")
    static let play = NSLocalizedString("Play", comment: "")
}
