//
//  MenuStoryBoardSegue.swift
//  PovertyChallenge
//
//  Created by david  beckz on 7/8/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

import UIKit

class MenuStoryBoardSegue: UIStoryboardSegue {
    override func perform() {
        var srcVC: MenuViewController = self.sourceViewController as! MenuViewController
        let destNav: UINavigationController = self.destinationViewController as! UINavigationController;
        
        srcVC.goto(toView: destNav);
    }
}
