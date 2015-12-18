//
//  EmergencyContactsDisplayView.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/4/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"

@interface EmergencyContactsDisplayView : BaseView{
    NSMutableArray *_emergencyContacts;
    NSDictionary* _firstContact;
    NSDictionary* _secondContact;
}
@property (strong, nonatomic) IBOutlet UILabel *nameInitials1;
@property (strong, nonatomic) IBOutlet UIView *upperSphereView;
@property (strong, nonatomic) IBOutlet UIView *lowerSphereView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel1;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel1;
@property (strong, nonatomic) IBOutlet UILabel *email1;
@property (strong, nonatomic) IBOutlet UILabel *namelabel2;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel2;
@property (strong, nonatomic) IBOutlet UILabel *email2;
@property (strong, nonatomic) IBOutlet UILabel *nameInitials2;
-(void)setEmergencyContacts:(NSMutableArray*)contacts;
@end
