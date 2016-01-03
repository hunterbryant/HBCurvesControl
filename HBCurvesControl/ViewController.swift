//
//  ViewController.swift
//  HBCurvesControl
//
//  Created by Hunter Bryant on 1/2/16.
//  Copyright © 2016 Hunter Bryant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var curvesControl: HBCurvesControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		curvesControl.slidersWillLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		curvesControl.slidersWillAppear()
	}
	
	override func viewWillLayoutSubviews() {
		curvesControl.slidersWillLayoutSubviews()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

