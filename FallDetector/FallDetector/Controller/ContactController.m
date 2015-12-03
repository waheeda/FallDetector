//
//  ContactController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/27/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ContactController.h"
#import "ContactsManager.h"
#import "ContactView.h"
#import "UserDefaults.h"
#import "MonitoringController.h"
#import "AppDelegate.h"
@interface ContactController ()

@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    [(ContactView*)self.view setContacts:[[ContactsManager sharedInstance] contactNames]];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setupImageNavBAr];
    self.title=@"All Contacts";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupImageNavBAr{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.rightBarButtonItem = [self createRightDoneButton];
    self.navigationItem.hidesBackButton = YES;
}

-(UIBarButtonItem*)createRightDoneButton {
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneBtnTap)];
    return anotherButton;
}

-(void)onDoneBtnTap{
    [self saveSelectedContactsInUserDefaults];
    [self openMonitoringController];
    
}

-(void)saveSelectedContactsInUserDefaults{
    if([[(ContactView*)self.view selectedContacts] count]>=1)
        [UserDefaults setEmergencyContacts:[(ContactView*)self.view selectedContacts]];
}

-(void)openMonitoringController{
    [[AppDelegate getInstance] showMonitoringController];
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
