//
//  HBCurvesControlCurve.swift
//  HBCurvesControl
//
//  Created by Hunter Bryant on 1/2/16.
//  Copyright © 2016 Hunter Bryant. All rights reserved.
//

import UIKit

class HBCurvesControlCurve: UIBezierPath {
	
	//MARK: Properties
	
	var delegateView: HBCurvesControl?
	var lineColor: UIColor?
	
	//MARK: Initialization
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	init(delegate: HBCurvesControl) {
		super.init()
		self.delegateView = delegate
		self.lineColor = delegateView!.primaryColor
		self.lineWidth = delegateView!.lineThickness
	}
	
	//MARK: Functions

	func drawCurve(rect: CGRect, inContext context: CGContextRef, withColorSpace colorSpace: CGColorSpaceRef) {
		
		let width = delegateView!.bounds.width
		let height = delegateView!.bounds.height
		let margin = delegateView!.curvesMargin
		let vertMargin = margin + 15
		
		print("\(width)")
		
		let x0 = CGFloat(margin)
		let x1 = CGFloat(((width - (2*margin))/4)+margin)
		let x2 = CGFloat(((width - (2*margin))/4)*2+margin)
		let x3 = CGFloat(((width - (2*margin))/4)*3+margin)
		let x4 = CGFloat(width - margin)
		
		self.moveToPoint(CGPoint(x: x0, y: height-vertMargin))
		self.addLineToPoint(CGPoint(x: x1, y: ((height - (2*vertMargin))/4)*3+vertMargin))
		self.addLineToPoint(CGPoint(x: x2, y: ((height - (2*vertMargin))/2)+vertMargin))
		self.addLineToPoint(CGPoint(x: x3, y: ((height - (2*vertMargin))/4)+vertMargin))
		self.addLineToPoint(CGPoint(x: x4, y: vertMargin))
		
		self.lineColor!.setStroke()
		self.stroke()
		
		CGContextAddPath(context, self.CGPath)
		
	}
}






