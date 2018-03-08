//
//  CardHighlight.m
//
//  Created by Eccelor on 08/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardHighlight.h"
#import "LayoutHelper.h"
#import "NSObject+Utilities.h"
#import "UILable+Card.h"

@implementation CardHighlight

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
    
    self.actionButton = [[UIButton alloc] init];
    self.backgroundIconImageView = [[UIImageView alloc] init];
    self.iconImageView = [[UIImageView alloc] init];
    self.labelItemSubtitle = [[UILabel alloc] init];
    self.labelItemTitle = [[UILabel alloc] init];
    self.labelTitle = [[UILabel alloc] init];
    self.lightColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:244.0f / 255.0f alpha:1.0f];
    
    self.buttonText = @"view";
    self.itemSubtitle = @"Flap that!";
    self.itemTitle = @"Flappy Bird";
    self.title = @"welcome \nto \ncards!";
    
    self.iconRadius = 16.0f;
    self.itemSubtitleSize = 14.0f;
    self.itemTitleSize = 16.0f;
    self.titleSize = 26.0f;
    
    [self.actionButton addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundImageView addSubview:self.actionButton];
    [self.backgroundImageView addSubview:self.iconImageView];
    [self.backgroundImageView addSubview:self.labelItemSubtitle];
    [self.backgroundImageView addSubview:self.labelItemTitle];
    [self.backgroundImageView addSubview:self.labelTitle];
    
    if ([NSObject isNil:self.backgroundImage])
        [self.backgroundImageView addSubview:self.backgroundIconImageView];
    else
        [self.backgroundIconImageView setAlpha:0.0f];
}

 - (void) setButtonText: (NSString *) buttonText
{
    _buttonText = buttonText;
    [self setNeedsDisplay];
}

- (void) setIcon: (UIImage *) icon
{
    _icon = icon;
    [self.backgroundImageView setImage:_icon];
    [self.iconImageView setImage:_icon];
}

 - (void) setIconRadius: (CGFloat) iconRadius
{
    _iconRadius = iconRadius;
    [self.backgroundImageView.layer setCornerRadius:_iconRadius * 2.0f];
    [self.iconImageView.layer setCornerRadius:_iconRadius];
}

- (void) setItemSubtitle: (NSString *) itemSubtitle
{
    _itemSubtitle = itemSubtitle;
    [self.labelItemSubtitle setText:_itemSubtitle];
}

- (void) setItemTitle: (NSString *) itemTitle
{
    _itemTitle = itemTitle;
    [self.labelItemTitle setText:_itemTitle];
}

- (void) setTitle: (NSString *) title
{
    _title = title;
    [self.labelTitle setText:[_title uppercaseString]];
    [self.labelTitle lineHeight:0.70f];
}

