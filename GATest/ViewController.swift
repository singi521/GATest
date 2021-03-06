//
//  ViewController.swift
//  GATest
//
//  Created by vincentyen on 4/29/15.
//  Copyright (c) 2015 Fun Anima Co., Ltd. All rights reserved.
//

import UIKit


class ViewController: GAITrackedViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        super.screenName = "About Screen"
        
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.send(GAIDictionaryBuilder.createScreenView().build())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreate d.
    }

    

    @IBAction func onTappedButton(sender: AnyObject) {
        var tracker = GAI.sharedInstance().defaultTracker
        var dict = GAIDictionaryBuilder.createEventWithCategory("ui_action", action: "button_press", label: "play", value: 0.1).build()
        //
        
        
        tracker.send(dict)
        
        
        GAI.sharedInstance().dispatch()
        
    }
    
    @IBAction func onTappedCreateCategory(sender: AnyObject) {
        var tracker = GAI.sharedInstance().defaultTracker
        
        var dict2 = GAIDictionaryBuilder.createEventWithCategory("Travel", action: "OpenCamera", label: "Label1", value: 1.0).build()
        
        tracker.send(dict2)
    }
    
    @IBAction func onTappedException(sender: AnyObject) {
        var tracker = GAI.sharedInstance().defaultTracker
        var err = GAIDictionaryBuilder.createExceptionWithDescription("知道錯我還輸入幹嘛", withFatal: 1.0).build()
        tracker.send(err)
    }
    
    @IBAction func onTappedCrash(sender: AnyObject) {
        var userInfo = ["age":12]

        var e = NSException(name:"啥名字.", reason:"閃腿閃退了！", userInfo:userInfo)
        e.raise()        
    }
}

