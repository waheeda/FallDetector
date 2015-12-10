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
#import "AboutController.h"
#import "EmergencyContactsDisplayController.h"
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


-(void)openAboutController{
    
    UINavigationController *navigationController = [[AppDelegate getInstance] getMenuContainer].centerViewController;
    
    if([navigationController.topViewController isKindOfClass:[AboutController class]]){
        [[[AppDelegate getInstance] getMenuContainer] setMenuState:MFSideMenuStateClosed];
        return;
    }
    AboutController *aboutController = [[AboutController alloc] init];
    [self pushController:aboutController];
    
}

-(void)openEmergencyContactsDisplayController{
    
    UINavigationController *navigationController = [[AppDelegate getInstance] getMenuContainer].centerViewController;
    
    if([navigationController.topViewController isKindOfClass:[EmergencyContactsDisplayController class]]){
        [[[AppDelegate getInstance] getMenuContainer] setMenuState:MFSideMenuStateClosed];
        return;
    }
    EmergencyContactsDisplayController *emergencyController = [[EmergencyContactsDisplayController alloc] init];
    [self pushController:emergencyController];
    
}

-(void)logout{
    [super showLogoutAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushController:(id)viewController{
    UINavigationController *navigationController = [[AppDelegate getInstance] getMenuContainer].centerViewController;
    [navigationController pushViewController:viewController animated:NO];
    [[[AppDelegate getInstance] getMenuContainer] setMenuState:MFSideMenuStateClosed];
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
