//
//  WholeCameraViewController.swift
//  Pods
//
//  Created by AJ Caldwell on 2/14/15.
//
//

import UIKit
import DBCamera


class WholeCameraViewController: UIViewController {
	var delegate: WholeCameraViewControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


extension WholeCameraViewController: DBCameraViewControllerDelegate {
	 func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
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