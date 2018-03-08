//
//  CardGroupSliding.h
//
//  Created by Eccelor on 07/03/18.
//  Copyright © 2018 Eccelor. All rights reserved.
//

#import "CardGroup.h"

IB_DESIGNABLE
@interface CardGroupSliding : CardGroup <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) IBInspectable CGFloat iconRadius;
@property (nonatomic) IBInspectable CGFloat iconSize;

@property (nonatomic, retain) NSMutableArray<UIImage *> *icons;

@end
