//
//  ContactsManager.m
//  table
//
//  Created by Faisal Saleh on 11/27/15.
//  Copyright © 2015 Faisal Saleh. All rights reserved.
//


@import Contacts;
@import AddressBook;
#import "ContactsManager.h"

@implementation ContactsManager


+ (ContactsManager *) sharedInstance {
    static ContactsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ContactsManager alloc] init];
        sharedInstance.contactNames = [NSMutableArray new];
    });
    return sharedInstance;
}

-(void) getContactsOldWayWithSelectedContacts:(NSMutableArray*)selectedContacts andCallback:(ContactManagerCallback)callback{
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted) {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (!addressBook) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        return;
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (error) {
            NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
            callback(nil,false,(__bridge NSError *)(error));
        }
        
        if (granted) {
            // if they gave you permission, then just carry on
            
            [self listPeopleInAddressBook:addressBook withSelectedContacts:selectedContacts];
            callback(self.contactNames,_contactExistCount,nil);
            
        } else {
            callback(nil,false,(__bridge NSError *)(error));
        }
        
        CFRelease(addressBook);
    });
}

- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook withSelectedContacts:(NSMutableArray*)selectedContacts
{
    _contactExistCount=0;
    _matchedContacts=[NSMutableArray new];
    if([self.contactNames count]>0)
        [self.contactNames removeAllObjects];
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSInteger numberOfPeople = [allPeople count];
    
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSString *phoneNumber;
        NSString *email;
        NSMutableArray *allPhoneNumbers = [NSMutableArray new];
        NSMutableArray *allEmails = [NSMutableArray new];
        NSDictionary *contactObject;
        NSLog(@"Name:%@ %@", firstName, lastName);
        
        if([firstName isEqualToString:@"Hank"]){
            NSLog(@"Hank Zaleel");
        }
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        CFIndex numberCount = ABMultiValueGetCount(phoneNumbers);
        CFIndex emailCount = ABMultiValueGetCount(emails);
        for (CFIndex i = 0; i < numberCount ; i++) {
            phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
            NSString *phoneNumberWithoutSpace = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
            [allPhoneNumbers addObject:phoneNumberWithoutSpace];
            if(selectedContacts){
                NSString *firstSelectedPhoneNumber = [[selectedContacts firstObject] objectForKey:@"number"];
                NSString *SecondSelectedPhoneNumber = [[selectedContacts lastObject] objectForKey:@"number"];
                if([firstSelectedPhoneNumber isEqualToString:phoneNumberWithoutSpace] || [SecondSelectedPhoneNumber isEqualToString:phoneNumberWithoutSpace]){
                    _contactExistCount++;
                    [_matchedContacts addObject:phoneNumberWithoutSpace];
                }
            }
            NSLog(@"  phone:%@", phoneNumber);
            NSLog(@"  email:%@", email);
        }
        
        for (CFIndex i = 0; i < emailCount ; i++) {
            email = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, i));
            [allEmails addObject:email];
        }
        
        if ([allPhoneNumbers count]<1)
            continue;
        if(firstName && lastName){
            if([allEmails count]>0){
                contactObject = @{@"Name":[NSString stringWithFormat:@"%@ %@",firstName,lastName],
                              @"Phone":allPhoneNumbers,
                              @"Email":[allEmails firstObject]};
            }
            else{
                contactObject = @{@"Name":[NSString stringWithFormat:@"%@ %@",firstName,lastName],
                              @"Phone":allPhoneNumbers,
                              @"Email":@""};
            }
        }
        else if(firstName){
            if([allEmails count]>0){
                contactObject = @{@"Name":[NSString stringWithFormat:@"%@",firstName],
                              @"Phone":allPhoneNumbers,
                              @"Email":[allEmails firstObject]};
            }
            else{
                contactObject = @{@"Name":[NSString stringWithFormat:@"%@",firstName],
                              @"Phone":allPhoneNumbers,
                              @"Email":@""};
            }
        }
        else if(lastName){
            if([allEmails count]>0){
                contactObject = @{@"Name":[NSString stringWithFormat:@"%@",lastName],
                              @"Phone":allPhoneNumbers,
                              @"Email":[allEmails firstObject]};
            }
            else{
            contactObject = @{@"Name":[NSString stringWithFormat:@"%@",lastName],
                              @"Phone":allPhoneNumbers,
                              @"Email":@""};
            }
        }
        else
            continue;
        
       
        [self.contactNames addObject:contactObject];
        CFRelease(phoneNumbers);
        
        NSLog(@"=============================================");
    }
}

