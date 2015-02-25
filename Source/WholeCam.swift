//
//  WholeCam.swift
//  Pods
//
//  Created by AJ Caldwell on 1/1/15.
//
//

import Foundation
import DBCamera

public class TestViewController : UIViewController {
	
	let segueConfiguration = {
		(segueController: AnyObject!) -> () in
		if let segueVC = segueController as? DBCameraSegueViewController {
			segueVC.forceQuadCrop = true
			segueVC.filtersView.removeFromSuperview()
			
			println(segueVC)
		}
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.redColor()
	}
	public override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		self.openCameraFromViewController()
	}
	
	private func openCameraFromViewController() {
	
		let cameraView: WholeCameraView = WholeCameraView.self.initWithFrame(UIScreen.mainScreen().bounds) as! WholeCameraView
		// Using a camera settings block causes the preview to not work.
		let cameraController = WholeCameraViewController(delegate: self, cameraView: cameraView)
		let cameraContainer = DBCameraContainerViewController(delegate: self)
		cameraContainer.cameraViewController = cameraController
		
		cameraController.useCameraSegue = false
		
		cameraContainer.setFullScreenMode()
		
		cameraView.buildInterface()
	
		let nav = UINavigationController(rootViewController: cameraContainer)
		nav.setNavigationBarHidden(true, animated: false)
		
		self.presentViewController(nav, animated: true) {
		}
	}
}

/// Custom interface.
/// It only needs the following buttons:  library, capture, SelfieSceneControl
/// It has to show a square overlay
public class WholeCameraView : DBCameraView {
	lazy var overlay = DBCameraCropView()

	internal func buildInterface() {
		overlay.frame = bounds
		overlay.cropRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
		addSubview(overlay)
		defaultInterface()
	}
	
	// TODO: On trigger, close shutter. 
	// When DBCameraViewControllerDelegate recives data, 
	//     if has both pictures
	//			dismiss everything
	//     else
	//			restart session / flip camera (not sure what order)
	//			open shutter
}

