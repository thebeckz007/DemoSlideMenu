//
//  menu4ViewController.swift
//  DemoSlideMenu
//
//  Created by david  beckz on 8/29/15.
//  Copyright (c) 2015 Thebeckz007. All rights reserved.
//

import UIKit

class menu4ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Dortmund";
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

    @IBAction func btnSlideMenu_Tapped(sender: AnyObject) {
        self.openSlideMenu();
    }
}
