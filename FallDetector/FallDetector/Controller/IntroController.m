//
//  IntroController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/18/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "IntroController.h"
#import "LoginController.h"

@interface IntroController ()

@end

@implementation IntroController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)showLoginController{
    LoginController *loginController = [[LoginController alloc] init];
    [self.navigationController pushViewController:loginController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBarHidden=true;
}

-(void)viewDidAppear:(BOOL)animated{
   
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
