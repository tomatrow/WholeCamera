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
	lazy var cameraViewController: WholeCameraViewController = WholeCameraViewController(delegate: self)
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let nav = UINavigationController(rootViewController: cameraViewController)
		cameraViewController.setFullScreenMode()
		nav.navigationBarHidden = true
		presentViewController(nav, animated: false, completion: nil)
	}
}

extension ViewController: WholeCameraViewControllerDelegate {
	func cameraDidFinish(cameraViewController: UIViewController, moment: Moment) {
		println()
	}
	func dismissCamera(cameraViewController: UIViewController) {
		println()
	}
}

