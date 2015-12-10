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
    //[[ContactsManager sharedInstance] addContacts];
    [self.navigationController setNavigationBarHidden:NO];
    [self setupWhiteNavBAr];
    self.title=@"All Contacts";
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
    [self openMonitoringController];
    
}

//-(void)saveContactsRemotely{
//    for(int i=0;i<2;i++){
//        Contact *contact = [Contact new];
//        [contact set:[[(ContactView*)self.view selectedContacts] objectAtIndex:i]];
//    }
//    [service.contact addContactofEmail:[UserDefaults getEmail] andContact:<#(Contact *)#> withSuccess:^(id response) {
//        
//    } andfailure:^(NSError *error) {
//        
//    }];
//}

-(void)saveSelectedContactsInUserDefaults{
    if([[(ContactView*)self.view selectedContacts] count]>=1)
        [UserDefaults setEmergencyContacts:[(ContactView*)self.view selectedContacts]];
}

-(void)openMonitoringController{
    [[AppDelegate getInstance] showMonitoringController];
}


@end
