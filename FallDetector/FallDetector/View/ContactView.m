//
//  ContactView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/27/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ContactView.h"

@implementation ContactView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setContacts:(NSMutableArray*)array{
    if(!_contacts){
        _contacts=[NSMutableArray new];
        _contacts=array;
    }
//    NSString *filterString = @"Hissan Baba";
    self.cellSelected = [NSMutableArray array];
//    NSString* filter = @"%K CONTAINS[cd] %@";
//    self.filtered = [_contacts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:filter,@"Name", filterString]];
    self.filtered = _contacts;
}


-(UITableViewCell *) createContactCell:(NSString *) identifier{
    
    UITableViewCell *cell =  [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[(ContactCell *)cell setDelegate:self];
    _contactCell = (ContactCell *)cell;
   // [_profileCell setProfileData:_user];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.filtered count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell =[self createContactCell:CellIdentifier];
    }
//    NSDictionary *selectedContact = [_filtered objectAtIndex:indexPath.row];
//    if ([self.cellSelected containsObject:selectedContact]){
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        
//    }
//    
   // [cell.textLabel setText:[[self.filtered objectAtIndex:indexPath.row] objectForKey:@"Name"]];
    [(ContactCell*)cell setNameLabelText:[[self.filtered objectAtIndex:indexPath.row] objectForKey:@"Name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    //if you want only one cell to be selected use a local NSIndexPath property instead of array. and use the code below
    //self.selectedIndexPath = indexPath;
    
    //the below code will allow multiple selection
    NSDictionary *selectedContact = [_filtered objectAtIndex:indexPath.row];
    if ([self.cellSelected containsObject:selectedContact]){
        [self.cellSelected removeObject:selectedContact];
    } else {
        [self.cellSelected addObject:selectedContact];
    }
    [tableView reloadData];
}

@end
