
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
	let secondaryColor: UIColor = UIColor(red: 79/255, green: 111/255, blue: 142/255, alpha: 1.0)
	let bgColor: UIColor = UIColor(red: 53/255, green: 61/255, blue: 81/255, alpha: 1.0)
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
			newSlider.thumbTintColor = primaryColor
			
			self.addSubview(newSlider)
			sliderArray!.insert(newSlider, atIndex: index)
		}
	}
	
	func slidersWillAppear() {
		for index in sliderArray! {
		
			let width = self.bounds.width - curvesMargin*2
			let xPos = (width*CGFloat((sliderArray?.indexOf(index))!)/4)+curvesMargin-15
			let height = self.bounds.height - curvesMargin*2
			
			let sliderFrame = CGRect(x: xPos, y: 30, width: 30, height: height)
			index.frame = sliderFrame
			index.hidden = false
			
		}
	}
	
	func slidersWillLayoutSubviews() {
		for index in sliderArray! {
			
			let width = self.bounds.width - curvesMargin*2
			let xPos = (width*CGFloat((sliderArray?.indexOf(index))!)/4)+curvesMargin-15
			let height = self.bounds.height - curvesMargin*2
			
			let sliderFrame = CGRect(x: xPos, y: 30, width: 30, height: height)
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

	}
	
	override func drawRect(rect: CGRect) {
		self.clearsContextBeforeDrawing = true

		let context: CGContextRef = UIGraphicsGetCurrentContext()!
		let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
		
		CGContextSetLineWidth(context, 2.0)
		CGContextMoveToPoint(context, curvesMargin, curvesMargin+15)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, curvesMargin+15)
		
		CGContextMoveToPoint(context, curvesMargin, ((self.bounds.height-2*curvesMargin)/4)+curvesMargin+7)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, ((self.bounds.height-2*curvesMargin)/4)+curvesMargin+7)
		
		CGContextMoveToPoint(context, curvesMargin, ((self.bounds.height-2*curvesMargin)/2)+curvesMargin)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, ((self.bounds.height-2*curvesMargin)/2)+curvesMargin)
		
		CGContextMoveToPoint(context, curvesMargin, (3*(self.bounds.height-2*curvesMargin)/4)+curvesMargin-7)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, (3*(self.bounds.height-2*curvesMargin)/4)+curvesMargin-7)
		
		CGContextMoveToPoint(context, curvesMargin, self.bounds.height-curvesMargin-15)
		CGContextAddLineToPoint(context, self.bounds.width-curvesMargin, self.bounds.height-curvesMargin-15)
		
		CGContextSetStrokeColor(context, CGColorGetComponents(secondaryColor.CGColor))
		CGContextStrokePath(context)
		
		curve!.drawCurve(rect, inContext: context, withColorSpace: colorSpace)
		
	}
	
	func sliderChanged(sender: UISlider) {
		curve = nil
		self.curve = HBCurvesControlCurve(delegate: self)
		self.controlPoints = [CGPoint(x: 0, y: 0), CGPoint(x: 0.25, y: 0.25), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.75, y: 0.75), CGPoint(x: 1, y: 1)]
		
		self.setNeedsDisplay()
	}
}








