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
#import "Alert.h"
#import "Contact.h"
@interface ContactController ()

@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    [(ContactView*)self.view setContacts:[[ContactsManager sharedInstance] contactNames]];
    //[[ContactsManager sharedInstance] addContactsOldWayWithName:@"E honda" number:@"0354" email:@"g@gmail.com"];
    [self.navigationController setNavigationBarHidden:NO];
    [self setupWhiteNavBAr];
    self.title=@"All Contacts";
    [super loadServices:@[@(ServiceTypeContacts),@(ServiceTypeUser)]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupWhiteNavBAr{
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
    if([[(ContactView*)self.view selectedContacts] count]<2){
        [Alert show:@"Alert" andMessage:@"Select atleast two contacts"];
        return;
    }
    [self saveSelectedContactsInUserDefaults];
    [self saveContactsInDB];
    
    
}

-(void)saveContactsInDB{
    
    Contact *firstContact = [Contact new];
    Contact *secondContact = [Contact new];
    [firstContact set:[[(ContactView*)self.view selectedContacts] firstObject]];
    [secondContact set:[[(ContactView*)self.view selectedContacts] lastObject]];
    [self showLoader];
    __weak typeof(self) weakSelf = self;
    __weak typeof(service) weakService = service;
    [weakService.contact deleteContactOfEmail:[UserDefaults getEmail] withSuccess:^(id response) {
        [weakService.contact addContactofEmail:[UserDefaults getEmail] andContact:firstContact withSuccess:^(id response) {
            NSLog(@"First block Success");
            [weakService.contact addContactofEmail:[UserDefaults getEmail] andContact:secondContact withSuccess:^(id response) {
                [weakSelf hideLoader];
                [weakSelf openMonitoringController];
            } andfailure:^(NSError *error) {
                [super onServiceResponseFailure:error];
            }];
        } andfailure:^(NSError *error) {
            [super onServiceResponseFailure:error];
        }];
    } andfailure:^(NSError *error) {
        [super onServiceResponseFailure:error];
    }];
    
}

-(void)saveSelectedContactsInUserDefaults{
    if([[(ContactView*)self.view selectedContacts] count]>=1)
        [UserDefaults setEmergencyContacts:[(ContactView*)self.view selectedContacts]];
}

-(void)openMonitoringController{
    [[AppDelegate getInstance] showMonitoringController];
}


@end
