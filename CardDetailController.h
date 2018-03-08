//
//  CardDetailController.h
//
//  Created by Eccelor on 06/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface CardDetailController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) BOOL fullScreen;

@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) id<CardDelegate> delegate;

@property (nonatomic) CGRect originalFrame;

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *detailView;
@property (nonatomic, retain) UIView *snap;
@property (nonatomic, retain) UIVisualEffectView *blurView;

- (void) layoutWithRect: (CGRect) rect IsPresenting: (BOOL) presenting;
- (void) layoutWithRect: (CGRect) rect IsPresenting: (BOOL) presenting IsAnimating: (BOOL) animating;
- (void) layoutWithRect: (CGRect) rect IsPresenting: (BOOL) presenting IsAnimating: (BOOL) animating WithTransform: (CGAffineTransform) transform;

@end
