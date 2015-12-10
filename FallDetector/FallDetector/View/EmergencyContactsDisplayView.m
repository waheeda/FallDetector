//
//  EmergencyContactsDisplayView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/4/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "EmergencyContactsDisplayView.h"

@implementation EmergencyContactsDisplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setEmergencyContacts:(NSMutableArray*)contacts{
    if(contacts){
        _emergencyContacts=contacts;
        [self getContactsDictionary];
    }
}

-(void)setAllOutlets{
    if(_firstContact && _secondContact){
        [self.nameLabel1 setText:[_firstContact objectForKey:@"contact_name"]];
        [self.numberLabel1 setText:[_firstContact objectForKey:@"number"]];
        [self.email1 setText:[_firstContact objectForKey:@"email"]];
        [self.namelabel2 setText:[_secondContact objectForKey:@"contact_name"]];
        [self.numberLabel2 setText:[_secondContact objectForKey:@"number"]];
        [self.email2 setText:[_secondContact objectForKey:@"email"]];
    }
}

-(void)getContactsDictionary{
    _firstContact = [_emergencyContacts firstObject];
    _secondContact = [_emergencyContacts lastObject];
    [self setAllOutlets];
}

-(void)viewDidLayoutSubviews{
    [self setSpheresCornerRadii];
}

-(void)setSpheresCornerRadii{
    self.upperSphereView.layer.cornerRadius=self.upperSphereView.frame.size.width/2;
    self.lowerSphereView.layer.cornerRadius=self.lowerSphereView.frame.size.width/2;
    self.upperSphereView.layer.masksToBounds=YES;
    self.lowerSphereView.layer.masksToBounds=YES;
}

@end
