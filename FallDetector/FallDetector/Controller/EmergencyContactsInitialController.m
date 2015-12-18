//
//  EmergencyContactsInitialController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/26/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "EmergencyContactsInitialController.h"
#import "ContactsManager.h"
//#import "ContactController.h"

@interface EmergencyContactsInitialController ()

@end

@implementation EmergencyContactsInitialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchContacts{
    [super fetchContacts];
}
//-(void)openContactController{
//    [self hideLoader];
//    ContactController *contactsController = [ContactController new];
//    [self.navigationController pushViewController:contactsController animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
