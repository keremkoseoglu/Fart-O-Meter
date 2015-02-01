//
//  Fart.swift
//  Fart-O-Meter
//
//  Created by Dr. Kerem Koseoglu on 19.01.2015.
//  Copyright (c) 2015 Dr. Kerem Koseoglu. All rights reserved.
//

import Foundation

class Fart {
	
	var velocity: Int
	var duration: Int
	var melody: Int
	private var audio: Audio
	
	init() {
		velocity = 0
		duration = 0
		melody = 0
		audio = Audio()
	}
	
	func record() {
		audio.startRecording()
	}
	
	func stopAndAnalyse() {
		audio.stopRecording()
		velocity = audio.getScaledPeakPower(100)
		duration = Int(audio.getDuration())
		
		melody = 2
	}
	
	func play() {
		audio.play()
	}
	
}