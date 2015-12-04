//
//  MenuView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/25/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MenuView.h"
#import "MenuCell.h"
#import "MenuController.h"

@implementation MenuView

-(void)awakeFromNib{
    _menuArray=@[@{@"name":@"Home", @"selector":@"openHomeController"},
                 @{@"name":@"Emergency Contacts", @"selector":@"openEmergencyContactsController"},
                 @{@"name":@"About", @"selector":@"openAboutController"}];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

#pragma mark - UITableView Delegates/DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Menu-Cell";
    
    MenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!menuCell){
        menuCell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [menuCell set:[_menuArray objectAtIndex:indexPath.row]];
   //  [(MenuController*)self.controller didSelectMenu:[_menuArray objectAtIndex:indexPath.row]];
    return menuCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    MenuCell *menuCell = (MenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    [menuCell setSelected:YES];
    [(MenuController*)self.controller didSelectMenu:[_menuArray objectAtIndex:indexPath.row]];
}


@end
