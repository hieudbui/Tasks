//
//  TaskCell.h
//  Tasks
//
//  Created by Hieu Bui on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TaskCell : UITableViewCell {
}

@property (nonatomic, retain) IBOutlet UILabel *label;
- (void) setTaskDescription:(NSString *)text;

@end
