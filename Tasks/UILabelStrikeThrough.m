//
//  UILabelStrikeThrough.m
//  Tasks
//
//  Created by Hieu Bui on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UILabelStrikeThrough.h"


@implementation UILabelStrikethrough
@synthesize xOffset, yOffset, widthOffset, stroke;
@synthesize strokeColor;
@synthesize strikeThrough;

-(void) dealloc {
    [super dealloc];
    [strokeColor release];
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.xOffset = 0;
        self.yOffset = 0;
        self.widthOffset = 0;
        self.stroke = 2;
        self.strokeColor = [UIColor blackColor];
    }
    NSLog(@"UILabelStrikeThrough initWithFrame: %@", NSStringFromCGRect(frame));
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self=[super initWithCoder:decoder];
    self.xOffset = 0;
    self.yOffset = 0;
    self.widthOffset = 0;
    self.stroke = 2;
    self.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    NSLog(@"UILabelStrikeThrough initWithCoder");
    return self;
}



-(id) initWithFrame:(CGRect)frame xOffset:(int)_xOffset yOffset:(int)_yOffset widthOffset:(int)_widthOffset stroke:(int)_stroke strokeColor:(UIColor*)_strokeColor {
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+_widthOffset-_xOffset, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.xOffset = _xOffset;
        self.yOffset = _yOffset;
        self.widthOffset = _widthOffset;
        self.stroke = _stroke;
        self.strokeColor = _strokeColor;
    }
    return self;    
}


- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0-self.xOffset, 0, 0+self.widthOffset};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (void)drawRect:(CGRect)rect {
    
    if(self.strikeThrough) {
        
       // NSLog(@"UILabelStrikeThrough text: %@",self.text);
        
        CGSize size = [self.text sizeWithFont:self.font constrainedToSize:self.frame.size];
        CGContextRef c = UIGraphicsGetCurrentContext();
        
        UIColor *currentColor=[UIColor blackColor];
        CGContextSetLineWidth(c, self.stroke);
        CGContextSetStrokeColorWithColor(c, currentColor.CGColor);
        int halfWayUp = (size.height - self.bounds.origin.y) / 2 + self.yOffset;
         //NSLog(@"color: %@ stroke: %i halfWayUp: %i", self.strokeColor, self.stroke, halfWayUp);
        CGContextMoveToPoint(c, self.bounds.origin.x + self.xOffset, halfWayUp );
        CGContextAddLineToPoint(c, self.bounds.origin.x + size.width + self.widthOffset - self.xOffset, halfWayUp);
        CGContextStrokePath(c);
    }
    /*
    UIColor *currentColor=[UIColor blackColor];
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 4);
    CGContextSetStrokeColorWithColor(c, currentColor.CGColor);
    CGContextMoveToPoint(c, 0, 10);
    CGContextAddLineToPoint(c, 100, 10);
    CGContextStrokePath(c);
    [currentColor release];
     */
    [super drawRect:rect];
}

@end