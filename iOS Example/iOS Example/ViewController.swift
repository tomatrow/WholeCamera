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
	
	let vc = TestViewController()
	
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

		self.presentViewController(vc, animated: false) {
			println("YAY")
		}
	}

}

