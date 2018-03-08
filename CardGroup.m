//
//  CardGroup.m
//
//  Created by Eccelor on 07/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardGroup.h"
#import "LayoutHelper.h"
#import "NSObject+Utilities.h"

@interface CardGroup ()

@end

@implementation CardGroup

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
    [super initialize];
    
    self.blurView = [[UIVisualEffectView alloc] init];
    self.vibrancyView = [[UIVisualEffectView alloc] init];
    
    self.labelSubtitle = [[UILabel alloc] init];
    self.labelTitle = [[UILabel alloc] init];
    
    self.blurEffect = UIBlurEffectStyleExtraLight;
    
    self.subtitle = @"from the editors";
    self.subtitleSize = 26.0f;
    
    self.title = @"Welcome to XI Cards!";
    self.titleSize = 26.0f;
    
    self.vibrancyView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:self.blurEffect]]];
    [self.vibrancyView.contentView addSubview:self.labelSubtitle];
    
    [self.blurView.contentView addSubview:self.labelTitle];
    [self.blurView.contentView addSubview:self.vibrancyView];
    
    [self.backgroundImageView addSubview:self.blurView];
}

- (void) setBlurEffect: (UIBlurEffectStyle) blurEffect
{
    _blurEffect = blurEffect;
    [self.blurView setEffect:[UIBlurEffect effectWithStyle:_blurEffect]];
}

- (void) setSubtitle: (NSString *) subtitle
{
    _subtitle = subtitle;
    [self.labelSubtitle setText:[_subtitle uppercaseString]];
}

- (void) setTitle: (NSString *) title
{
    _title = title;
    [self.labelTitle setText:_title];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
    // Drawing code
    [super drawRect:rect];
    
    [self.labelSubtitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelSubtitle setFont:[UIFont systemFontOfSize:self.subtitleSize weight:UIFontWeightSemibold]];
    [self.labelSubtitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelSubtitle setMinimumScaleFactor:0.1f];
    [self.labelSubtitle setNumberOfLines:0];
    [self.labelSubtitle setText:self.subtitle];
    [self.labelSubtitle setTextColor:self.textColor];
    
    [self.labelTitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelTitle setFont:[UIFont systemFontOfSize:self.titleSize weight:UIFontWeightBold]];
    [self.labelTitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelTitle setMinimumScaleFactor:0.1f];
    [self.labelTitle setNumberOfLines:2];
    [self.labelTitle setText:self.title];
    [self.labelTitle setTextColor:self.textColor];
    
    [self.blurView setEffect:[UIBlurEffect effectWithStyle:self.blurEffect]];
    
    [self layout:YES];
}

- (void) layout: (BOOL) animating
{
    [super layout:animating];
    
    LayoutHelper *helper = [[LayoutHelper alloc] initWithRect:self.backgroundImageView.bounds];
    
    [self.blurView setFrame:CGRectMake(0.0f, 0.0f, self.backgroundImageView.bounds.size.width, [helper percentageY:42.0f])];
    [self.vibrancyView setFrame:self.blurView.frame];
    
    [self.labelSubtitle setFrame:CGRectMake(self.insets, self.insets, [helper percentageX:80.0f], [helper percentageY:6.0f])];
    [self.labelTitle setFrame:CGRectMake(self.insets, [helper percentageY:0.0f OfView:self.labelSubtitle], [helper percentageX:80.0f], [helper percentageY:20.0f])];
    
    [self.labelTitle sizeToFit];
}

@end
