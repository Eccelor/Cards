//
//  CloseButton.m
//
//  Created by Eccelor on 06/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CloseButton.h"

@interface CloseButton ()

@property (nonatomic, retain) CAShapeLayer *lastLayer;
@property (nonatomic, retain) UIVisualEffectView *circleView;

@end

@implementation CloseButton

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame:frame];
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

- (void) initialize
{
    self.circleView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [self addSubview:self.circleView];
}

- (void) setFrame: (CGRect) frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
    // Drawing code
    [super drawRect:rect];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGFloat inset = rect.size.width * 0.3f;
    
    [path moveToPoint:CGPointMake(inset, inset)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - inset, CGRectGetMaxY(rect) - inset)];
    
    [path moveToPoint:CGPointMake(CGRectGetMaxX(rect) - inset, inset)];
    [path addLineToPoint:CGPointMake(inset, CGRectGetMaxY(rect) - inset)];
    
    [layer setPath:path.CGPath];
    [layer setStrokeColor:[UIColor blackColor].CGColor];
    [layer setLineWidth:2.0f];
    
    [self.lastLayer removeFromSuperlayer];
    self.lastLayer = layer;
    [self.layer addSublayer:self.lastLayer];
    
    [self.circleView setFrame:rect];
    [self.circleView.layer setCornerRadius:self.circleView.bounds.size.width / 2];
    [self.circleView setClipsToBounds:YES];
    [self.circleView setUserInteractionEnabled:NO];
}

@end
