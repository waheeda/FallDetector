//
//  ContactView.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/27/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"
#import "ContactCell.h"
@interface ContactView : BaseView <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
    NSArray *_sortedContacts;
    NSArray *_filteredContacts;
    ContactCell   *_contactCell;
}
@property (nonatomic, strong) IBOutlet UITableView* table;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *selectedContacts;
-(void)setContacts:(NSMutableArray*)array;
@end
