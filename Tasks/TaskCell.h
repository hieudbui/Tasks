//
//  TaskCell.h
//  Tasks
//
//  Created by Hieu Bui on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface TaskCell : UITableViewCell {
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *button;
- (void)initialize:(BOOL)selectedState text:(NSString *)text;
- (BOOL) toggle;
@end
