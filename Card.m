//
//  Card.m
//
//  Created by Eccelor on 05/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "Animator.h"
#import "Card.h"
#import "CardDetailController.h"
#import "LayoutHelper.h"
#import "NSObject+Utilities.h"

@interface Card ()

@property (nonatomic, retain) CardDetailController *detailController;

@end

@implementation Card

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
    self.backgroundImageView = [[UIImageView alloc] init];
    [self.backgroundImageView setUserInteractionEnabled:YES];
    if ([NSObject isNil:self.backgroundImageView.backgroundColor])
    {
        [self.backgroundImageView setBackgroundColor:[UIColor whiteColor]];
        [super setBackgroundColor:[UIColor clearColor]];
    }
    [self addSubview:self.backgroundImageView];
    
    self.cardRadius = 20.0f;
    self.contentInset = 6.0f;
    
    self.detailController = [[CardDetailController alloc] init];
    [self.detailController setTransitioningDelegate:self];
    
    self.originalFrame = CGRectZero;
    self.parallax = YES;
    self.presenting = NO;
    self.shadowBlur = 14.0f;
    self.shadowColor = [UIColor grayColor];
    self.shadowOpacity = 0.6f;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [self.tapRecognizer setDelegate:self];
    [self.tapRecognizer setCancelsTouchesInView:NO];
    [self addGestureRecognizer:self.tapRecognizer];
    
    self.textColor = [UIColor blackColor];
}

- (void) setBackgroundImage: (UIImage *) backgroundImage
{
    _backgroundImage = backgroundImage;
    [self.backgroundImageView setImage:_backgroundImage];
}

- (void) setBackgroundColor: (UIColor *) backgroundColor
{
    _backgroundColor = backgroundColor;
    [self.backgroundImageView setBackgroundColor:_backgroundColor];
}

- (void) setCardRadius: (CGFloat) cardRadius
{
    _cardRadius = cardRadius;
    [self.layer setCornerRadius:_cardRadius];
}

- (void) setContentInset: (CGFloat) contentInset
{
    _contentInset = contentInset;
    self.insets = [[[LayoutHelper alloc] initWithRect:self.originalFrame] percentageX:_contentInset];
}

- (void) setParallax: (BOOL) parallax
{
    _parallax = parallax;
    if (([NSObject isNil:self.motionEffects] || self.motionEffects.count <= 0) && _parallax)
    {
        [self goParallax];
    }
    else if (!_parallax && ![NSObject isNil:self.motionEffects] && self.motionEffects.count > 0)
    {
        for (int i = 0; i < self.motionEffects.count; i++)
        {
            [self removeMotionEffect:[self.motionEffects objectAtIndex:i]];
        }
    }
}

- (void) setShadowBlur: (CGFloat) shadowBlur
{
    _shadowBlur = shadowBlur;
    [self.layer setShadowRadius:_shadowBlur];
}

- (void) setShadowColor: (UIColor *) shadowColor
{
    _shadowColor = shadowColor;
    [self.layer setShadowColor:_shadowColor.CGColor];
}

- (void) setShadowOpacity: (CGFloat) shadowOpacity
{
    _shadowOpacity = shadowOpacity;
    [self.layer setShadowOpacity:_shadowOpacity];
}

- (void) goParallax
{
    CGFloat amount = 20.0f;
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    [horizontalEffect setMinimumRelativeValue:@(-amount)];
    [horizontalEffect setMaximumRelativeValue:@(amount)];
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    [verticalEffect setMinimumRelativeValue:@(-amount)];
    [verticalEffect setMaximumRelativeValue:@(amount)];
    
    UIMotionEffectGroup *effectGroup = [[UIMotionEffectGroup alloc] init];
    [effectGroup setMotionEffects:[NSArray arrayWithObjects:horizontalEffect, verticalEffect, nil]];
    [self addMotionEffect:effectGroup];
}

- (void) layout
{
    [self layout:YES];
}

- (void) layout: (BOOL) animating
{
    
}

- (void) shouldPresent: (UIViewController *) contentController From:(UIViewController *) superController FullScreen: (BOOL) fullScreen
{
    self.superController = superController;
    [self.detailController addChildViewController:contentController];
    [self.detailController setDetailView:contentController.view];
    [self.detailController setCard:self];
    [self.detailController setDelegate:self.delegate];
    [self.detailController setFullScreen:fullScreen];
}

- (void) cardTapped
{
    if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardDidTapInside:)])
        [self.delegate cardDidTapInside:self];
    
    if (![NSObject isNil:self.superController])
        [self.superController presentViewController:self.detailController animated:YES completion:nil];
    else
        [self resetAnimated];
}

- (void) pushBackAnimated
{
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformMakeScale(0.95f, 0.95f);
    }];
}

- (void) resetAnimated
{
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - Gesture Recognizer Delegate

- (void) touchesBegan: (NSSet<UITouch *> *) touches withEvent: (UIEvent *) event
{
    if (![NSObject isNil:self.superview])
    {
        self.originalFrame = [self.superview convertRect:self.frame toView:nil];
    }
    [self pushBackAnimated];
}

- (void) touchesEnded: (NSSet<UITouch *> *) touches withEvent: (UIEvent *) event
{
    [self cardTapped];
}

#pragma mark - Transitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController: (UIViewController *) presented presentingController: (UIViewController *) presenting sourceController: (UIViewController *) source
{
    return [[Animator alloc] initWithPresenting:YES FromCard:self];
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController: (UIViewController *) dismissed
{
    return [[Animator alloc] initWithPresenting:NO FromCard:self];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
    // Drawing code
    [super drawRect:rect];
    self.originalFrame = rect;
    
    [self.layer setCornerRadius:self.cardRadius];
    [self.layer setShadowColor:self.shadowColor.CGColor];
    [self.layer setShadowOffset:CGSizeZero];
    [self.layer setShadowOpacity:self.shadowOpacity];
    [self.layer setShadowRadius:self.shadowBlur];
    
    [self.backgroundImageView setClipsToBounds:YES];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.backgroundImageView setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height)];
    [self.backgroundImageView setImage:self.backgroundImage];
    [self.backgroundImageView.layer setCornerRadius:self.layer.cornerRadius];
    
    self.contentInset = 6.0f;
}

@end
