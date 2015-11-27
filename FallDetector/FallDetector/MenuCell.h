//
//  MenuCell.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/25/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *menuLabel;
-(void)set:(NSString*)menuName;
@end
