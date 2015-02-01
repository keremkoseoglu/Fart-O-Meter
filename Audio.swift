//
//  Audio.swift
//  Fart-O-Meter
//
//  Created by Dr. Kerem Koseoglu on 19.01.2015.
//  Copyright (c) 2015 Dr. Kerem Koseoglu. All rights reserved.
//

import AVFoundation
import Foundation

class Audio {
	
	private var audioPlayer : AVAudioPlayer!
	private var audioRecorder : AVAudioRecorder!
	private var url : NSURL!
	private var error : NSError?
	private var defVolume : Float!
	
	init() {
	}
	
	func startRecording(){
		
		var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
		audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		audioSession.setActive(true, error: nil)
		
		var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
		var str =  documents.stringByAppendingPathComponent("fart.caf")
		url = NSURL.fileURLWithPath(str as String)
		
		var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
			AVSampleRateKey:44100.0,
			AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
			AVLinearPCMBitDepthKey:16,
			AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
			
		]
		
		println("url : \(url)")
		
		audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings, error: &error)
		if let e = error {
			println(e.localizedDescription)
		} else {
			
			audioRecorder.record()
		}
		
	}
	
	func stopRecording() {
		audioRecorder.stop()
		audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
		audioPlayer.meteringEnabled = true
		audioPlayer.prepareToPlay()
		
		defVolume = audioPlayer.volume
		audioPlayer.volume = 0
		
		audioPlayer.play()
		//NSThread.sleepForTimeInterval(4)
	}
	
	func getVolume() -> Float {
		return audioPlayer.volume
	}
	
	func getDuration() -> NSTimeInterval {
		return audioPlayer.duration
	}
	
	func getAveragePower() -> Float {
		audioPlayer.updateMeters()
		return audioPlayer.averagePowerForChannel(0)
	}
	
	func getPeakPower() -> Float {
		
		var m : Int
		var f : Float
		var ret : Float
		
		audioPlayer.updateMeters()
		
		ret = -500
		
		for m = 0; m < audioPlayer.numberOfChannels; m++ {
			f = audioPlayer.peakPowerForChannel(m)
			if (f > ret) { ret = f }
		}
		
		return ret
	}
	
	func getScaledPeakPower(MaxScale: Int) -> Int {
		var v : Int
		
		v = Int(getPeakPower())
		return (v + 160) * MaxScale / 160
	}
	
	func play() {
		audioPlayer.volume = defVolume
		audioPlayer.prepareToPlay()
		audioPlayer.play()
	}
	
}