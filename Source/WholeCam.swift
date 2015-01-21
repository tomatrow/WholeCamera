//
//  WholeCam.swift
//  Pods
//
//  Created by AJ Caldwell on 1/1/15.
//
//

import Foundation


public struct Moment {
	public var selfie : ImageData
	public var scene : ImageData
	public init(selfie: ImageData, scene: ImageData) {
		self.selfie = selfie
		self.scene = scene
	}
	public init(images: (front:UIImage, back:UIImage), withSameMetaData moment:Moment) {
		self.selfie = (images.front, moment.selfie.metaData)
		self.scene = (images.back, moment.scene.metaData)
	}
}

public typealias ImageData = (image: UIImage, metaData:Dictionary<String,AnyObject>)

public protocol ViewControllerDelegate {
	func camera(#camera:UIViewController, didFinishWithImages images:Moment)
	func dimissCamera()
}

public enum CropMode {
	case Selfie, Scene
}
public protocol MomentCropController {
	var moment: Moment { get }
	var activeCrop: CropMode { get }
	var overlay: Bool { get }
	var delegate : ViewControllerDelegate? { get set }
	
	init(moment : Moment)
}

//public protocol

/*

# Three (four) Controllers
* One master view controlller that is a state machine. 
	* http://khanlou.com/2015/01/finite-states-of-america/
* Outline
	* This entire thing is really just a slightly tweaked DBCamera. 
	* Just like in DBCamera, we call a master VC and that contains a Capture controller, which can call a library controller, and becore returning the captured image, we run them through a crop controller. 
	* The only differences are: 
		* being able to ask for more than one image
		* forcing the front or back camera. 
		* The interface has indicators on it. 
* Flow 
	* Master Controller is called to do: 
		* Selfie, Scene, or both 
		* Cropping is optional. 

## Master 
* Protocols
	* State 
	* StateManager
		* tranlateToState:fromState:




## Capture

## Gallery 

## Crop




*/



