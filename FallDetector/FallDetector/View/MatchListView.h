//
//  MatchList.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"

@interface MatchListView : BaseView <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
