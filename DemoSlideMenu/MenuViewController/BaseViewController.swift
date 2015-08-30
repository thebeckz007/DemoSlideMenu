//
//  BaseViewController.swift
//  DemoSlideMenu
//
//  Created by Phan Anh Duy on 7/9/15.
//  Copyright (c) 2015 Phan Anh Duy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var menuVC: MenuViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func openSlideMenu() {
        if (menuVC != nil) {
            menuVC!.openMenu();
        }
    }
}
