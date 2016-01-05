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
		let vertMargin = margin
		
		let x0 = CGFloat(margin)
		let x1 = CGFloat(((width - (2*margin))/4)+margin)
		let x2 = CGFloat(((width - (2*margin))/4)*2+margin)
		let x3 = CGFloat(((width - (2*margin))/4)*3+margin)
		let x4 = CGFloat(width - margin)
		
		var pointsArray: [AnyObject] = []
		
		let vertVal1 = (1-delegateView!.sliderArray![0].value)
		let transformedVert1 = (CGFloat(vertVal1)*(height-(2*vertMargin)))+vertMargin
		let point1 = CGPoint(x: x0, y: transformedVert1)
		pointsArray.append(NSValue(CGPoint: point1))
		
		let vertVal2 = (1-delegateView!.sliderArray![1].value)
		let transformedVert2 = (CGFloat(vertVal2)*(height-(2*vertMargin)))+vertMargin
		let point2 = CGPoint(x: x1, y: transformedVert2)
		pointsArray.append(NSValue(CGPoint: point2))
		
		
		let vertVal3 = (1-delegateView!.sliderArray![2].value)
		let transformedVert3 = (CGFloat(vertVal3)*(height-(2*vertMargin)))+vertMargin
		let point3 = CGPoint(x: x2, y: transformedVert3)
		pointsArray.append(NSValue(CGPoint: point3))
		
		
		let vertVal4 = (1-delegateView!.sliderArray![3].value)
		let transformedVert4 = (CGFloat(vertVal4)*(height-(2*vertMargin)))+vertMargin
		let point4 = CGPoint(x: x3, y: transformedVert4)
		pointsArray.append(NSValue(CGPoint: point4))
		
		let vertVal5 = (1-delegateView!.sliderArray![4].value)
		let transformedVert5 = (CGFloat(vertVal5)*(height-(2*vertMargin)))+vertMargin
		let point5 = CGPoint(x: x4, y: transformedVert5)
		pointsArray.append(NSValue(CGPoint: point5))
		
		self.moveToPoint(point1)
		self.addLineToPoint(point2)
		self.addLineToPoint(point3)
		self.addLineToPoint(point4)
		self.addLineToPoint(point5)
		
		let newPath: UIBezierPath = UIBezierPath.interpolateCGPointsWithHermite(pointsArray, closed: false)
		
		self.CGPath = newPath.CGPath
		
		self.lineColor!.setStroke()
		self.stroke()
		
		CGContextAddPath(context, self.CGPath)
		
	}
}