-(void)addContactsOldWayWithName:(NSString *)name number:(NSString *)number email:(NSString *)email{
    NSLog(@"in contact added");
    for(NSString* contact in _matchedContacts){
        
        if([contact isEqualToString:number]){
            return;
        }
    }
    
    ABAddressBookRef iPhoneAddressBook = ABAddressBookCreate();
    
    ABRecordRef newPerson = ABPersonCreate();
    CFErrorRef error = NULL;
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)(name) , &error);
    //ABRecordSetValue(newPerson, kABPersonLastNameProperty, people.lastname, &error);
    
    ABMutableMultiValueRef multiPhone =     ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(number), kABPersonPhoneMainLabel, NULL);
   // ABMultiValueAddValueAndLabel(multiPhone, people.other, kABOtherLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,&error);
    CFRelease(multiPhone);
    
    ABMutableMultiValueRef emails = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(emails, (__bridge CFTypeRef)(email), kABWorkLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonEmailProperty, emails, & error);
    CFRelease(emails);
    
    ABAddressBookAddRecord(iPhoneAddressBook, newPerson, &error);
    
    ABAddressBookSave(iPhoneAddressBook, &error);
    NSMutableArray* phoneNumbers= [NSMutableArray new];
    [phoneNumbers addObject:number];
    
    NSDictionary *newContact =  @{@"Name":name,
                                  @"Phone":phoneNumbers,
                                  @"Email":email};
    [self.contactNames addObject:newContact];
    CFRelease(newPerson);
    CFRelease(iPhoneAddressBook);
    if (error != NULL)
    {
        CFStringRef errorDesc = CFErrorCopyDescription(error);
        NSLog(@"Contact not saved: %@", errorDesc);
        CFRelease(errorDesc);
    }
}

-(void) getContactsNewWay{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusDenied) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"This app previously was refused permissions to contacts; Please go to settings and grant permission to this app so it can use contacts" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alert animated:TRUE completion:nil];
        return;
    }
    
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        // make sure the user granted us access
        
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // user didn't grant access;
                // so, again, tell user here why app needs permissions in order  to do it's job;
                // this is dispatched to the main queue because this request could be running on background thread
            });
            return;
        }
        
        NSMutableArray *contacts = [NSMutableArray array];
        
        NSError *fetchError;
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactIdentifierKey, [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]]];
        
        BOOL success = [store enumerateContactsWithFetchRequest:request error:&fetchError usingBlock:^(CNContact *contact, BOOL *stop) {
            [contacts addObject:contact];
        }];
        if (!success) {
            NSLog(@"error = %@", fetchError);
        }
        
        // you can now do something with the list of contacts, for example, to show the names
        
        CNContactFormatter *formatter = [[CNContactFormatter alloc] init];
        
        for (CNContact *contact in contacts) {
            NSString *string = [formatter stringFromContact:contact];
            NSLog(@"contact = %@", string);
            if(string){
                [self.contactNames addObject:string];
            }
        }
    }];
}

-(void)addContactsNewWayWithName:(NSString *)name number:(NSString *)number email:(NSString *)email{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusDenied) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"This app previously was refused permissions to contacts; Please go to settings and grant permission to this app so it can add the desired contact" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alert animated:TRUE completion:nil];
        return;
    }
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // user didn't grant access;
                // so, again, tell user here why app needs permissions in order  to do it's job;
                // this is dispatched to the main queue because this request could be running on background thread
            });
            return;
        }
        
        // create contact
        
        CNMutableContact *contact = [[CNMutableContact alloc] init];
//        contact.familyName = @"Doe";
        contact.givenName = name;
        
        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:number]];
        contact.phoneNumbers = @[homePhone];
        
        
        CNSaveRequest *request = [[CNSaveRequest alloc] init];
        [request addContact:contact toContainerWithIdentifier:nil];
        
        // save it
        
        NSError *saveError;
        if (![store executeSaveRequest:request error:&saveError]) {
            NSLog(@"error = %@", saveError);
        }
    }];
}


@end
