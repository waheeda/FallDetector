//
//  TextField.m
//  Guardian
//
//  Created by mohsin on 10/18/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "TextField.h"
#import "Constant.h"
#import "Color.h"
#import "Font.h"
#import "StringUtils.h"


#define TEXTFIELD_BORDER_WIDTH  1.2
#define TEXTFIELD_TEXT_PADDING_X 20
#define TEXTFIELD_TEXT_PADDING_Y 0


@implementation TextField

-(void)awakeFromNib{
    [super awakeFromNib];

    self.font = [UIFont fontWithName:REGULAR_FONT size:self.font.pointSize];


    self.layer.borderWidth=TEXTFIELD_BORDER_WIDTH;
    [self setBorderColorGray];
    [self customizePlaceHoder];

}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , TEXTFIELD_TEXT_PADDING_X , TEXTFIELD_TEXT_PADDING_Y);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , TEXTFIELD_TEXT_PADDING_X , TEXTFIELD_TEXT_PADDING_Y);
}



-(void) customizePlaceHoder{

    UIColor *placeHolderTextColor = [UIColor lightGrayColor];

    [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName :[UIFont fontWithName:REGULAR_FONT size:self.font.pointSize], NSForegroundColorAttributeName:placeHolderTextColor  }]] ;

}

-(void) setBorderColorRed {

    UIColor *borderColor = [UIColor redColor];
    self.layer.borderColor= borderColor.CGColor;

}

-(void) setBorderColorGray{


     UIColor *borderColor = [UIColor lightGrayColor];
        self.layer.borderColor= borderColor.CGColor;
}

-(BOOL) isValid {

    if(_isRequired && [StringUtils isEmptyOrNull:self.text]) {
        [self setBorderColorRed];
        return NO;
    }
    return YES;

}


@end
