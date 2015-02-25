//
//  WholeCam.swift
//  Pods
//
//  Created by AJ Caldwell on 1/1/15.
//
//

import Foundation
import DBCamera


/// The value type
public protocol Moment {
	var frontImage : UIImage { get }
	var backImage : UIImage { get }
	var frontMetaData : [NSObject : AnyObject] { get }
	var backMetaData : [NSObject : AnyObject] { get }
}

/// WholeCamera ViewController delegate protocol.
public protocol WholeCameraViewControllerDelegate {
	/**
		Tells the delegate when the image is ready to use
		
		:param: wholeViewController The controller object managing the WholeCamera interface.
		:param: moment The images and metadata.
	*/
	func cameraDidFinish(cameraViewController: UIViewController, moment: Moment)
	
	/// Tells the delegate when the camera must be dismissed
	func dismissCamera(cameraViewController: UIViewController)
}

/**
	The WholeCameraViewController.

	- It's really a subclass of DBCamera's main view controller with the DBCameraViewControllerDelegate set to itself.
	- We perform DBCamera's function twice, then return.
*/
public class WholeCameraViewController : DBCameraViewController {
	
}

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

