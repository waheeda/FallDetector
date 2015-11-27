//
//  MenuView.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/25/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"

@interface MenuView : BaseView <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_menuArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
