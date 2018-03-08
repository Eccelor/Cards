//
//  SlidingCell.m
//
//  Created by Eccelor on 08/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardSlidingCell.h"

@implementation CardSlidingCell

- (instancetype) init
{
    self = [super init];
    if (self)
        [self initialize];
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self initialize];
    return self;
}

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initialize];
    return self;
}

- (void) initialize
{
    self.icon = [UIImage imageNamed:@"1"];
    self.iconImageView = [[UIImageView alloc] init];
    self.radius = 15.0f;
    
    [self addSubview:self.iconImageView];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
}

- (void) drawRect: (CGRect) rect
{
    [super drawRect:rect];
    
    [self.iconImageView setClipsToBounds:YES];
    [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.iconImageView setFrame:CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height)];
    [self.iconImageView setImage:self.icon];
    [self.iconImageView.layer setCornerRadius:self.radius];
    [self.layer setCornerRadius:self.radius];
}

@end
