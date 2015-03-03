//
//  WholeCameraViewController.swift
//  Pods
//
//  Created by AJ Caldwell on 2/14/15.
//
//

import UIKit
import DBCamera
import PrintlnMagic

/// basic data
public typealias CaptureData = (image: UIImage, metaData: [NSObject : AnyObject])

public enum Facing {
	case Selfie
	case Scene
}

/**
	The main value type taken and returned. 
*/
public struct Moment {
	var selfie: CaptureData?
	var scene: CaptureData?
	var isWhole: Bool {
		return selfie != nil && scene != nil
	}
	var nextNeededCapture: Facing? {
		if selfie == nil {
			return .Selfie
		} else if scene == nil {
			return .Scene
		} else {
			return nil
		}
	}
	
	mutating func add(capture: CaptureData, forFacing facing: Facing) {
		switch facing {
			case .Selfie:
				self.selfie = capture
			case .Scene:
				self.scene = capture
		}
	}
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
	public private(set) var moment: Moment
	// DBCameraViewController does not expose custom cameras. So we need to keep a reference to customCamera to call buildInterface() later.
	public private(set) lazy var customCamera: WholeCameraView = WholeCameraView.self.initWithFrame(UIScreen.mainScreen().bounds) as! WholeCameraView
	public private(set) lazy var cameraViewController: DBCameraViewController = DBCameraViewController(delegate: self, cameraView: self.customCamera)

	required public init(coder aDecoder: NSCoder) {
		self.moment = Moment()
		super.init(coder: aDecoder)
	}
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		self.moment = Moment()
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	public convenience init(delegate: WholeCameraViewControllerDelegate?) {
		self.init(delegate: delegate, moment: Moment())
	}
	public init(delegate: WholeCameraViewControllerDelegate?, moment: Moment) {
		self.delegate = delegate
		self.moment = moment
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
		/* Algorithm
			// handle image data
				curentFacing = customCamera.facingControl.facing
				
				if image is not nil
					if image is not square
						switchFromController(from: cameraViewController, to: cropController(image))
						return
					else 
						self.moment.add(capture: (image, metaData), currentfacing)
					end
				end
			
			// determine what to do next 
				switch moment.nextNededCapture()
					case .Selfie
						customCamera.facingControl.facing = .Selfie
						go back to camera controller
					case .Scene
						customCamera.facingControl.facing = .Scene
						go back to camera controller
					case nil
						dismiss everything // we are done
				end
		*/
	}
	public func dismissCamera(cameraViewController: AnyObject!) {
		magic(cameraViewController)
	}
}
