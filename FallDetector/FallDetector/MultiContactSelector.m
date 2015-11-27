//
//  MultiContactSelector.m
//  Zubi
//
//  Created by Waheeda  on 10/26/11.
//  Copyright 2013 Tenpearls. All rights reserved.
//

#import "MultiContactSelector.h"
#import "StringUtils.h"
#import "Font.h"
#import "Alert.h"
#import "Utils.h"
@import Contacts;
@implementation MultiContactSelectorTableViewCell

#define TABLE_BACKGROUND_COLOR      [UIColor colorWithRed:(65/255.0) green:(65/255.0) blue:(65/255.0) alpha:1.0]
#define TABLE_TEXT_COLOR            [UIColor whiteColor]
#define ALTERNATE_ROW_BG_COLOR      [UIColor colorWithRed:(49/255.0) green:(49/255.0) blue:(49/255.0) alpha:1.0]
#define SEPARATOR_COLOR             [UIColor colorWithRed:(85/255.0) green:(85/255.0) blue:(85/255.0) alpha:1.0]
#define SEARCH_BAR_STYLE            UIBarStyleBlack 
#define SECTION_HEADER_TINT_COLOR   [UIColor blackColor]
#define IMG_CHECKBOX_UNCHECKED  @"CheckBox_Deselected.png"
#define IMG_CHECKBOX_CHECKED    @"CheckBox_Selected.png"

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setBackgroundColor:TABLE_BACKGROUND_COLOR];
        [self createCheckBox];
        [self createTitleLabel];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"12Am to 12:59AM", @"DisplayValue",
                                    YES , @"isSelected",
                                     nil];
        NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"12Am to 12:59AM", @"DisplayValue",
                                    YES , @"isSelected",
                                    nil];
        NSDictionary *dictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:@"12Am to 12:59AM", @"DisplayValue",
                                    YES , @"isSelected",
                                    nil];
        
        [array addObject:dictionary];
        [array addObject:dictionary1];
        [array addObject:dictionary2];
 
        
    }
    return self;
}
-(void) createCheckBox
{
    UIImage *checkImage = [UIImage imageNamed:IMG_CHECKBOX_UNCHECKED];
    _checkBoxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    [_checkBoxImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_checkBoxImageView setImage:checkImage];
    [_checkBoxImageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_checkBoxImageView];
}
/*-(void) createUserImageView
{
   _userImageView = [[LazyLoadingImageView alloc] initWithFrame:CGRectMake(50, 5, 50, 50)];
    [_userImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_userImageView.layer setMasksToBounds:NO];
    [_userImageView.layer setBorderColor:SEPARATOR_COLOR.CGColor];
    [_userImageView.layer setBorderWidth:2.0];
    [_userImageView setBackgroundColor:[UIColor clearColor]];
   [self.contentView addSubview:_userImageView];
}*/

-(void) createTitleLabel
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 200, 40)];
    _nameLabel.numberOfLines = 0;
    [_nameLabel setFont:[Font normal]];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    [_nameLabel setTextColor:TABLE_TEXT_COLOR];
    [self.contentView addSubview:_nameLabel];
}


@end



@implementation MultiContactSelector


#pragma mark -
#pragma  MultipleContactSelectorDelegate methods

- (void)multipleContactSelectorDidCancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
    if(_delegate && [_delegate respondsToSelector:@selector(multipleContactSelectorDidCancel)])
        [_delegate multipleContactSelectorDidCancel];
}
- (void)multipleContactSelectorDidCompleteSelections:(NSArray *)emailList
{
	[self dismissViewControllerAnimated:YES completion:nil];
    if(_delegate && [_delegate respondsToSelector:@selector(multipleContactSelectorDidCompleteSelections:ofType:)])
        [_delegate multipleContactSelectorDidCompleteSelections:emailList ofType:self.contactType];
}


#pragma mark -
#pragma mark View lifecycle

