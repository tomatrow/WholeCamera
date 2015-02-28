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
public class WholeCameraView : DBCameraView {
	lazy var overlay = DBCameraCropView()
	
	// TODO: Add a switch representing selfie/scene
	
	
	internal func buildInterface() {
		overlay.frame = bounds
		overlay.cropRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
		addSubview(overlay)
		defaultInterface()
	}
}

