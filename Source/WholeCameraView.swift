//
//  WholeCameraView.swift
//  Pods
//
//  Created by AJ Caldwell on 2/26/15.
//
//

import UIKit
import DBCamera


/// Custom interface.
/// It only needs the following buttons:  library, capture, SelfieSceneControl
/// It has to show a square overlay

public enum Facing {
	case Selfie
	case Scene
}

public protocol FacingControl {
	var facing: Facing? { get }
}

public class WholeCameraView : DBCameraView {
	public lazy var overlay = DBCameraCropView()
	public lazy var facingControl: UISegmentedControl = UISegmentedControl(items: ["selfie", "scene"])
	
	internal func buildInterface() {
		overlay.frame = bounds
		overlay.cropRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
		addSubview(overlay)
		// TODO: Actually add the button to the interface.
		defaultInterface()
	}
}

extension UISegmentedControl: FacingControl {
	public var facing: Facing? {
		if let selectedSegmentTitle = titleForSegmentAtIndex(selectedSegmentIndex) {
			switch selectedSegmentTitle.lowercaseString {
			case "selfie":
				return .Scene
			case "scene":
				return .Selfie
			default:
				return nil
			}
		} else {
			return nil
		}
	}
}