-(id) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        _contactsArray = [[NSMutableArray alloc] init];
        _selectedIndexPaths = [[NSMutableArray alloc] init];
        _sectionsDictionary = [[NSMutableDictionary alloc] init];
        _filteredSearchArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactType = ContactTypeAddressBook;
	self.title = @"Add Members";
    [self createBarButtonItems];
	[self createSearchBarAndSearchDisplayController];
    //self.title = @"Select Contacts";
    [self.tableView setSeparatorColor:SEPARATOR_COLOR];
    [self.tableView setBackgroundColor:TABLE_BACKGROUND_COLOR];
    [[UITableViewHeaderFooterView appearance] setTintColor:SECTION_HEADER_TINT_COLOR];
    [self createErrorLabel];
    //self.tableView.refreshControl =
}
-(void) viewDidAppear:(BOOL)animated{
    
    [self handleDoneBtn];
}

-(void) createErrorLabel
{
    _errorLabel = [[UILabel alloc] initWithFrame:[self.view bounds]];
    [_errorLabel setBackgroundColor:[UIColor clearColor]];
    [_errorLabel setText:@"No Friends Found."];
    [_errorLabel setTextAlignment:NSTextAlignmentCenter];
    [_errorLabel setFont:[Font medium]];
    [_errorLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_errorLabel];
    [_errorLabel setHidden:YES];
}

