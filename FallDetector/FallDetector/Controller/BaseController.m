//
//  BaseController.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "BaseController.h"
#import "BaseView.h"
#import "Service.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Alert.h"
#import "DashboardController.h"
#import "LoginController.h"
#import "UserDefaults.h"
#import "IntroController.h"
#import "GoogleManager.h"
#import "FacebookManager.h"
#define TEXT_LOG_OUT                    @"Logout"
#define MESSAGE_LOGOUT_CONFIRMATION     @"Are you sure you want to logout?"
#define BUTTON_TITLE_OK         @"Ok"
#define BUTTON_TITLE_CANCEL     @"Cancel"
@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadView:[self getViewName]];
    [(BaseView *)self.view  viewDidLoad];
}

-(void)setupNavBar{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:101/255.0f green:101/255.0f blue:101/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar.backItem setTitle:@""];
}

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [(BaseView *)self.view viewWillAppear];
}

-(void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [(BaseView *)self.view viewDidAppear];
}

-(void) viewWillDisappear:(BOOL)animated{

    [(BaseView *)self.view viewWillDisappear];
    [super viewWillDisappear:animated];
    
}

-(void) setRootViewController:(UIViewController *)controller {
    
    [self.navigationController setViewControllers:@[controller] animated:YES];
    
}

-(void)showLoaderOnUIView:(UIView*) view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

-(void)hideLoaderOnUIView:(UIView*)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
-(UIBarButtonItem*)createLeftMenuButton {
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(0.0,0.0, 20.0, 15.0)];
    [btn setImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onLeftMenuBtnTap) forControlEvents:
     UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}





-(void)onLeftMenuBtnTap{
    [[[AppDelegate getInstance] getMenuContainer] toggleLeftSideMenuCompletion:^{
    }];
}

-(void) viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    [(BaseView *)self.view viewDidLayoutSubviews];
}

-(void)throwExceptioin:(NSString*)message{
    NSLog(@"\n%@\n",message);
    @throw message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIBarButtonItem *) createBackButton:(id)target selector:(SEL)selector  {
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 48.0f, 12.0f)];
    [backButton setImage:[UIImage imageNamed:@"backButton"]  forState:UIControlStateNormal];
    [backButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)loadServices:(NSArray*)services{
    if(service == nil)
        service = [Service get:self];
    
    [service load:services];
}

-(void)onServiceResponseFailure:(NSError*)error{
    [self hideLoader];
    [Alert show:@"" andMessage:error.localizedDescription];
}


-(void)showLoader{
    [MBProgressHUD showHUDAddedTo:[AppDelegate getInstance].window animated:YES];
}

-(void)showLoader:(NSString*)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[AppDelegate getInstance].window animated:YES];
    hud.labelText = message;
}

-(void)hideLoader{
    [MBProgressHUD hideHUDForView:[AppDelegate getInstance].window animated:YES];
}

-(void)popToViewController:(NSString *)viewController {
    BaseController *controller = (BaseController *) NSClassFromString(viewController);

    for (UIViewController *viewController in [[self navigationController] viewControllers]) {
        if ([viewController isKindOfClass:[controller class]] ) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

-(void) popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) pushViewController:(UIViewController *)controller {

    if(![self.navigationController.topViewController isEqual:controller]){

        [self.navigationController pushViewController:controller animated:YES];
    }
}


#pragma mark -- load view

-(NSString*)getViewName{
    NSString *file = [self.class description];
    if(![file hasSuffix:@"Controller"])
        [self throwExceptioin:@"Invalid class name. Name should end with string 'controller' (e.g. SampleController)"];
    
    return [file stringByReplacingOccurrencesOfString:@"Controller" withString:@"View"];
}

-(void)loadView:(NSString*)nib{
    if([[NSBundle mainBundle] pathForResource:nib ofType:@"nib"] == nil){
        [self throwExceptioin:[NSString stringWithFormat:@"%@ nib/class not found in project.",nib]];
    }
    
    UINib *nibs    = [UINib nibWithNibName:nib bundle:nil];
    NSArray *array = [nibs instantiateWithOwner:nil options:nil];
    if(array.count == 0){
        [self throwExceptioin:[NSString stringWithFormat:@"%@ nib doesn't have any view (IB error)",nib]];
    }
    
    if(![[array objectAtIndex:0] isKindOfClass:[BaseView class]]){
        [self throwExceptioin:[NSString stringWithFormat:@"%@ nib should be subclass of %@ -> BaseView (IB error).",nib,nib]];
    }
    
    BaseView *view  = (BaseView*)[array objectAtIndex:0];
    view.controller = self;
    self.view       = view;
}

-(void) openIntroScreen {
    IntroController *controller = [IntroController new];
    [self setRootViewController:controller];
    
}

-(void) showLogoutAlert {
    
    [Alert show:TEXT_LOG_OUT andMessage:MESSAGE_LOGOUT_CONFIRMATION cancelButtonTitle:BUTTON_TITLE_CANCEL otherButtonTitles:TEXT_LOG_OUT tag:1 WithDelegate:self];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        if(alertView.tag == 1){
            [[GoogleManager instance] signOut];
            [FacebookManager logoutFromFacebook];
            [UserDefaults clearUserDefaults];
            [self openIntroScreen];
        }
    }
}

-(void) dealloc {

#if SHOW_DEALLOC_LOG == 1
    NSLog(@"Dealloc called from- %@", NSStringFromClass([self class]));
#endif
}


@end
