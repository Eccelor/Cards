//
//  CardDetailController.m
//
//  Created by Eccelor on 06/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardDetailController.h"
#import "CloseButton.h"
#import "LayoutHelper.h"
#import "NSObject+Utilities.h"

@interface CardDetailController ()

@property (nonatomic, retain) CloseButton *closeButton;

@end

@implementation CardDetailController

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype) initWithCoder: (NSCoder *) aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    self.closeButton = [[CloseButton alloc] init];
    self.originalFrame = CGRectZero;
    self.scrollView = [[UIScrollView alloc] init];
    self.snap = [[UIView alloc] init];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *))
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    
    self.snap = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.scrollView];
    
    if (![NSObject isNil:self.detailView])
    {
        [self.scrollView addSubview:self.detailView];
        [self.detailView setAlpha:0.0f];
        [self.detailView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    
    [self.blurView setFrame:self.view.bounds];
    
    [self.scrollView.layer setBackgroundColor:self.detailView ? self.detailView.backgroundColor.CGColor : [UIColor whiteColor].CGColor];
    [self.scrollView.layer setCornerRadius:self.fullScreen ? 0 : 20];
    [self.scrollView setDelegate:self];
    [self.scrollView setAlwaysBounceVertical:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self.blurView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewController)]];
    [self.closeButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setUserInteractionEnabled:YES];
    [self.view setUserInteractionEnabled:YES];
}

 - (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    [self.scrollView addSubview:self.card.backgroundImageView];
    
    if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardWillShowDetailView:)])
        [self.delegate cardWillShowDetailView:self.card];
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear:animated];
    self.originalFrame = self.scrollView.frame;
    
    if (self.fullScreen)
        [self.view addSubview:self.closeButton];
    
    [self.view insertSubview:self.snap belowSubview:self.blurView];
    
    if (![NSObject isNil:self.detailView])
    {
        [self.detailView setAlpha:1.0f];
        [self.detailView setFrame:CGRectMake(0.0f, CGRectGetMaxY(self.card.backgroundImageView.bounds), self.scrollView.frame.size.width, self.detailView.frame.size.height)];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(self.detailView.frame))];
        [self.closeButton setFrame:CGRectMake(CGRectGetMaxX(self.scrollView.frame) - 20.0f - 40.0f, CGRectGetMinY(self.scrollView.frame) + 20.0f, 40.0f, 40.0f)];
    }
    
    if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardDidShowDetailView:)])
        [self.delegate cardDidShowDetailView:self.card];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [super viewWillDisappear:animated];
    if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardWillCloseDetailView:)])
        [self.delegate cardWillCloseDetailView:self.card];
    if (![NSObject isNil:self.detailView])
        [self.detailView setAlpha:0.0f];
    [self.snap removeFromSuperview];
    [self.closeButton removeFromSuperview];
}

- (void) viewDidDisappear: (BOOL) animated
{
    [super viewDidDisappear:animated];
    if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardDidCloseDetailView:)])
        [self.delegate cardDidCloseDetailView:self.card];
}

- (void) layoutWithRect: (CGRect) rect IsPresenting: (BOOL) presenting
{
    [self layoutWithRect:rect IsPresenting:presenting IsAnimating:YES WithTransform:CGAffineTransformIdentity];
}

- (void) layoutWithRect: (CGRect) rect IsPresenting: (BOOL) presenting IsAnimating: (BOOL) animating
{
    [self layoutWithRect:rect IsPresenting:presenting IsAnimating:animating WithTransform:CGAffineTransformIdentity];
}

- (void) layoutWithRect: (CGRect) rect IsPresenting: (BOOL) presenting IsAnimating: (BOOL) animating WithTransform: (CGAffineTransform) transform
{
    if (!presenting)
    {
        [self.scrollView setFrame:CGRectApplyAffineTransform(rect, transform)];
        [self.card.backgroundImageView setFrame:self.scrollView.bounds];
        [self.card layout:animating];
        return;
    }
    
    if (self.fullScreen)
    {
        [self.scrollView setFrame:CGRectMake(self.view.bounds.origin.x, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    else
    {
        [self.scrollView setCenter:self.blurView.center];
        [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, 40.0f, [LayoutHelper percentageXOfScreen:85.0f], [LayoutHelper percentageYOfScreen:100.0f] - 20.0f)];
    }
    
    [self.scrollView setFrame:CGRectApplyAffineTransform(self.scrollView.frame, transform)];
    [self.card.backgroundImageView setFrame:CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width, self.card.backgroundImageView.bounds.size.height)];
    [self.card layout:animating];
}

- (void) dismissViewController
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0.0f)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    CGFloat y = self.scrollView.contentOffset.y;
    CGFloat originalOriginY = self.originalFrame.origin.y;
    CGFloat currentOriginY = self.originalFrame.origin.y;
    
    //[self.closeButton setAlpha:y - (self.card.backgroundImageView.bounds.size.height * 0.6)];
    
    if (y < 0 || currentOriginY > originalOriginY)
    {
        [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y - (y / 2.0f), self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0.0f)];
    }
    
    if (![NSObject isNil:self.delegate] && [self.delegate respondsToSelector:@selector(cardDetailIsScrolling:)])
        [self.delegate cardDetailIsScrolling:self.card];
}

- (void) scrollViewWillEndDragging: (UIScrollView *) scrollView withVelocity: (CGPoint) velocity targetContentOffset: (inout CGPoint *) targetContentOffset
{
    CGFloat originalOriginY = self.originalFrame.origin.y;
    CGFloat currentOriginY = self.scrollView.frame.origin.y;
    
    CGFloat max = 4.0f;
    CGFloat min = 2.0f;
    CGFloat speed = -velocity.y;
    
    if (speed > max)
        speed = max;
    
    if (speed < min)
        speed = min;
    
    speed = (max / speed * min) / 10.0f;
    
    if (currentOriginY - originalOriginY >= 60)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [UIView animateWithDuration:speed animations:^{
        [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.originalFrame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    }];
}

- (void) scrollViewDidEndDecelerating: (UIScrollView *) scrollView
{
    [UIView animateWithDuration:0.1f animations:^{
        [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.originalFrame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    }];
}

- (BOOL) prefersStatusBarHidden
{
    return self.fullScreen;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
