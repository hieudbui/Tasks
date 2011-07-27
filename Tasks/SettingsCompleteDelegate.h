//
//  SettingsCompleteDelegate.h
//  Tasks
//
//  Created by Hieu Bui on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SettingsViewController;
@class Settings;

@protocol SettingsCompleteDelegate <NSObject>

- (void) settingsCompleteViewController:(SettingsViewController *)settingsViewController
                               settings:(Settings *)settings;
@end

