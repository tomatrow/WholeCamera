//
//  WholeCameraViewController.swift
//  Pods
//
//  Created by AJ Caldwell on 2/14/15.
//
//

import UIKit
import DBCamera

public enum Facing {
	case Front
	case Back
	
	var opposite: Facing {
		switch self {
			case .Front:
				return .Back
			case .Back:
				return .Front
		}
	}
}

/// The value type
public struct Moment {
	public var frontImage : UIImage?
	public var backImage : UIImage?
	public var frontMetaData : [NSObject : AnyObject]?
	public var backMetaData : [NSObject : AnyObject]?
	// TODO: Be able to mutate easily.
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
	-
*/
public class WholeCameraViewController: UIViewController {
	public var delegate: WholeCameraViewControllerDelegate?
	public private(set) var moment: Moment
	
	public var capturePriority: Facing
	public convenience init(delegate: WholeCameraViewControllerDelegate?) {
		self.init(delegate: delegate, moment: Moment())
	}
	required public convenience init(coder aDecoder: NSCoder) {
		assert(true, "Cannot initalize with coder.")
		self.init(delegate: nil)
	}
	public init(delegate: WholeCameraViewControllerDelegate?, moment: Moment) {
		self.moment = Moment()
		self.delegate = delegate
		self.capturePriority = .Front
		super.init()
	}
}


extension WholeCameraViewController: DBCameraViewControllerDelegate {
	 public func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
		// Never use segue
		
		/*
		if VC == libraryVC
		use cropcontroller on image
		return
		else if VC == captureVC
		open shutter
		let currentPicture := crop picture based on cameraView
		else if VC == cropVC
		let currentPicture := the image passed to us
		end
		
		if metaData.facing == front
		moment.frontPicture = currentPicture
		moment.frontData = currentData
		else if metaData.facing == back
		moment.backPicture = currentPicture
		moment.backData = currentData
		end
		
		if has one picture
		show the capture controller with the missing position
		else if has both pictures
		call delegate
		end
		
		*/
	}
	
}