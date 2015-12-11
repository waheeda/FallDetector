//
//  ContactsManager.h
//  table
//
//  Created by Faisal Saleh on 11/27/15.
//  Copyright © 2015 Faisal Saleh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ContactManagerCallback)(id result,int contactExistCount, NSError *error);

@interface ContactsManager : NSObject{
    int _contactExistCount;
    NSMutableArray *_matchedContacts;
}

@property (atomic, strong) NSMutableArray *contactNames;

+ (ContactsManager *) sharedInstance;
-(void) getContactsOldWayWithSelectedContacts:(NSMutableArray*)selectedContacts andCallback:(ContactManagerCallback)callback;
-(void) getContactsNewWay;
-(void)addContactsOldWayWithName:(NSString *)name number:(NSString *)number email:(NSString *)email;
@end
