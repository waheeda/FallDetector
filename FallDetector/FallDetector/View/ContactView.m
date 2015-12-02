//
//  ContactView.m
//  FallDetector
//
//  Created by Faisal Saleh on 11/27/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ContactView.h"
#import "ContactController.h"

@implementation ContactView


-(void)setContacts:(NSMutableArray*)array{
    if(!_sortedContacts){
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        _sortedContacts = [array sortedArrayUsingDescriptors:@[sort]];
    }
    self.selectedContacts = [NSMutableArray array];
    _filteredContacts = [NSMutableArray arrayWithArray:_sortedContacts];
}


-(ContactCell *) createContactCell:(NSString *) identifier{
    
    ContactCell *cell =  [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _contactCell = cell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_filteredContacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactCell";
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell =[self createContactCell:CellIdentifier];
    }
    NSDictionary *selectedContact = [_filteredContacts objectAtIndex:indexPath.row];
    NSDictionary *insertedContact = [self isContactAlreadySelected:selectedContact];
    if (insertedContact){
        [cell showSelected];
    } else{
        [cell showUnselected];
    }
    
    [cell setNameLabelText:[[_filteredContacts objectAtIndex:indexPath.row] objectForKey:@"Name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *selectedContact = [_filteredContacts objectAtIndex:indexPath.row];
    NSDictionary *insertedContact = [self isContactAlreadySelected:selectedContact];
    if (insertedContact){
        [self.selectedContacts removeObject:insertedContact];
    } else {
        [self showNumberSelectorIfNecessary:selectedContact];
    }
    [tableView reloadData];
}

- (NSDictionary *)isContactAlreadySelected:(NSDictionary *)contact{
    NSArray *numbers = [contact objectForKey:@"Phone"];
    for(NSDictionary *current in self.selectedContacts){
        NSString *currentNumber = [current objectForKey:@"SelectedNumber"];
        for(NSString *number in numbers){
            if([number isEqualToString:currentNumber]){
                return current;
            }
        }
    }
    return nil;
}

- (void) showNumberSelectorIfNecessary:(NSDictionary *)contact{
    NSString *name = [contact objectForKey:@"Name"];
    NSArray *numbers = [contact objectForKey:@"Phone"];
    if([numbers count] > 1){
        [self showNumberSelector:contact];
    } else {
        NSDictionary *newContact = @{@"Name":name,
                                     @"SelectedNumber":[numbers firstObject]};
        [self.selectedContacts addObject:newContact];
    }
}

-(void) showNumberSelector:(NSDictionary *)contact{
    NSString *name = [contact objectForKey:@"Name"];
    NSArray *numbers = [contact objectForKey:@"Phone"];
    
    NSString *message = [NSString stringWithFormat:@"%@ contains multiple phone numbers. Please select one to use.", name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for(NSString *number in numbers){
        UIAlertAction *action = [UIAlertAction actionWithTitle:number style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSDictionary *newContact = @{@"Name":name,
                                         @"SelectedNumber":action.title};
            [self.selectedContacts addObject:newContact];
            [_table reloadData];
        }];
        [alert addAction:action];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    
    [(ContactController *)self.controller.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText length] < 1){
        _filteredContacts = _sortedContacts;
        [_table reloadData];
        return;
    }
    NSString* filter = @"%K CONTAINS[cd] %@";
    _filteredContacts = [_sortedContacts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:filter, @"Name", searchText]];
    [_table reloadData];
}

@end
