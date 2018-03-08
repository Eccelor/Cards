//
//  CardHighlight.h
//
//  Created by Eccelor on 08/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "Card.h"

IB_DESIGNABLE
@interface CardHighlight : Card

@property (nonatomic) IBInspectable CGFloat buttonWidth;
@property (nonatomic) IBInspectable CGFloat iconRadius;
@property (nonatomic) IBInspectable CGFloat itemSubtitleSize;
@property (nonatomic) IBInspectable CGFloat itemTitleSize;
@property (nonatomic) IBInspectable CGFloat titleSize;

@property (nonatomic, retain) IBInspectable NSString *buttonText;
@property (nonatomic, retain) IBInspectable NSString *itemSubtitle;
@property (nonatomic, retain) IBInspectable NSString *itemTitle;
@property (nonatomic, retain) IBInspectable NSString *title;

@property (nonatomic, retain) UIButton *actionButton;
@property (nonatomic, retain) UIColor *lightColor;
@property (nonatomic, retain) IBInspectable UIImage *icon;
@property (nonatomic, retain) UIImageView *backgroundIconImageView;
@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UILabel *labelItemSubtitle;
@property (nonatomic, retain) UILabel *labelItemTitle;
@property (nonatomic, retain) UILabel *labelTitle;

@end
