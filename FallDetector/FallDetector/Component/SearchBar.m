//
//  SearchBar.m
//  Yuru
//
//  Created by Waheeda on 6/27/13.
//  Copyright (c) 2013 Ali Zohair. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

-(void) setCloseButtonTitle: (NSString *) title forState: (UIControlState)state
{
    [self setTitle: title forState: state forView:self];
}

-(void) setTitle: (NSString *) title forState: (UIControlState)state forView: (UIView *)view
{
    UIButton *cancelButton = nil;
    for(UIView *subView in view.subviews){
        if([subView isKindOfClass:UIButton.class])
        {
            cancelButton = (UIButton*)subView;
        }
        else
        {
            [self setTitle:title forState:state forView:subView];
        }
    }
    
    if (cancelButton)
        [cancelButton setTitle:title forState:state];
    
}

@end
