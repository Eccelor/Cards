//
//  CardArticle.h
//
//  Created by Eccelor on 07/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "Card.h"

IB_DESIGNABLE
@interface CardArticle : Card

@property (nonatomic) IBInspectable CGFloat subtitleSize;
@property (nonatomic) IBInspectable CGFloat titleSize;

@property (nonatomic, retain) IBInspectable NSString *category;
@property (nonatomic, retain) IBInspectable NSString *subtitle;
@property (nonatomic, retain) IBInspectable NSString *title;

@end