-(void) createSearchBarAndSearchDisplayController
{
    _searchBar = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"title search";
    _searchBar.showsCancelButton = NO;
    _searchBar.barStyle = SEARCH_BAR_STYLE;
    [self.view addSubview:_searchBar];
    
    _contactsSearchDisplayController =[[ UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _contactsSearchDisplayController.delegate                = self;
    _contactsSearchDisplayController.searchResultsDataSource = self;
	_contactsSearchDisplayController.searchResultsDelegate   = self;
}


-(void) setContactType:(ContactType)contactType
{
    [_sectionsDictionary removeAllObjects];
    [_contactsArray removeAllObjects];
    [_selectedIndexPaths removeAllObjects];
    [self.tableView reloadData];
    _contactType = contactType;
    if(contactType == ContactTypeAddressBook)
        [self loadContactsFromAddressBook];
    
   // [self createSectionsList];
   // _alternateRowFlag = 0;
   // [self.tableView reloadData];
}


-(void) setAlreadySelectedContactIds:(NSArray *) selectedFriendIds
{
    [self.selectedIndexPaths addObjectsFromArray:selectedFriendIds];
}

-(void) createSectionsList
{
   
    if(self.contactsArray.count)
        _errorLabel.hidden = YES;
    else _errorLabel.hidden = NO;
    
    
    BOOL found;
    
    // Loop through the contacts and create our keys
    for (id contact in self.contactsArray)
    {
        NSString *firstAlphabet = [[contact valueForKey:@"name"] substringToIndex:1];
        
        found = NO;
        
        for (NSString *str in [_sectionsDictionary allKeys])
        {
            if ([str isEqualToString:firstAlphabet])
            {
                found = YES;
            }
        }
        
        if (!found)
        {
            [_sectionsDictionary setValue:[[NSMutableArray alloc] init] forKey:firstAlphabet];
        }
        
        [[_sectionsDictionary objectForKey:firstAlphabet] addObject:contact];
    }
    
    NSLog(@"SectionsList is : %@", _sectionsDictionary);
}


-(void) createBarButtonItems
{
    UIBarButtonItem *cencelbtn = [Utils getBarButtonItemWithTarget:self andSelector:@selector(multipleContactSelectorDidCancel) title:@"Cancel"];
	self.navigationItem.leftBarButtonItem = cencelbtn;
    
    
	
	UIBarButtonItem *doneButton = [Utils getBarButtonItemWithTarget:self andSelector:@selector(getSelectedContacts) title:@"Done"];
	self.navigationItem.rightBarButtonItem = doneButton;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}


/*- (void) allFriendsLoaded
{
   [ALERT hideLoader];
    NSMutableDictionary *dictionary =  [[FacebookHelper initializeHelper] getFriendList] ;
    NSArray *friendsArray =  [(NSDictionary *)[dictionary objectForKey:@"Friends"] allValues];

    [self.contactsArray addObjectsFromArray:friendsArray];
    [self createSectionsList];
    _alternateRowFlag = 0;
     [self.tableView reloadData];
}*/

-(void) loadContactsFromAddressBook
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
	NSArray *peopleArray = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
   // NSArray *peopleArray = CNContactFetchRequest
	int count = [peopleArray count];
	ABRecordRef record;
	
	int index = 0;
    
    for (int i=0; i< count; i++)
	{
		record = (__bridge ABRecordRef)([peopleArray objectAtIndex:i]);
		ABMutableMultiValueRef multi = ABRecordCopyValue(record, kABPersonEmailProperty);
		if( ABMultiValueGetCount(multi) > 0)
		{
			NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
			
			NSString *firstName, *lastName;
			firstName = (__bridge NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
			lastName  = (__bridge NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
            lastName  = (__bridge NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
			
            bool hasImage = ABPersonHasImageData(record);
            if(hasImage)
            {
                CFDataRef ref = ABPersonCopyImageData(record);
                UIImage *image = [UIImage imageWithData:(__bridge NSData *)ref];
                [tempDictionary setObject:image forKey:@"image"];
            }
            
			if(firstName == nil) firstName = @"";
			if(lastName == nil) lastName = @"";
			
			//ABMutableMultiValueRef multi = ABRecordCopyValue(record, kABPersonEmailProperty);
			
			NSString *email;
			email = (__bridge NSString *)ABMultiValueCopyValueAtIndex(multi, 0);
			
			[tempDictionary setObject:firstName forKey:@"firstname"];
			[tempDictionary setObject:lastName forKey:@"lastname"];
			[tempDictionary setObject:email forKey:@"email"];
            
            NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            [tempDictionary setObject:name forKey:@"name"];
			
            index ++;
            [tempDictionary setObject:[NSString stringWithFormat:@"%d", index] forKey:@"fbId"];
            
			[self.contactsArray addObject:tempDictionary];
			
			
			
		}
		CFRelease(multi);
	}
	
	CFRelease(addressBook);
}



-(void) getSelectedContacts
{
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fbId in (%@)", [self.selectedIndexPaths componentsJoinedByString:@","]];
    
    NSArray *filteredArray = [self.contactsArray filteredArrayUsingPredicate:predicate];
    
	 [self multipleContactSelectorDidCompleteSelections:filteredArray];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(_contactsSearchDisplayController.isActive)
        return 1;
    return [_sectionsDictionary count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(_contactsSearchDisplayController.isActive)
        return nil;
    
    return [[[_sectionsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if(_contactsSearchDisplayController.isActive)
        return nil;
    
    return [[_sectionsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if(_contactsSearchDisplayController.isActive)
        return _filteredSearchArray.count;
    
    return [[_sectionsDictionary valueForKey:[[[_sectionsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    id person ;
    if(_contactsSearchDisplayController.isActive && _searchBar.text.length != 0)
        person = [self.filteredSearchArray objectAtIndex:indexPath.row];
    else
        person = [[_sectionsDictionary valueForKey:[[[_sectionsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    
    MultiContactSelectorTableViewCell *cell;
    if(_contactType == ContactTypeAddressBook)
        cell =  [self getCellForAddressBookContact:indexPath withPersonObject:person];
    //else
        //cell =  [self getCellForFacebookContact:indexPath withPersonObject:person];
    cell.textLabel.text=@"Hahahahahhaa";
    
    NSString *contactId = [person valueForKey:@"fbId"];
    
    if ([self.selectedIndexPaths indexOfObject:contactId] == NSNotFound )
	    cell.checkBoxImageView.image = [UIImage imageNamed:IMG_CHECKBOX_UNCHECKED];
	else 
		cell.checkBoxImageView.image = [UIImage imageNamed:IMG_CHECKBOX_CHECKED];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  cell.backgroundColor = CELL_BG_COLOR_LIGHT;
}


-(MultiContactSelectorTableViewCell *) getCellForAddressBookContact:(NSIndexPath *)indexPath withPersonObject:(id) person
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell-%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    
    UITableView *tableViewToSearch = self.tableView;
    if([_contactsSearchDisplayController isActive])
    {
        tableViewToSearch = _contactsSearchDisplayController.searchResultsTableView;
        cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%@", _searchBar.text];
    }
    MultiContactSelectorTableViewCell *cell = (MultiContactSelectorTableViewCell *)[tableViewToSearch dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MultiContactSelectorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] ;
        
        cell.alternateRowFlag = _alternateRowFlag;
        _alternateRowFlag = (_alternateRowFlag)? 0 : 1;
    }
    
	cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
   
	
	if(![[person objectForKey:@"firstname"] isEqualToString:@""])
	     cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [person objectForKey:@"firstname"],[person objectForKey:@"lastname"]];
	 else 
		cell.nameLabel.text = [NSString stringWithFormat:@"%@",[person objectForKey:@"lastname"]];
    
    
  //  UIImage *image = [person objectForKey:@"image"];
    //if(image)
      //  cell.userImageView.image = image;
	
    return cell;
}

/*-(MultiContactSelectorTableViewCell *) getCellForFacebookContact:(NSIndexPath *) indexPath  withPersonObject:(FacebookFriend *) person
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%d-%d-%@-%@",indexPath.section, indexPath.row, [person getFbId], [person getPictureURL]];
    UITableView *tableViewToSearch = self.tableView;
    if([_contactsSearchDisplayController isActive])
    {
        tableViewToSearch = _contactsSearchDisplayController.searchResultsTableView;
        cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%@", _searchBar.text];
    }
    MultiContactSelectorTableViewCell *cell = (MultiContactSelectorTableViewCell *)[tableViewToSearch dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MultiContactSelectorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] ;
        
        [cell.userImageView loadWithURL:[NSURL URLWithString:[person getPictureURL]] image:nil];
        
        cell.alternateRowFlag = _alternateRowFlag;
        _alternateRowFlag = (_alternateRowFlag)? 0 : 1;
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
	cell.nameLabel.text = [person getName];
    
    return cell;
}*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
	/*id person ;
    if(_contactsSearchDisplayController.isActive)
        person = [self.filteredSearchArray objectAtIndex:indexPath.row];
    else
        person = [[_sectionsDictionary valueForKey:[[[_sectionsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSString *contactId = [person valueForKey:@"fbId"];
    
    if ( [self.selectedIndexPaths indexOfObject:contactId] == NSNotFound ) {
        [self.selectedIndexPaths addObject:contactId];
		
    } else {
        [self.selectedIndexPaths removeObject:contactId];
        
    }
	
    [self handleDoneBtn];
    
	[tableView reloadData];*/
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    // Display only a person's phone, email, and birthdate
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
    
    
    picker.displayedProperties = displayedItems;
    // Show the picker
    [self presentViewController:picker animated:YES completion:nil];
    

}

-(void) handleDoneBtn{
 
    if(self.selectedIndexPaths.count == 0){
        NSLog(@"disable done");
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    else {
        NSLog(@"enable done");
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
}

#pragma mark - UISearchBarDelegate

- (NSArray *) filterContentForSearchText : (NSString *) searchText {
	NSArray *searchTerms      = [searchText componentsSeparatedByString:@" "];
	NSString *predicateFormat = @"(firstName contains[cd] %@) OR (lastName contains[cd] %@) OR (name contains[cd] %@)";
	NSPredicate *predicate;
    
	if ([searchTerms count] == 1) {
		NSString *term = [searchTerms objectAtIndex:0];
		predicate = [NSPredicate predicateWithFormat:predicateFormat, term, term, term];
	} else {
		NSMutableArray *subPredicates = [NSMutableArray array];
		for (NSString *term in searchTerms) {
			NSPredicate *p = [NSPredicate predicateWithFormat:predicateFormat, term, term, term];
			[subPredicates addObject:p];
		}
		predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
	}
    
     return [Utils getSortedArray:[self.contactsArray filteredArrayUsingPredicate:predicate] withKey:@"name" ascending:YES];
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES];
    [(SearchBar*)searchBar setCloseButtonTitle:@"Done" forState:UIControlStateNormal];
}


- (void) searchBar : (UISearchBar *) searchBar textDidChange : (NSString *) searchText {
	
    [_filteredSearchArray removeAllObjects];
    
    if (![StringUtils isEmptyOrNull:searchText]) {

		searchText    = [StringUtils stringByTrimmingWhiteSpaces:searchText];
		[_filteredSearchArray addObjectsFromArray:[self filterContentForSearchText:searchText]];
		[_contactsSearchDisplayController.searchResultsTableView reloadData];
	}
}
- (void) searchBarSearchButtonClicked : (UISearchBar *) searchBar {
	[searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    if(self.selectedIndexPaths.count)
        [self getSelectedContacts];
    
}

-(void) searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    tableView.backgroundColor  = TABLE_BACKGROUND_COLOR;
    tableView.separatorColor   = SEPARATOR_COLOR;
}

- (void) searchDisplayControllerDidEndSearch : (UISearchDisplayController *) controller {
[self.tableView reloadData];
}

@end

