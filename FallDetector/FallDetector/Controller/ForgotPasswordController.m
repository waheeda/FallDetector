//
//  ForgotPasswordController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/17/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ForgotPasswordController.h"
#import "Alert.h"

@interface ForgotPasswordController ()

@end

@implementation ForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=false;
    [super loadServices:@[@(ServiceTypeContacts),@(ServiceTypeUser)]];
    [self setupNavBar];
    self.title=@"Forgot Password";
    // Do any additional setup after loading the view.
}

-(void)forgotPassword:(NSString*)email{
    [self showLoader];
    [service.user forgotPasswordOfEmail:email withSuccess:^(id response) {
        [self hideLoader];
        NSString *status = [response objectForKey:@"status"];
        if([status isEqualToString:@"Empty"])
            [Alert show:@"Error" andMessage:[response objectForKey:@"msg"]];
        
        else if([status isEqualToString:@"Email Sent"])
            [Alert show:@"Success" andMessage:[response objectForKey:@"msg"]];
        
        else{
            [Alert show:@"Error" andMessage:@"The record of this email does not exist."];
        }
        
    } andfailure:^(NSError *error) {
        [super onServiceResponseFailure:error];
    }];
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
