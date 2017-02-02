//
//  ViewController.swift
//  RotateFlipImage
//
//  Created by Sagar on 2/2/17.
//  Copyright © 2017 http://sagarrkothari.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imgV: UIImageView!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func btnRotateTapped(_ sender: Any) {
		self.imgV.image = self.imgV.image!.imageRotatedByDegrees(degrees: 90, flip: false)
	}

	@IBAction func btnFlipTapped(_ sender: Any) {
		self.imgV.image = self.imgV.image!.imageRotatedByDegrees(degrees: 0, flip: true)
	}
}

extension UIImage {
	
	public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage? {
		let radiansToDegrees: (CGFloat) -> CGFloat = {
			return $0 * (180.0 / CGFloat(M_PI))
		}
		let degreesToRadians: (CGFloat) -> CGFloat = {
			return $0 / 180.0 * CGFloat(M_PI)
		}
		
		// calculate the size of the rotated view's containing box for our drawing space
		let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
		let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
		rotatedViewBox.transform = t
		let rotatedSize = rotatedViewBox.frame.size
		
		// Create the bitmap context
		UIGraphicsBeginImageContext(rotatedSize)
		let bitmap = UIGraphicsGetCurrentContext()
		
		// Move the origin to the middle of the image so we will rotate and scale around the center.
		bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
		
		//   // Rotate the image context
		bitmap!.rotate(by: degreesToRadians(degrees));
		
		// Now, draw the rotated/scaled image into the context
		var yFlip: CGFloat
		
		if(flip){
			yFlip = CGFloat(-1.0)
		} else {
			yFlip = CGFloat(1.0)
		}
		
		bitmap!.scaleBy(x: yFlip, y: -1.0)
		let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
		bitmap!.draw(cgImage!, in: rect)
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage
	}
	
}
