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
#import "Alert.h"
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
    UIBarButtonItem *anotherButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onDoneBtnTap)];
    return anotherButton;
}

-(void)onDoneBtnTap{
    [self fetchContacts];
}

-(void) showNoSavedContactsAlert {
    [Alert show:@"No Contacts Found" andMessage:@"Emergency Contacts are not found in your contacts directory. Do you want to add them?\nWarning: Selecting no will result in deletion of your contacts from the app." cancelButtonTitle:@"Cancel" otherButtonTitle1:@"Yes" andOtherButtonTitle2:@"No" tag:2 WithDelegate:self];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        if(alertView.tag == 2){
            [self addContactsInMainDirectory];
            [self openContactsController];
        }
    }
    else if(buttonIndex==2){
        if(alertView.tag == 2){
            [UserDefaults clearEmergencyContacts];
            [self openContactsController];
        }
    }
    
}

-(void)addContactsInMainDirectory{
    NSMutableArray *contactsToAdd = [UserDefaults getEmergencyContacts];
    for(NSDictionary* contact in contactsToAdd){
        [[ContactsManager sharedInstance] addContactsOldWayWithName:[contact objectForKey:@"contact_name"] number:[contact objectForKey:@"number"] email:[contact objectForKey:@"email"]];
    }
    
}

-(void)fetchContacts{
    [super showLoader];
    [[ContactsManager sharedInstance] getContactsOldWayWithSelectedContacts:[UserDefaults getEmergencyContacts] andCallback:^(id result, int contactExistCount, NSError *error) {
        if(result){
            //[self showNoSavedContactsAlert];
            [self performSelectorOnMainThread:@selector(hideLoader) withObject:nil waitUntilDone:YES];
            if(contactExistCount<2){
                [self performSelectorOnMainThread:@selector(showNoSavedContactsAlert) withObject:nil waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(openContactsController) withObject:nil waitUntilDone:YES];
            }
        }
        else{
            [self performSelectorOnMainThread:@selector(onServiceResponseFailure:) withObject:error waitUntilDone:YES];
        }
        }];
}

-(void)openContactsController{
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
