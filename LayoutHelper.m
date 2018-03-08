//
//  LayoutHelper.m
//
//  Created by Eccelor on 06/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "LayoutHelper.h"

@interface LayoutHelper ()

@property (nonatomic) CGRect rect;

@end

@implementation LayoutHelper

- (instancetype) initWithRect: (CGRect) rect
{
    self = [super init];
    if (self)
        self.rect = rect;
    return self;
}

- (CGFloat) percentageX: (CGFloat) percent
{
    return percent * self.rect.size.width / 100.0f;
}

- (CGFloat) percentageY: (CGFloat) percent
{
    return percent * self.rect.size.height / 100.0f;
}

- (CGFloat) percentageX: (CGFloat) percent OfView: (UIView *) view
{
    return [self percentageX:percent] + CGRectGetMaxX(view.frame);
}

- (CGFloat) percentageY: (CGFloat) percent OfView: (UIView *) view
{
    return [self percentageY:percent] + CGRectGetMaxY(view.frame);
}

- (CGFloat) remainingPercentageX: (CGFloat) percent FromWidth: (CGFloat) width
{
    return self.rect.size.width - [self percentageX:percent] - width;
}

- (CGFloat) remainingPercentageY: (CGFloat) percent FromHeight: (CGFloat) height
{
    return self.rect.size.height - [self percentageY:percent] - height;
}

- (CGFloat) remainingPercentageX: (CGFloat) percent FromWidth: (CGFloat) width OfView: (UIView *) view
{
    return CGRectGetMinX(view.frame) - [self percentageX:percent] - width;
}

- (CGFloat) remainingPercentageY: (CGFloat) percent FromHeight: (CGFloat) height OfView: (UIView *) view
{
    return CGRectGetMinY(view.frame) - [self percentageY:percent] - height;
}

+ (CGFloat) percentageHeight: (CGFloat) percent OfView: (UIView *) view
{
    return view.frame.size.height * percent / 100;
}

+ (CGFloat) percentageWidth: (CGFloat) percent OfView: (UIView *) view
{
    return view.frame.size.width * percent / 100;
}

+ (CGFloat) percentageXOfScreen: (CGFloat) percent
{
    return [UIScreen mainScreen].bounds.size.width * percent / 100;
}

+ (CGFloat) percentageYOfScreen: (CGFloat) percent
{
    return [UIScreen mainScreen].bounds.size.height * percent / 100;
}

@end
