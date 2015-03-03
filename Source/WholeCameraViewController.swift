//
//  WholeCameraViewController.swift
//  Pods
//
//  Created by AJ Caldwell on 2/14/15.
//
//

import UIKit
import DBCamera

/// basic data
public typealias captureData = (image: UIImage, metaData: [NSObject : AnyObject])

/**
	The main value type taken and returned. 
	- Communicates the following:
*/
public struct Moment {
	var selfie: captureData?
	var scene: captureData?
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
*/
public class WholeCameraViewController: UIViewController {
	public var delegate: WholeCameraViewControllerDelegate?
	public private(set) var moment: Moment = Moment(selfie: nil, scene: nil)
	// DBCameraViewController.cameraView does not return the set custom camera view.
	// So we need to keep a reference to customCamera to call buildInterface() later.
	public private(set) lazy var customCamera: WholeCameraView = WholeCameraView.self.initWithFrame(UIScreen.mainScreen().bounds) as! WholeCameraView
	public private(set) lazy var cameraViewController: DBCameraViewController = DBCameraViewController(delegate: self, cameraView: self.customCamera)

	required public init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	public init(delegate: WholeCameraViewControllerDelegate?) {
		self.delegate = delegate
		super.init()
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.blackColor()
		
		cameraViewController.isContained = true
		cameraViewController.useCameraSegue = false
		cameraViewController.containerDelegate = self
		
		addChildViewController(cameraViewController)
		
		customCamera.buildInterface() 
		view.addSubview(cameraViewController.view)
	}
}

extension WholeCameraViewController: DBCameraContainerDelegate {
	public func backFromController(fromController: AnyObject!) {
		switchFromController(fromController, toController: cameraViewController)
	}

	public func switchFromController(fromController: AnyObject!, toController controller: AnyObject!) {
		let to = controller as! UIViewController
		let from = fromController as! UIViewController
		
		to.view.alpha = 1
		to.view.transform = CGAffineTransformMakeScale(1, 1)
		addChildViewController(to)
		transitionFromViewController(from,
			toViewController: to,
			duration: 0.2,
			options: .TransitionCrossDissolve,
			animations: nil) {
				(finished: Bool) -> Void in
				from.removeFromParentViewController()
		}
	}
	
	public override func prefersStatusBarHidden() -> Bool {
		return true
	}
}

extension WholeCameraViewController: DBCameraViewControllerDelegate {
	 public func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
		println(cameraViewController)
		println(image)
		println(metadata)
		
		
		/*
		Two Options on Knowing what just got passed to us:
			Extend DBCameraControllers with a Selfie/Scene purpose property, so I can just know what the iamge is for.
			Just use Front/Back from the metaData.
		Face Detection (pleasantry):
			selfie's MUST have faces, scene can be whatever.
		*/
		
		
	}
	public func dismissCamera(cameraViewController: AnyObject!) {
		println(cameraViewController)
	}
}