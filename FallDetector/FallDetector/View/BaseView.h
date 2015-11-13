//
//  BaseView.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseController;

@interface BaseView : UIView

@property(nonatomic,weak) BaseController *controller;

-(void) viewDidLoad;
-(void) viewWillAppear;
-(void) viewDidAppear;
-(void) viewWillDisappear;
-(void) viewDidLayoutSubviews ;

@end
