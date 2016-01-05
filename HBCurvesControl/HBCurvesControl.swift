
//
//  HBCurvesControl.swift
//  HBCurvesControl
//
//  Created by Hunter Bryant on 1/2/16.
//  Copyright © 2016 Hunter Bryant. All rights reserved.
//

import UIKit

class HBCurvesControl: UIView {
	
	//MARK: Properties
	
	let primaryColor: UIColor = UIColor(red: 101/255, green: 241/255, blue: 224/255, alpha: 1.0)
	let secondaryColor: UIColor = UIColor(red: 113/255, green: 121/255, blue: 140/255, alpha: 1.0) /* #71798c */
	let bgColor: UIColor = UIColor(red: 34/255, green: 38/255, blue: 51/255, alpha: 1.0) /* #222633 */

	let lineThickness: CGFloat = 2
	let curvesMargin = CGFloat(30)
	
	var controlPoints: [CGPoint]?
	var curve: HBCurvesControlCurve?
	
	var sliderArray: [UISlider]? = []
	
	//MARK: Initialization
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	func initialize() {
		self.curve = HBCurvesControlCurve(delegate: self)
		self.controlPoints = [CGPoint(x: 0, y: 0), CGPoint(x: 0.25, y: 0.25), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.75, y: 0.75), CGPoint(x: 1, y: 1)]
	}
	
	//MARK: Functions
	
	//MARK: Slider Setup Functions
	func slidersWillLoad() {
		for index in 0...4 {
			
			//TODO: Transforming the slider 90 degrees causes some tracking issues with the slider.  The thumb itself tracks slower than your finger's movement.  This causes a small gittery effect when some of the sliders are first touched.
			
			let newSlider = UISlider(frame: CGRectZero)
			newSlider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
			newSlider.value = (1.0 / 4) * Float(index)
			newSlider.addTarget(self, action: "sliderChanged:", forControlEvents: .TouchDragInside)
			newSlider.addTarget(self, action: "sliderChanged:", forControlEvents: .TouchDragOutside)
			newSlider.addTarget(self, action: "sliderChanged:", forControlEvents: .ValueChanged)
			newSlider.addTarget(self, action: "sliderChanged:", forControlEvents: .TouchDown)
			newSlider.continuous = false
			newSlider.hidden = true
			newSlider.maximumTrackTintColor = secondaryColor
			newSlider.minimumTrackTintColor = secondaryColor
			//newSlider.thumbTintColor = primaryColor
			
			self.addSubview(newSlider)
			sliderArray!.insert(newSlider, atIndex: index)
		}
	}
	
	func slidersWillAppear() {
		for index in sliderArray! {
		
			let width = self.bounds.width - curvesMargin*2
			let xPos = (width*CGFloat((sliderArray?.indexOf(index))!)/4)+curvesMargin-15
			let height = self.bounds.height - curvesMargin*2 + 30
			
			let sliderFrame = CGRect(x: xPos, y: 15, width: 30, height: height)
			
			index.frame = sliderFrame
			index.hidden = false
			
		}
	}
	
	func slidersWillLayoutSubviews() {
		for index in sliderArray! {
			
			let width = self.bounds.width - curvesMargin*2
			let xPos = (width*CGFloat((sliderArray?.indexOf(index))!)/4)+curvesMargin-15
			let height = self.bounds.height - curvesMargin*2 + 30
			
			let sliderFrame = CGRect(x: xPos, y: 15, width: 30, height: height)
			index.setMaximumTrackImage(nil, forState: .Normal)
			index.minimumTrackTintColor = UIColor.clearColor()
			
			index.setThumbImage(UIImage(named: "slider-cap.png"), forState: .Normal)
			
			index.frame = sliderFrame
			index.hidden = false
			
		}
	}

	func setup() {

		// Remove all subviews
		let views = self.subviews
		for view in views {
			view.removeFromSuperview()
		}
		
		self.controlPoints = [CGPoint(x: 0, y: 0), CGPoint(x: 0.25, y: 0.25), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.75, y: 0.75), CGPoint(x: 1, y: 1)]

	}
	
	override func drawRect(rect: CGRect) {
		self.clearsContextBeforeDrawing = true

		let context: CGContextRef = UIGraphicsGetCurrentContext()!
		let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
		
		
		//Horizontal Lines
		CGContextSetLineWidth(context, 1.0)
		CGContextMoveToPoint(context, curvesMargin, curvesMargin)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, curvesMargin)
		
		CGContextMoveToPoint(context, curvesMargin, ((self.bounds.height-2*curvesMargin)/4)+curvesMargin)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, ((self.bounds.height-2*curvesMargin)/4)+curvesMargin)
		
		CGContextMoveToPoint(context, curvesMargin, ((self.bounds.height-2*curvesMargin)/2)+curvesMargin)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, ((self.bounds.height-2*curvesMargin)/2)+curvesMargin)
		
		CGContextMoveToPoint(context, curvesMargin, (3*(self.bounds.height-2*curvesMargin)/4)+curvesMargin)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, (3*(self.bounds.height-2*curvesMargin)/4)+curvesMargin)
		
		CGContextMoveToPoint(context, curvesMargin, self.bounds.height-curvesMargin)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, self.bounds.height-curvesMargin)
		
		//Vertical Lines
		for index in sliderArray! {
			
			let width = self.bounds.width - curvesMargin*2
			let xPos = (width*CGFloat((sliderArray?.indexOf(index))!)/4)+curvesMargin-15
			let height = self.bounds.height - curvesMargin*2
			
			CGContextMoveToPoint(context, xPos+15, 30)
			CGContextAddLineToPoint(context, xPos+15, height+curvesMargin)
			
		}

		
		CGContextSetStrokeColor(context, CGColorGetComponents(secondaryColor.CGColor))
		CGContextStrokePath(context)
		
		curve!.drawCurve(rect, inContext: context, withColorSpace: colorSpace)
		
	}
	
	func sliderChanged(sender: UISlider) {
		curve = nil
		self.curve = HBCurvesControlCurve(delegate: self)
		
		getSliderValues()
		
		self.setNeedsDisplay()
	}
	
	func getSliderValues() {
		controlPoints! = []
		for index in sliderArray! {
			let setValue = index.value
			let currentIndex = Int(sliderArray!.indexOf(index)!)
			let scaledIndex =  CGFloat(currentIndex)/CGFloat(sliderArray!.count-1)
			self.controlPoints?.append(CGPoint(x: scaledIndex, y: CGFloat(setValue)))
		}
	}
}







