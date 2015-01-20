//
//  WholeCam.swift
//  Pods
//
//  Created by AJ Caldwell on 1/1/15.
//
//

import Foundation

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



