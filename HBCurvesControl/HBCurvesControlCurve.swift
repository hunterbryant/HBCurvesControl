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
	
	var delegate: HBCurvesControl?
	
	var lineColor: UIColor?
	
	//MARK: Initialization
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init() {
		super.init()
		lineColor = delegate?.primaryColor
		self.lineWidth = CGFloat(delegate!.lineThickness)
	}
	
	//MARK: Functions

	func drawCurve() {
		
		let width = delegate?.bounds.width
		let height = delegate?.bounds.height
		let margin = CGFloat(20)
		
		let x0 = CGFloat(margin)
		let x1 = CGFloat(((width! - (2*margin))/4)+margin)
		let x2 = CGFloat(((width! - (2*margin))/2)+margin)
		let x3 = CGFloat(((width! - (2*margin))/4)*3+margin)
		let x4 = CGFloat(width! - margin)
		
		self.moveToPoint(CGPoint(x: x0, y: margin))
		self.addLineToPoint(CGPoint(x: x1, y: ((height! - (2*margin))/4)+margin))
		self.addLineToPoint(CGPoint(x: x2, y: ((height! - (2*margin))/2)+margin))
		self.addLineToPoint(CGPoint(x: x3, y: ((height! - (2*margin))/4)*3+margin))
		self.addLineToPoint(CGPoint(x: x4, y: height! - margin))
		self.stroke()
		
	}
}