- (void) actionButtonTapped: (UIButton *) button
{
    [UIView animateWithDuration:0.2f animations:^{
        [self.actionButton setTransform:CGAffineTransformMakeScale(0.90f, 0.90f)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [self.actionButton setTransform:CGAffineTransformIdentity];
        }];
        if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardHighlight:didTapButton:)])
            [self.delegate cardHighlight:self didTapButton:self.actionButton];
    }];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
    // Drawing code
    [super drawRect:rect];
    
    [self.actionButton setBackgroundColor:[UIColor clearColor]];
    [self.actionButton.layer setBackgroundColor:self.lightColor.CGColor];
    [self.actionButton setClipsToBounds:YES];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont systemFontOfSize:16.0f weight:UIFontWeightBlack] forKey:NSFontAttributeName];
    [attributes setObject:self.tintColor forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *textButton = [[NSAttributedString alloc] initWithString:[self.buttonText uppercaseString] attributes:attributes];
    [self.actionButton setAttributedTitle:textButton forState:UIControlStateNormal];
    
    self.buttonWidth = (CGFloat) ((textButton.length + 2) * 10);
    
    [self.backgroundIconImageView setImage:self.icon];
    [self.backgroundIconImageView setAlpha:![NSObject isNil:self.backgroundImage] ? 0.0f : 0.6f];
    [self.backgroundIconImageView setClipsToBounds:YES];
    
    [self.iconImageView setImage:self.icon];
    [self.iconImageView setClipsToBounds:YES];
    
    [self.labelItemSubtitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelItemSubtitle setFont:[UIFont systemFontOfSize:self.itemSubtitleSize]];
    [self.labelItemSubtitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelItemSubtitle setMinimumScaleFactor:0.1f];
    [self.labelItemSubtitle setNumberOfLines:2];
    [self.labelItemSubtitle setText:self.itemSubtitle];
    [self.labelItemSubtitle setTextColor:self.textColor];
    [self.labelItemSubtitle sizeToFit];
    
    [self.labelItemTitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelItemTitle setFont:[UIFont boldSystemFontOfSize:self.itemTitleSize]];
    [self.labelItemTitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelItemTitle setMinimumScaleFactor:0.1f];
    [self.labelItemTitle setNumberOfLines:0];
    [self.labelItemTitle setText:self.itemTitle];
    [self.labelItemTitle setTextColor:self.textColor];
    
    [self.labelTitle setAdjustsFontSizeToFitWidth:YES];
    [self.labelTitle setFont:[UIFont systemFontOfSize:self.titleSize weight:UIFontWeightHeavy]];
    [self.labelTitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.labelTitle setMinimumScaleFactor:0.1f];
    [self.labelTitle setNumberOfLines:3];
    [self.labelTitle setText:self.title];
    [self.labelTitle setTextColor:self.textColor];
    [self.labelTitle lineHeight:0.70f];
    [self.backgroundImageView bringSubviewToFront:self.labelTitle];
    
    [self layout:YES];
}

- (void) layout: (BOOL) animating
{
    [super layout:animating];
    
    LayoutHelper *helper = [[LayoutHelper alloc] initWithRect:self.backgroundImageView.frame];
    
    [self.actionButton setFrame:CGRectMake([helper remainingPercentageX:0.0f FromWidth:self.buttonWidth] - self.insets, [helper remainingPercentageY:0.0f FromHeight:32.0f] - self.insets, self.buttonWidth, 32.0f)];
    [self.actionButton.layer setCornerRadius:self.actionButton.layer.bounds.size.height / 2.0f];
    
    [self.backgroundIconImageView setTransform:CGAffineTransformIdentity];
    
    [self.iconImageView setFrame:CGRectMake(self.insets, self.insets, [helper percentageY:25.0f], [helper percentageY:25.0f])];
    [self.iconImageView.layer setCornerRadius:self.iconRadius];
    
    [self.backgroundIconImageView setFrame:CGRectMake([helper remainingPercentageX:0.0f FromWidth:self.backgroundIconImageView.frame.size.width] + [LayoutHelper percentageWidth:40.0f OfView:self.backgroundIconImageView], 0.0f, self.iconImageView.bounds.size.width * 2.0f, self.iconImageView.bounds.size.width * 2.0f)];
    [self.backgroundIconImageView setTransform:CGAffineTransformMakeRotation((CGFloat) -(M_PI/6))];
    [self.backgroundIconImageView.layer setCornerRadius:self.iconRadius * 2.0f];
    
    [self.labelItemSubtitle sizeToFit];
    [self.labelItemSubtitle setFrame:CGRectMake(self.insets, [helper remainingPercentageY:0.0f FromHeight:self.labelItemSubtitle.bounds.size.height - self.insets], self.labelItemSubtitle.frame.size.width, self.labelItemSubtitle.frame.size.height)];
    
    [self.labelItemTitle setFrame:CGRectMake(self.insets, [helper remainingPercentageY:0.0f FromHeight:[helper percentageY:9.0f] OfView:self.labelItemSubtitle], [helper percentageX:80.0f] - self.buttonWidth, [helper percentageY:9.0f])];
    
    [self.labelTitle setFrame:CGRectMake(self.insets, [helper percentageY:5.0f OfView:self.iconImageView], (self.originalFrame.size.width * 0.65) + ((self.backgroundImageView.bounds.size.width - self.originalFrame.size.width) / 3.0f), [helper percentageY:35.0f])];
}

@end
