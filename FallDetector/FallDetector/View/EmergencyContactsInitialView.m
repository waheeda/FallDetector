//
//  EmergencyContactsInitialView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/26/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "EmergencyContactsInitialView.h"
#import "MultiContactSelector.h"
#import "EmergencyContactsInitialController.h"
#import "ContactsManager.h"
@implementation EmergencyContactsInitialView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onAddCOntactCLick:(id)sender {
//    MultiContactSelector *controller = [MultiContactSelector new
//                                        ];
//    [(EmergencyContactsInitialController*)self.controller pushViewController:controller];
    [(EmergencyContactsInitialController*)self.controller fetchContacts];
    
}

@end
