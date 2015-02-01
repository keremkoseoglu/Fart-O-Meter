//
//  ViewController.swift
//  Fart-O-Meter
//
//  Created by Dr. Kerem Koseoglu on 19.01.2015.
//  Copyright (c) 2015 Dr. Kerem Koseoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var txtVelocity : UITextField!
	@IBOutlet var txtDuration : UITextField!
	@IBOutlet var txtMelody : UITextField!
	
	var fart : Fart!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		fart = Fart()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func recordClick(Object : AnyObject) {
		fart.record()
	}
	
	@IBAction func stopClick(Object : AnyObject) {
		fart.stopAndAnalyse()
		txtVelocity.text = String(fart.velocity)
		txtDuration.text = String(fart.duration)
		txtMelody.text = String(fart.melody)
	}
	
	@IBAction func playClick(Object : AnyObject) {
		fart.play()
	}

	
}

