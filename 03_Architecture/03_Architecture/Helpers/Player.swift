//
//  Player.swift
//  Recordings_MVC
//
//  Created by yhp on 2018/8/1.
//  Copyright © 2018年 none. All rights reserved.
//

import Foundation
import AVFoundation

class Player: NSObject,AVAudioPlayerDelegate {
    private var audioPlayer:AVAudioPlayer
    private var timer:Timer?
    private var update:(TimeInterval?)->()
    
    init?(url: URL, update:@escaping(TimeInterval?)->()) {
        do{
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch {
            return nil
        }
        
        if let player = try? AVAudioPlayer(contentsOf: url) {
            audioPlayer = player
            self.update = update
        }else{
            return nil
        }
        
        super.init()
        
        audioPlayer.delegate = self
    }
    
    deinit {
        timer?.invalidate()
    }
    
    /// 音频文件的总时长
    var duration:TimeInterval {
        return audioPlayer.duration
    }
    
    var isPlaying :Bool {
        return audioPlayer.isPlaying
    }

    var isPaused : Bool {
        return !audioPlayer.isPlaying && audioPlayer.currentTime > 0
    }
    
    func togglePlay() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            timer?.invalidate()
            timer = nil
        }else{
            audioPlayer.play()
            if let t = timer {
                t.invalidate()
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block:
                { [weak self] _ in
                    guard let s = self else{
                        return
                    }
                    s.update(s.audioPlayer.currentTime)
            })
            
        }
    }
    
    func setProgress(_ time:TimeInterval){
        audioPlayer.currentTime = time
    }
    
    
    
    //  MARK:AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.invalidate()
        timer = nil
        update(flag ? audioPlayer.currentTime : nil)
    }
    
}
