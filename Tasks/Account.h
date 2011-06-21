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
    Google=1
} AccountType;

@interface Account : NSObject {
    
}

+(Account *) localAccount;
+(Account *) googleAccount;
@property AccountType type;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *password;


@end
