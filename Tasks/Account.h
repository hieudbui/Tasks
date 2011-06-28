//
//  Account.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    Local=0,
    Google=1,
    All=3
} AccountType;

@interface Account : NSObject {
    
}

+(Account *) localAccount;
+(Account *) googleAccount;
+(Account *) allAccount;

@property AccountType type;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSArray *taskLists;


@end
