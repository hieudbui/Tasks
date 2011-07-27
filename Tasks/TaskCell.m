//
//  TaskCell.m
//  Tasks
//
//  Created by Hieu Bui on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskCell.h"


@implementation TaskCell

@synthesize label=_label;
@synthesize button=_button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) selectButton
{
    [_button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [_button setSelected:YES];
}

- (void) unselectButton
{
    [_button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [_button setSelected:NO];
}


- (void)initialize:(BOOL)selectedState text:(NSString *)text
{
    self.label.text=text; 
    if(selectedState) {
        [self selectButton];
        self.label.strikeThrough=YES;
        
    }
    else {
        [self unselectButton];
        self.label.strikeThrough=NO;
    }
}


- (BOOL)toggle
{
    if ([_button isSelected]) {
        [self unselectButton];
        self.label.strikeThrough=NO;
    }else {
        [self selectButton];
        self.label.strikeThrough=YES;
    }
    [self.label setNeedsDisplay];
    return [_button isSelected];
}
    
- (void)dealloc
{
    [_label release];
    [_button release];
    [super dealloc];
}

@end
