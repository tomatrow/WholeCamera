//
//  ViewController.swift
//  iOS Example
//
//  Created by AJ Caldwell on 1/19/15.
//  Copyright (c) 2015 Idiotic Design and Development. All rights reserved.
//

import UIKit
import WholeCamera

class ViewController: UIViewController {

	lazy var cropVC = {
		() -> CropViewController in
		
		let fakeMeta = Dictionary<String,AnyObject>()
		let selfie = (UIImage(named: "oko1.jpg")!,fakeMeta)
		let scene = (UIImage(named: "oko2.jpg")!,fakeMeta)
		let moment = Moment(selfie: selfie, scene: scene)
		
		let cropVC = CropViewController(moment:moment)
		
		cropVC.enableGestures(true)
		
		return cropVC
    }()

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		weak var weakSelf = self
		self.presentViewController(self.cropVC,animated: true) { () -> Void in
			println("Presented")
			println(weakSelf?.cropVC.sourceImage)
			println(weakSelf?.cropVC.previewImage)
		}
	}

}

