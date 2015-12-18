//
//  ContactView.m
//  FallDetector
//
//  Created by Faisal Saleh on 11/27/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ContactView.h"
#import "ContactController.h"
#import "UserDefaults.h"
#import "Alert.h"
#import "UserDefaults.h"
#import "Contact.h"
#import "StringUtils.h"
@implementation ContactView


-(void)setContacts:(NSMutableArray*)array{
    if(!_sortedContacts){
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        _sortedContacts = [array sortedArrayUsingDescriptors:@[sort]];
    }
    _filteredContacts = [NSMutableArray arrayWithArray:_sortedContacts];
    if([UserDefaults getEmergencyContacts])
        self.selectedContacts =(NSMutableArray*)[UserDefaults getEmergencyContacts];
    else
        self.selectedContacts = [NSMutableArray array];
    [self updateSelectedContactsCount];
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
    [cell setNameInitials:[StringUtils getFirstLetterFromEachWord:[[_filteredContacts objectAtIndex:indexPath.row] objectForKey:@"Name"]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.searchBar isFirstResponder]){
        [self.searchBar resignFirstResponder];
        return;
    }
    
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *selectedContact = [_filteredContacts objectAtIndex:indexPath.row];
    NSDictionary *insertedContact = [self isContactAlreadySelected:selectedContact];
    if (insertedContact){
        [self.selectedContacts removeObject:insertedContact];
    } else {
        if([self.selectedContacts count]==2){
            [Alert show:@"Alert" andMessage:@"You cannot select more than two contacts"];
            return;
        }
        [self showNumberSelectorIfNecessary:selectedContact];
    }
    [self updateSelectedContactsCount];
    [tableView reloadData];
}

- (NSDictionary *)isContactAlreadySelected:(NSDictionary *)contact{
    NSArray *numbers = [contact objectForKey:@"Phone"];
    for(NSDictionary *current in self.selectedContacts){
       NSString *currentNumber = [current objectForKey:@"number"];
        for(NSString *number in numbers){
            if([number isEqualToString:currentNumber]){
                return current;
            }
        }
    }
    return nil;
}

-(void)updateSelectedContactsCount{
    if([self.selectedContacts count]==1){
        [self.selectedContactsLabel setText:@"Selected Contacts: 1 of 2"];
    }
    
    else if([self.selectedContacts count]==2){
        [self.selectedContactsLabel setText:@"Selected Contacts: 2 of 2"];
    }
    
    else{
        [self.selectedContactsLabel setText:@"Selected Contacts: 0 of 2"];
    }
}

- (void) showNumberSelectorIfNecessary:(NSDictionary *)contact{
    NSString *name = [contact objectForKey:@"Name"];
    NSArray *numbers = [contact objectForKey:@"Phone"];
    NSString *email = [contact objectForKey:@"Email"];
    
    if([email isEqualToString:@""]){
        [Alert show:@"Warning" andMessage:@"The selected contact doesn't have any email specified. Specify the email of the contact in address book"];
        return;
    }
    
    if([numbers count] > 1){
        [self showNumberSelector:contact];
    }
    else {
        NSDictionary *newContact;
        if(![email isEqualToString:@""]){
            newContact = @{@"contact_name":name,
                                     @"number":[numbers firstObject],
                                     @"email":email};
        }
        else{
            newContact = @{@"contact_name":name,
                           @"number":[numbers firstObject],
                           @"email":@""};
        }
        [self.selectedContacts addObject:newContact];
    }
}

-(void) showNumberSelector:(NSDictionary *)contact{
    NSString *name = [contact objectForKey:@"Name"];
    NSArray *numbers = [contact objectForKey:@"Phone"];
    NSString *email = [contact objectForKey:@"Email"];
    NSString *message = [NSString stringWithFormat:@"%@ contains multiple phone numbers. Please select one to use.", name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for(NSString *number in numbers){
        UIAlertAction *action = [UIAlertAction actionWithTitle:number style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSDictionary *newContact = @{@"contact_name":name,
                                         @"number":action.title,
                                         @"email":email};
            [self.selectedContacts addObject:newContact];
            [self updateSelectedContactsCount];
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
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
