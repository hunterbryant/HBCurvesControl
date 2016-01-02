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
	
	var controlPoints: [CGPoint]?
	@IBInspectable var primaryColor: UIColor?
	@IBInspectable var secondaryColor: UIColor?
	
	
	//MARK: Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	convenience init(primaryColor: UIColor?, secondaryColor: UIColor?) {
		self.init(frame: CGRectZero)
		
		if let primary = primaryColor, let secondary = secondaryColor {
			self.primaryColor = primary
			self.secondaryColor = secondary
		} else {
			print("Colors were not given. Returned nil.")
		}
	}

}
