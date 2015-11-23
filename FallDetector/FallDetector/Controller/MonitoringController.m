//
//  MonitoringController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/23/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MonitoringController.h"

@interface MonitoringController ()

@end

@implementation MonitoringController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=false;
    //[self setupImageNavBAr];
    [self setupNavBar];
    self.title = @"Montoring";
    // Do any additional setup after loading the view.
}

-(void)setupImageNavBAr{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:101/255.0f green:101/255.0f blue:101/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = YES;
    //[self.navigationController.navigationBar.backItem setTitle:@""];
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 0, self.navigationController.navigationBar.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"logo.png"];
    [self.navigationItem.titleView setFrame:CGRectMake(50, 0, 0, self.navigationController.navigationBar.frame.size.height)];
    [self.navigationItem setTitleView:imgView];
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
