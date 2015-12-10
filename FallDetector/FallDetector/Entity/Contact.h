//
//  Contact.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/7/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseEntity.h"

@interface Contact : BaseEntity
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *number;
@property(nonatomic,retain) NSString *email;
-(void)set:(NSDictionary*)input;
-(NSDictionary*)getDictionary;
@end
