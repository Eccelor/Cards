//
//  Card.h
//
//  Created by Eccelor on 05/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card;

@protocol CardDelegate <NSObject>

@optional

- (void) cardDidTapInside: (Card *) card;
- (void) cardWillShowDetailView: (Card *) card;
- (void) cardDidShowDetailView: (Card *) card;
- (void) cardWillCloseDetailView: (Card *) card;
- (void) cardDidCloseDetailView: (Card *) card;
- (void) cardIsShowingDetail: (Card *) card;
- (void) cardIsHidingDetail: (Card *) card;
- (void) cardDetailIsScrolling: (Card *) card;

- (void) cardHighlight: (Card *) card didTapButton: (UIButton *) button;
//- (void) cardPlayerDidPlay: (CardPlayer *) card;
//- (void) cardPlayerDidPause: (CardPlayer *) card;

@end


IB_DESIGNABLE
@interface Card : UIView <CardDelegate, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic) BOOL parallax;
@property (nonatomic) BOOL presenting;

@property (nonatomic) IBInspectable CGFloat cardRadius;
@property (nonatomic) IBInspectable CGFloat contentInset;
@property (nonatomic) CGFloat insets;
@property (nonatomic) IBInspectable CGFloat shadowBlur;
@property (nonatomic) IBInspectable CGFloat shadowOpacity;
@property (nonatomic) CGRect originalFrame;

@property (nonatomic, retain) id<CardDelegate> delegate;

@property (nonatomic, retain) IBInspectable UIColor *backgroundColor;
@property (nonatomic, retain) IBInspectable UIColor *shadowColor;
@property (nonatomic, retain) IBInspectable UIColor *textColor;

@property (nonatomic, retain) IBInspectable UIImage *backgroundImage;
@property (nonatomic, retain) UIImageView *backgroundImageView;

@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;

@property (nonatomic, retain) UIViewController *superController;

- (void) initialize;
- (void) layout;
- (void) layout: (BOOL) animating;
- (void) shouldPresent: (UIViewController *) contentController From: (UIViewController *) superController FullScreen: (BOOL) fullScreen;

@end
