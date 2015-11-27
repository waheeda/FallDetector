//
//  MultiContactSelector.h
//  Zubi
//
//  Created by Waheeda  on 10/26/11.
//  Copyright 2013 Tenpearls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Constant.h"
#import "SearchBar.h"

#define IMG_CHECKBOX_UNCHECKED  @"CheckBox_Deselected.png"
#define IMG_CHECKBOX_CHECKED    @"CheckBox_Selected.png"

typedef enum {
   // ContactTypeFacebook         = 0,
    ContactTypeAddressBook      = 1,
    ContactTypeManual           = 2
}
ContactType;


@protocol MultipleContactSelectorDelegate <NSObject>

  - (void)multipleContactSelectorDidCancel;
  - (void)multipleContactSelectorDidCompleteSelections:(NSArray *)contactList ofType:(ContactType)type;

@end


@interface MultiContactSelectorTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView * checkBoxImageView;
@property (nonatomic, retain) UILabel     * nameLabel;
@property (nonatomic) int alternateRowFlag;
@end


@interface MultiContactSelector : UITableViewController < UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic,assign) id<MultipleContactSelectorDelegate> delegate;
@property(nonatomic, retain) NSMutableArray *contactsArray;
@property(nonatomic, retain) NSMutableArray *filteredSearchArray;
@property(nonatomic, retain) NSMutableDictionary *sectionsDictionary;
@property(nonatomic, retain) NSMutableArray *selectedIndexPaths;
@property(nonatomic) ContactType contactType;
@property (nonatomic) int alternateRowFlag;
@property(nonatomic, retain) UILabel *errorLabel;
@property(nonatomic, retain) SearchBar *searchBar;
@property(nonatomic, retain) UISearchDisplayController *contactsSearchDisplayController;

-(void) setAlreadySelectedContactIds:(NSArray *) selectedFriendIds;

@end
