//
//  MenuViewController.swift
//  PovertyChallenge
//
//  Created by david  beckz on 7/8/15.
//  Copyright (c) 2015 Appable. All rights reserved.
//

import UIKit

struct MenuItem {
    var key: String = "";
    var name: String = "";
    var icon: String = "";
    
    internal func initMenuItem(#key: String, name: String, icon: String) -> MenuItem {
        var instance: MenuItem = MenuItem();
        instance.key = key;
        instance.name = name;
        instance.icon = icon;
        
        return instance;
    }
}

enum MenuAnimation {
    case MenuAnimationSwipe;
    case MenuAnimationFloat;
}

// MARK: define some properties and values
let menuCellIdentifier: String = "MenuCell";

let colorSelected: UIColor = UIColor.whiteColor();
let colorUnselected: UIColor = UIColor.lightGrayColor();

// MARK: You should define key of all menus
let kMenu1: String = "kMenu1";
let kMenu2: String = "kMenu2";
let kMenu3: String = "kMenu3";
let kMenu4: String = "kMenu4";

// MARK: You should define all segues of all menus
let segueMenu1: String = "menu1Segue";
let segueMenu2: String = "menu2Segue";
let segueMenu3: String = "menu3Segue";
let segueMenu4: String = "menu4Segue";

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIGestureRecognizerDelegate {
    @IBOutlet weak var tbvMenus: UITableView!
    @IBOutlet weak var vContainner: UIView!
    @IBOutlet weak var btnOverMenu: UIButton!
    
    var arrMenus: Array<MenuItem> = Array();
    var menuSelected: MenuItem?
    var openedView: UINavigationController?;
    var panGestureSlideMenu: UIScreenEdgePanGestureRecognizer?;
    var panGestureSlideOverMenu: UIPanGestureRecognizer?;
    var menuAnimation: MenuAnimation = MenuAnimation.MenuAnimationSwipe;   // by default
    
    private var curTranslateX: CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // register group all cell
        tbvMenus.registerNib(UINib(nibName: menuCellIdentifier, bundle: nil), forCellReuseIdentifier: menuCellIdentifier);
        
        // set animation to slide menu
        menuAnimation = MenuAnimation.MenuAnimationFloat;
        
        // intial pangesture to trigger action open
        panGestureSlideMenu = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("onPanGesture:"));
        panGestureSlideMenu?.edges = UIRectEdge.Left;
        panGestureSlideMenu?.minimumNumberOfTouches = 1;
        panGestureSlideMenu?.delegate = self;
        
        // intial pangesture to trigger action close menu
        panGestureSlideOverMenu = UIPanGestureRecognizer(target: self, action: Selector("onPanGesture:"));
        panGestureSlideOverMenu?.minimumNumberOfTouches = 1;
        panGestureSlideOverMenu?.delegate = self;
        self.btnOverMenu.addGestureRecognizer(panGestureSlideOverMenu!);
        
        // initial all menus
        self.initialMenus();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: You should initial all menus which will be used
    // initial all menus
    private func initialMenus() {
        // Menu1
        let menu1: MenuItem = MenuItem(key: kMenu1, name: "Manchester United", icon: "");
        
        // Menu1
        let menu2: MenuItem = MenuItem(key: kMenu2, name: "Real Marid", icon: "");
        
        // Menu1
        let menu3: MenuItem = MenuItem(key: kMenu3, name: "Chelsea", icon: "");
        
        // Menu1
        let menu4: MenuItem = MenuItem(key: kMenu4, name: "Dortmund", icon: "");
        
        arrMenus = [menu1, menu2, menu3, menu4];
        
        // select Menu 1 at first by default
        menuSelected = menu1;
        
        tbvMenus.reloadData();
        
        // perform open Challenge page by default
        self.performSegueWithIdentifier(segueMenu1, sender: nil);
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }

    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenus.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuObj: MenuItem = arrMenus[indexPath.row] as MenuItem;
        
        let cell = tableView.dequeueReusableCellWithIdentifier(menuCellIdentifier, forIndexPath: indexPath) as? MenuCell;
        
        cell?.lblMenu.text = menuObj.name;
        cell?.lblNumber.hidden = true;
        if (menuObj.key == menuSelected?.key) {
            // selected
            cell?.imgSelected.hidden = false;
        } else {
            cell?.imgSelected.hidden = true;
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.None;
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // get object
        let menuObj: MenuItem = arrMenus[indexPath.row] as MenuItem;
        self.performMenu(menuObj: menuObj);
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var vTemp: UIView = UIView(frame: CGRectMake(0, 0, tbvMenus.bounds.width, 40));
        vTemp.backgroundColor = UIColor.clearColor();
        return vTemp;
    }
    
    // MARK: - MENU
    
    // perform action for selecting menu
    func performMenu(#menuObj: MenuItem) {
        menuSelected = menuObj;
        tbvMenus.reloadData();
        
        if (menuSelected?.key == kMenu1) {
            self.performSegueWithIdentifier(segueMenu1, sender: nil);
        } else if (menuSelected?.key == kMenu2) {
            self.performSegueWithIdentifier(segueMenu2, sender: nil);
        } else if (menuSelected?.key == kMenu3) {
            self.performSegueWithIdentifier(segueMenu3, sender: nil);
        } else if (menuSelected?.key == kMenu4) {
            self.performSegueWithIdentifier(segueMenu4, sender: nil);
        }
    }
    
    // go to this view
    // if toView and oepenedView is the same
    // we wiill do not nothing
    // else, we will cache toView and go to it
    func goto(#toView: UINavigationController) {
        if (openedView != toView) {
            // dismiss openedView
            openedView?.view .removeFromSuperview();
            
            // cache it
            openedView = toView;
            
            // set frame to toView
            openedView!.view.frame = vContainner.bounds;
            
            // add it as subview to view container
            vContainner.addSubview(openedView!.view);
            
            // cast toView to BaseViewController
            let baseVC: BaseViewController = toView.viewControllers.first as! BaseViewController;
            baseVC.menuVC = self;
            
            // add pangesture to this view
            self.addPangestureToView(baseView: baseVC);
        }
        
        self.closeMenu();
    }
    
    let animationDuration: NSTimeInterval = 0.4;
    let animationDelay: NSTimeInterval = 0.0;
    let springDamping: CGFloat = 0.6;
    let initialSpringVelocity: CGFloat = 0.6;
    let scaleViewContainner: CGFloat = 0.7;
    
    // perform open menu with animation
    func openMenu() {
        let menuWidth: CGFloat = CGRectGetWidth(self.tbvMenus.bounds);
        let translate: CGPoint = CGPointMake(menuWidth, 0);
        let transform: CGAffineTransform = self.transformWithAnimationToView(translation: translate);
        UIView.animateWithDuration(animationDuration,
            delay: animationDelay,
            usingSpringWithDamping: springDamping,
            initialSpringVelocity: initialSpringVelocity,
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
                self.vContainner.transform = transform;
            }, completion: { (finish) -> Void in
                if (finish == true) {
                    self.vContainner.bringSubviewToFront(self.btnOverMenu);
                }
        })
    }
    
    // perform close menu with animation
    func closeMenu() {
        UIView.animateWithDuration(animationDuration,
            delay: animationDelay,
            usingSpringWithDamping: springDamping + 1.0,
            initialSpringVelocity: initialSpringVelocity,
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
                self.vContainner.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            }, completion: { (finish) -> Void in
                if (finish == true) {
                    self.vContainner.sendSubviewToBack(self.btnOverMenu);
                }
        })
    }
    
    //
    @IBAction func btnOverMenu_Tapped(sender: AnyObject) {
        self.closeMenu();
    }
    
    // MARK: handle gesture
    
    // handle pangesture to open/ close menu
    func onPanGesture(gesture: UIPanGestureRecognizer) {
        //
        var translation: CGPoint = gesture.translationInView(self.view);
        translation.x += curTranslateX;
        var velocity: CGPoint = gesture.velocityInView(self.view);
        let gesState: UIGestureRecognizerState = gesture.state;
        
        switch (gesState) {
        case UIGestureRecognizerState.Began:
            curTranslateX = vContainner.transform.tx;
            break;
            
        case UIGestureRecognizerState.Changed:
            if (translation.x < 0) {
                translation.x = 0;  // min
            } else if (translation.x > self.tbvMenus.bounds.width + 20) {
                translation.x = self.tbvMenus.bounds.width + 20; // max
            }
            
            // calculator affine transform
            self.vContainner.transform = self.transformWithAnimationToView(translation: translation);
    
            break;
            
        case UIGestureRecognizerState.Ended:
            if (translation.x >= self.tbvMenus.bounds.width / 2.0) {
                // open slide menu
                self.openMenu();
            } else {
                // close slide menu
                self.closeMenu();
            }
            curTranslateX = 0;
            
            break;
            
        default:
            // do not nothing
            curTranslateX = 0;
            break;
        }
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
    // handle calculator position slide menu will go to
    // @return CGAffine
    private func transformWithAnimationToView(#translation: CGPoint) -> CGAffineTransform {
        var tranform: CGAffineTransform = CGAffineTransform();
        switch (menuAnimation) {
        case MenuAnimation.MenuAnimationSwipe:
            tranform = CGAffineTransformMakeTranslation(translation.x, 0);
            break;
            
        case MenuAnimation.MenuAnimationFloat:
            let menuWidth: CGFloat = CGRectGetWidth(self.tbvMenus.bounds);
            let containnerWidth: CGFloat = CGRectGetWidth(self.vContainner.bounds);
            var scale: CGFloat = 1 - (((1 - self.scaleViewContainner) * translation.x) / menuWidth);
            let scaledContainnerHorizontalOffset: CGFloat = (translation.x - (containnerWidth - scale * containnerWidth) / 2.0) / self.scaleViewContainner;
            
            // transform translation
            let transTranslation: CGAffineTransform = CGAffineTransformMakeTranslation(scaledContainnerHorizontalOffset, 0);
            
            // transform scale
            let transScale: CGAffineTransform = CGAffineTransformMakeScale(scale, scale);
            
            // merge transform translation and scale
            tranform = CGAffineTransformConcat(transTranslation, transScale);
            break;
        }
        
        return tranform;
    }
    
    private func addPangestureToView(#baseView: UIViewController) {
        if (panGestureSlideMenu != nil) {
            // remove pan gesture from this view
            baseView.view.removeGestureRecognizer(panGestureSlideMenu!);
            
            // add pan gesture to this view
            baseView.view.addGestureRecognizer(panGestureSlideMenu!);
        } // if
    }
}
