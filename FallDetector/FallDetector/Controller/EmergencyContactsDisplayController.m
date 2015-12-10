//
//  EmergencyContactsDisplayController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/7/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "EmergencyContactsDisplayController.h"
#import "ContactController.h"
#import "UserDefaults.h"
#import "EmergencyContactsDisplayView.h"
#import "ContactsManager.h"
@interface EmergencyContactsDisplayController ()

@end

@implementation EmergencyContactsDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEmergencyContacts];
    self.navigationController.navigationBarHidden=false;
    [self setupRightButtonNavBar];
    self.title=@"Emergency Contacts";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)

-(void)setEmergencyContacts{
    [(EmergencyContactsDisplayView*)self.view setEmergencyContacts:[UserDefaults getEmergencyContacts]];
}

-(void)setupRightButtonNavBar{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:101/255.0f green:101/255.0f blue:101/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar.backItem setTitle:@""];
    self.navigationItem.rightBarButtonItem = [self createRightModifyButton];
}

-(UIBarButtonItem*)createRightModifyButton {
//    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemAdd target:self action:@selector(onDoneBtnTap)];
    UIBarButtonItem *anotherButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onDoneBtnTap)];
    return anotherButton;
}

-(void)onDoneBtnTap{
    [self fetchContacts];
    
}

-(void)fetchContacts{
    [super showLoader];
    if(!_contactsFetched){
        [[ContactsManager sharedInstance] getContactsOldWayWithCallback:^(id result, NSError *error) {
        
            
                _contactsFetched=true;
                    [self performSelectorOnMainThread:@selector(openContactsController) withObject:nil waitUntilDone:YES];
            //  [self openContactController];
            
//            else{
//                [self performSelectorOnMainThread:@selector(onServiceResponseFailure:) withObject:error waitUntilDone:YES];
//            }
        }];
    }
}

-(void)openContactsController{
    [self hideLoader];
    ContactController* contactController = [ContactController new];
    [self.navigationController pushViewController:contactController animated:YES];
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
