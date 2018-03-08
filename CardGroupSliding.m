//
//  CardGroupSliding.m
//
//  Created by Eccelor on 07/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardGroupSliding.h"
#import "CardSlidingCell.h"
#import "LayoutHelper.h"
#import "NSObject+Utilities.h"

@interface CardGroupSliding ()

@property (nonatomic) CGFloat calculatedWidth;

@property (nonatomic, retain, readonly) NSString *cellIdentifier;
@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *collectionFlowLayout;

@end

@implementation CardGroupSliding

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
    
    self.calculatedWidth = 0.0f;
    self.collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.iconRadius = 40.0f;
    self.iconSize = 80.0f;
    
    self.timer = [[NSTimer alloc] init];
    
    self.delegate = self;
    [self.collectionFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionFlowLayout];
    [self.collectionView registerClass:[CardSlidingCell class] forCellWithReuseIdentifier:self.cellIdentifier];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView setUserInteractionEnabled:NO];
    
    [self.backgroundImageView addSubview:self.labelSubtitle];
    [self.backgroundImageView addSubview:self.labelTitle];
    [self.backgroundImageView addSubview:self.collectionView];
    [self.backgroundImageView setBackgroundColor:[UIColor whiteColor]];
    
    [self.blurView removeFromSuperview];
    
    [self startSlide];
}

- (void) setIconRadius: (CGFloat) iconRadius
{
    _iconRadius = iconRadius;
    [self.collectionView reloadData];
}

- (void) setIconSize: (CGFloat) iconSize
{
    _iconSize = iconSize;
    [self.collectionView reloadData];
}

- (NSString *) cellIdentifier
{
    return @"SlidingCell";
}

- (void) startSlide
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(slide:) userInfo:nil repeats:YES];
}

- (void) stopSlide
{
    [self.timer invalidate];
}

- (void) slide: (NSTimer *) timer
{
    CGPoint startPoint = CGPointMake(self.calculatedWidth, 0.0f);
    if (CGPointEqualToPoint(startPoint, self.collectionView.contentOffset))
    {
        if (self.calculatedWidth < self.collectionView.contentSize.width)
            self.calculatedWidth = self.calculatedWidth + 0.3f;
        else
            self.calculatedWidth = self.calculatedWidth - self.frame.size.width;
        
        [self.collectionView setContentOffset:CGPointMake(self.calculatedWidth, 0.0f)];
    }
    else
        self.calculatedWidth = self.collectionView.contentOffset.x;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
    // Drawing code
    [super drawRect:rect];
    
    [self.labelSubtitle setTextColor:[self.textColor colorWithAlphaComponent:0.4f]];
    [self layout:NO];
}

- (void) layout: (BOOL) animating
{
    [super layout:animating];
    
    LayoutHelper *helper = [[LayoutHelper alloc] initWithRect:self.backgroundImageView.bounds];
    [self.collectionView setFrame:CGRectMake(0.0f, [helper percentageY:5.0f OfView:self.labelTitle], self.backgroundImageView.frame.size.width, self.backgroundImageView.bounds.size.height - self.blurView.frame.size.height)];
}

#pragma mark - Data Source

- (NSInteger) collectionView: (UICollectionView *) collectionView numberOfItemsInSection: (NSInteger) section
{
    if (![NSObject isNil:self.icons] && self.icons.count > 0)
        return self.icons.count;
    return 0;
}

- (UICollectionViewCell *) collectionView: (UICollectionView *) collectionView cellForItemAtIndexPath: (NSIndexPath *) indexPath
{
    UIImage *icon = [self.icons objectAtIndex:indexPath.item];
    
    CardSlidingCell *slidingCell = (CardSlidingCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [slidingCell setIcon:icon];
    [slidingCell setRadius:slidingCell.frame.size.height / 2.0f];
    return slidingCell;
}

#pragma mark - Flow Delegate

- (CGSize) collectionView: (UICollectionView *) collectionView layout: (UICollectionViewLayout *) collectionViewLayout sizeForItemAtIndexPath: (NSIndexPath *) indexPath
{
    self.iconSize = self.collectionView.frame.size.height / 3.0f - self.collectionFlowLayout.minimumLineSpacing;
    return CGSizeMake(self.iconSize, self.iconSize);
}

@end
