//
//  CropViewController.swift
//  Pods
//
//  Created by AJ Caldwell on 1/1/15.
//
//

import DBCamera
import TGCameraViewController

public final class CropViewController: DBCameraBaseCropViewController, DBCameraCropRect, MomentCropController {

	public var delegate : ViewControllerDelegate?
	public var moment: Moment {
		didSet {
			self.previewImage = nil
		}
	}
	public var activeCrop = CropMode.Scene
	public var overlay = true
	
	private lazy var cropView = DBCameraCropView()
	private lazy var frames : (p:CGRect, l:CGRect) = {
		() -> (CGRect, CGRect) in
		let frame = self.frameView.frame
		let cropX = (frame.width - 320) * 0.5
		let p = CGRect(x: cropX, y: (frame.height - 360) * 0.5, width: 320, height: 320)
		let l = CGRect(x: cropX, y: (frame.height - 240) * 0.5, width: 320, height: 240)
		return (p,l)
		}()
	
	public init(moment : Moment) {
		self.moment = moment
		super.init()
		
		self.cropRect = CGRect(x: 0, y: 0, width: 320, height: 320)
		self.minimumScale = 0.2
		self.maximumScale = 10
		self.createInterface()
	}
	
	public required init(coder aDecoder: NSCoder) {
		let data = (UIImage(),Dictionary<String, AnyObject>())
		self.moment = Moment(selfie: data, scene: data)
		assert(false, "Need to use the desegnated init.")
		super.init(coder: aDecoder)
	}
	public override required init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		let data = (UIImage(),Dictionary<String, AnyObject>())
		self.moment = Moment(selfie: data, scene: data)
		assert(false, "Need to use the desegnated init.")
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		print("Loaded \(self)")
		
		self.view.userInteractionEnabled = true
		self.view.backgroundColor = UIColor.redColor()
		
		self.cropRect = self.previewImage.size.width > self.previewImage.size.height ? frames.l : frames.p
	
		self.view.clipsToBounds = true
	}
	
	public override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		self.cropRect =  self.frames.p
		self.reset(true)
	}
	
	public func createInterface() {
		let mainScreenBounds = UIScreen.mainScreen().bounds
		let viewHeight = mainScreenBounds.height - 64 - 40
		
		self.cropView.frame = CGRect(x: 0, y: 64, width: mainScreenBounds.width, height: viewHeight)
		
		self.frameView = self.cropView
	}
	
	public func cropImage() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> () in
			let resultRef: Unmanaged<CGImageRef> = self.newTransformedImage(self.imageView.transform,
				sourceImage: self.sourceImage.CGImage,
				sourceSize: self.sourceImage.size,
				sourceOrientation: self.sourceImage.imageOrientation,
				outputWidth: self.outputWidth != 0 ? self.outputWidth : self.sourceImage.size.width,
				cropRect: self.cropRect,
				imageViewSize: self.imageView.bounds.size)
			dispatch_async(dispatch_get_main_queue(), {
				() -> () in
				let transform = UIImage(CGImage : resultRef.takeRetainedValue(), scale: 1.0, orientation: UIImageOrientation.Up)
				var imageData : ImageData? = (transform!, Dictionary<String,AnyObject>())
				var fake : ImageData?
			})
		})
	/*
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		CGImageRef resultRef = [self newTransformedImage:self.imageView.transform
		sourceImage:self.sourceImage.CGImage
		sourceSize:self.sourceImage.size
		sourceOrientation:self.sourceImage.imageOrientation
		outputWidth:self.outputWidth ? self.outputWidth : self.sourceImage.size.width
		cropRect:self.cropRect
		imageViewSize:self.imageView.bounds.size];
		dispatch_async(dispatch_get_main_queue(), ^{
			UIImage *transform =  [UIImage imageWithCGImage:resultRef scale:1.0 orientation:UIImageOrientationUp];
			CGImageRelease(resultRef);
			transform = [_filterMapping[@(_selectedFilterIndex.row)] imageByFilteringImage:transform];
			[_delegate camera:self didFinishWithImage:transform withMetadata:self.capturedImageMetadata];
		});
	});
	*/
	}
}


// MARK: Convenience
public extension CropViewController {
	
	override public var sourceImage : UIImage! {
		get {
			return self.activeImage.image
		}
		set {
			assert(false, "Tried to change CropViewController.moment using "
				+ "superclass property DBCameraBaseCropViewController.sourceImage.")
		}
	}
	
	private var activeImage : ImageData {
		switch self.activeCrop {
			case .Scene :
				return moment.scene
			case .Selfie :
				return moment.selfie
		}
	}
	private var inactiveImage : ImageData {
		switch self.activeCrop {
		case .Scene :
			return moment.selfie
		case .Selfie :
			return moment.scene
		}
	}
}