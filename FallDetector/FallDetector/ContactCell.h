//
//  ContactCell.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/1/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *contactCircleView;
@property (strong, nonatomic) IBOutlet UILabel *nameInitialsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *checkBox;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
-(void)setNameLabelText:(NSString*)name;
-(void) showSelected;
-(void) showUnselected;
-(void)setNameInitials:(NSString*)initials;
@end
