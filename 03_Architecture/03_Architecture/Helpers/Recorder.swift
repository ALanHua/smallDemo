//
//  Recorder.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/8/1.
//  Copyright © 2018年 none. All rights reserved.
//

import Foundation
import AVFoundation

final class Recorder:NSObject,AVAudioRecorderDelegate{
    
    private var audioRecorder:AVAudioRecorder?
    private var time: Timer?
    private var update:(TimeInterval?)->()
    
    let url:URL
    
    init?(url: URL, update: @escaping (TimeInterval?) -> ()){
        self.update = update
        self.url = url
        super.init()
       
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode:.default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            AVAudioSession.sharedInstance().requestRecordPermission { (allowed) in
                if allowed {
                    self.start(url)
                }else{
                    self.update(nil)
                }
            }
            
        } catch {
            return nil
        }
        
    }
    
    private func start(_ url: URL){
        let setting:[String:Any] = [
            AVFormatIDKey : kAudioFormatMPEG4AAC,
            AVSampleRateKey : 44100.0 as Float,
            AVNumberOfChannelsKey : 1
        ]
        
        if let recorder = try? AVAudioRecorder(url: url, settings: setting) {
            recorder.delegate = self
            audioRecorder = recorder
            recorder.record()
            time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.update(self.audioRecorder?.currentTime)
            })
        }else{
            update(nil)
        }
        
    }
    
    func stop() {
        audioRecorder?.stop()
        time?.invalidate()
    }
    
    // MARK:AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            stop()
        }else{
            update(nil)
        }
    }
    
}

