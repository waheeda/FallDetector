//
//  Match.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseEntity.h"

@interface Match : BaseEntity
@property(nonatomic,retain) NSString *team1;
@property(nonatomic,retain) NSString *team2;
@property(nonatomic,retain) NSString* matchID;
-(void)set:(NSDictionary*)input;
@end
