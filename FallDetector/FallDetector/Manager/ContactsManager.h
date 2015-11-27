//
//  ContactsManager.h
//  table
//
//  Created by Faisal Saleh on 11/27/15.
//  Copyright © 2015 Faisal Saleh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ContactManagerCallback)(id result, NSError *error);

@interface ContactsManager : NSObject

@property (atomic, strong) NSMutableArray *contactNames;

+ (ContactsManager *) sharedInstance;
-(void) getContactsOldWayWithCallback:(ContactManagerCallback)callback;
-(void) getContactsNewWay;

@end
