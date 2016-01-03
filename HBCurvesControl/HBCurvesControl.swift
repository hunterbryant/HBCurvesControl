
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
	
	@IBInspectable var primaryColor: UIColor?
	@IBInspectable var secondaryColor: UIColor?
	@IBInspectable var bgColor: UIColor?
	@IBInspectable var lineThickness: CGFloat = 2
	
	var controlPoints: [CGPoint]?
	var curve: HBCurvesControlCurve?
	
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

	func setup() {
		// Remove all subviews
		let views = self.subviews
		for view in views {
			view.removeFromSuperview()
		}
		
		//let width = self.bounds.width
		//let height = self.bounds.height
		
		curve!.drawCurve()
		
	}
}








