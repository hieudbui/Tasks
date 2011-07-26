//
//  UILabelStrikeThrough.h
//  Tasks
//
//  Created by Hieu Bui on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabelStrikethrough : UILabel {
    int xOffset;
    int yOffset;
    int widthOffset;
    int stroke;
    UIColor* strokeColor;
}

@property (nonatomic) int xOffset;
@property (nonatomic) int yOffset;
@property (nonatomic) int widthOffset;
@property (nonatomic) int stroke;
@property (nonatomic,retain) UIColor* strokeColor;
@property (nonatomic) BOOL strikeThrough;


-(id) initWithFrame:(CGRect)frame xOffset:(int)_xOffset yOffset:(int)_yOffset widthOffset:(int)_widthOffset stroke:(int)_stroke strokeColor:(UIColor*)_strokeColor;
@end