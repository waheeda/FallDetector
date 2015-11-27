//
//  IntroController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/17/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "InfoController.h"
#import "IntroController.h"
#import "MonitoringController.h"

#import "MenuController.h"
@interface InfoController ()
@end

@implementation InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=true;

}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=true;
}

-(void)openIntroController{
    IntroController *controller =[[IntroController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
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
