//
//  CardArticle.m
//
//  Created by Eccelor on 07/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardArticle.h"
#import "LayoutHelper.h"

@interface CardArticle ()

@property (nonatomic, retain) UILabel *labelCategory;
@property (nonatomic, retain) UILabel *labelSubtitle;
@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UIView *backgroundSubtitleHolder;
@property (nonatomic, retain) UIVisualEffectView *backgroundSubtitle;

@end

@implementation CardArticle

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
    
    self.labelCategory = [[UILabel alloc] init];
    self.labelSubtitle = [[UILabel alloc] init];
    self.labelTitle = [[UILabel alloc] init];
    
    self.backgroundSubtitle = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    self.backgroundSubtitleHolder = [[UIView alloc] init];
    
    [self.backgroundSubtitleHolder addSubview:self.backgroundSubtitle];
    //[self.labelSubtitle sendSubviewToBack:self.backgroundSubtitle];
    
    self.category = @"world premier";
    
    self.subtitle = @"Inside the extraordinary world of Monument Valley 2";
    self.subtitleSize = 17.0f;
    
    self.title = @"The Art of the Impossible";
    self.titleSize = 26.0f;
    
    [self.backgroundImageView addSubview:self.labelCategory];
    [self.backgroundImageView addSubview:self.backgroundSubtitleHolder];
    [self.backgroundImageView addSubview:self.labelSubtitle];
    [self.backgroundImageView addSubview:self.labelTitle];
}

- (void) setCategory: (NSString *) category
{
    _category = [category uppercaseString];
    [self.labelCategory setText:_category];
}

- (void) setSubtitle: (NSString *) subtitle
{
    _subtitle = subtitle;
    [self.labelSubtitle setText:_subtitle];
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
    
    [self.labelCategory setAdjustsFontSizeToFitWidth:YES];
    [self.labelCategory setFont:[UIFont systemFontOfSize:100.0f weight:UIFontWeightBold]];
    [self.labelCategory setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelCategory setMinimumScaleFactor:0.1f];
    [self.labelCategory setNumberOfLines:0];
    [self.labelCategory setShadowColor:[UIColor blackColor]];
    [self.labelCategory setShadowOffset:CGSizeZero];
    [self.labelCategory setText:self.category];
    [self.labelCategory setTextColor:[self.textColor colorWithAlphaComponent:0.3f]];
    
    [self.labelSubtitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelSubtitle setFont:[UIFont systemFontOfSize:self.subtitleSize weight:UIFontWeightMedium]];
    [self.labelSubtitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelSubtitle setMinimumScaleFactor:0.1f];
    [self.labelSubtitle setNumberOfLines:0];
    [self.labelSubtitle setShadowColor:[UIColor blackColor]];
    [self.labelSubtitle setShadowOffset:CGSizeZero];
    [self.labelSubtitle setText:self.subtitle];
    [self.labelSubtitle setTextAlignment:NSTextAlignmentLeft];
    [self.labelSubtitle setTextColor:self.textColor];
    
    [self.backgroundSubtitleHolder setUserInteractionEnabled:NO];
    
    [self.backgroundSubtitle setClipsToBounds:YES];
    [self.backgroundSubtitle setUserInteractionEnabled:NO];
    
    [self.labelTitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelTitle setBaselineAdjustment:UIBaselineAdjustmentNone];
    [self.labelTitle setFont:[UIFont systemFontOfSize:self.titleSize weight:UIFontWeightBold]];
    [self.labelTitle setLineBreakMode:NSLineBreakByClipping];
    [self.labelTitle setMinimumScaleFactor:0.1f];
    [self.labelTitle setNumberOfLines:2];
    [self.labelTitle setText:self.title];
    [self.labelTitle setTextColor:self.textColor];
    
    [self layout:YES];
}

- (void) layout: (BOOL) animating
{
    [super layout:animating];
    
    LayoutHelper *helper = [[LayoutHelper alloc] initWithRect:self.backgroundImageView.bounds];
    [self.labelCategory setFrame:CGRectMake(self.insets, self.insets, [helper percentageX:80.0f], [helper percentageY:7.0f])];
    [self.labelSubtitle setFrame:CGRectMake(self.insets + 16.0f, [helper remainingPercentageY:0.0f FromHeight:[helper percentageY:14.0f]] - self.insets, [helper percentageX:80.0f], [helper percentageY:14.0f])];
    [self.labelSubtitle sizeToFit];
    
    [self.backgroundSubtitleHolder setFrame:CGRectMake(self.labelSubtitle.frame.origin.x - 16, self.labelSubtitle.frame.origin.y - 8, self.labelSubtitle.frame.size.width + 32, self.labelSubtitle.frame.size.height + 16)];
    [self.backgroundSubtitle setFrame:self.backgroundSubtitleHolder.bounds];
    [self.backgroundSubtitle.layer setCornerRadius:(self.labelSubtitle.bounds.size.height + 16) / 2];
    
    [self.labelTitle setFrame:CGRectMake(self.insets, [helper percentageY:1.0f OfView:self.labelCategory], [helper percentageX:80.0f], [helper percentageY:17.0f])];
    [self.labelTitle sizeToFit];
}

@end

