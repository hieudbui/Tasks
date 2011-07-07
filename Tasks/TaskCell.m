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

- (void) setTaskDescription:(NSString *)text 
{
    self.label.text=text;
}

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

- (void)dealloc
{
    [_label release];
    [super dealloc];
}

@end
