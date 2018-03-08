//
//  LayoutHelper.h
//
//  Created by Eccelor on 06/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LayoutHelper : NSObject

- (instancetype) initWithRect: (CGRect) rect;

- (CGFloat) percentageX: (CGFloat) percent;
- (CGFloat) percentageY: (CGFloat) percent;
- (CGFloat) percentageX: (CGFloat) percent OfView: (UIView *) view;
- (CGFloat) percentageY: (CGFloat) percent OfView: (UIView *) view;
- (CGFloat) remainingPercentageX: (CGFloat) percent FromWidth: (CGFloat) width;
- (CGFloat) remainingPercentageY: (CGFloat) percent FromHeight: (CGFloat) height;
- (CGFloat) remainingPercentageX: (CGFloat) percent FromWidth: (CGFloat) width OfView: (UIView *) view;
- (CGFloat) remainingPercentageY: (CGFloat) percent FromHeight: (CGFloat) height OfView: (UIView *) view;

+ (CGFloat) percentageHeight: (CGFloat) percent OfView: (UIView *) view;
+ (CGFloat) percentageWidth: (CGFloat) percent OfView: (UIView *) view;

+ (CGFloat) percentageXOfScreen: (CGFloat) percent;
+ (CGFloat) percentageYOfScreen: (CGFloat) percent;

@end
