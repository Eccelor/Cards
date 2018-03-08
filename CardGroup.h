//
//  CardGroup.h
//
//  Created by Eccelor on 07/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "Card.h"

IB_DESIGNABLE
@interface CardGroup : Card

@property (nonatomic) IBInspectable CGFloat subtitleSize;
@property (nonatomic) IBInspectable CGFloat titleSize;

@property (nonatomic, retain) IBInspectable NSString *subtitle;
@property (nonatomic, retain) IBInspectable NSString *title;

@property (nonatomic) IBInspectable UIBlurEffectStyle blurEffect;

@property (nonatomic, retain) UILabel *labelSubtitle;
@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UIVisualEffectView *blurView;
@property (nonatomic, retain) UIVisualEffectView *vibrancyView;

@end
