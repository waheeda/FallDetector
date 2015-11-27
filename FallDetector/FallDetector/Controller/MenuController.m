//
//  MenuController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/25/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MenuController.h"
#import "AppDelegate.h"
#import "MonitoringController.h"
@interface MenuController ()

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

-(void)didSelectMenu:(NSDictionary*)menu{
    SEL selector = NSSelectorFromString([menu objectForKey:@"selector"]);
    if([self respondsToSelector:selector])
        [self performSelector:selector withObject:nil afterDelay:0];
}

-(void)openHomeController{
    
    UINavigationController *navigationController = [[AppDelegate getInstance] getMenuContainer].centerViewController;
    
    if([navigationController.topViewController isKindOfClass:[MonitoringController class]]){
        [[[AppDelegate getInstance] getMenuContainer] setMenuState:MFSideMenuStateClosed];
        return;
    }
    
    [navigationController popToRootViewControllerAnimated:NO];
    [[[AppDelegate getInstance] getMenuContainer] setMenuState:MFSideMenuStateClosed];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
