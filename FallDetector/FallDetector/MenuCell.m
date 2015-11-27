//
//  MenuCell.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/25/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        self = [array lastObject];
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

-(void)set:(NSDictionary*)menuName{
    self.menuLabel.text = [menuName objectForKey:@"name"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
