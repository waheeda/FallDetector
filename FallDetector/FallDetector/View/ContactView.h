//
//  ContactView.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/27/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"
#import "ContactCell.h"
@interface ContactView : BaseView <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_contacts;
    ContactCell   *_contactCell;
}
@property (nonatomic, strong) NSArray *filtered;
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (nonatomic, strong) NSMutableArray *cellSelected;
-(void)setContacts:(NSMutableArray*)array;
@end
