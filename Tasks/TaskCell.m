//
//  TaskCell.m
//  Tasks
//
//  Created by Hieu Bui on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskCell.h"
#import "Task.h"


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


- (void)initialize:(Task *)task
{
    _label.text=[task name]; 
    if(task.completed) {
        [self selectButton];
    }
    else {
        [self unselectButton];
    }
}


- (void)toggle
{
    if ([_button isSelected]) {
        [self unselectButton];
    }else {
        [self selectButton];
    }
}
    
- (void)dealloc
{
    [_label release];
    [_button release];
    [super dealloc];
}

@end
