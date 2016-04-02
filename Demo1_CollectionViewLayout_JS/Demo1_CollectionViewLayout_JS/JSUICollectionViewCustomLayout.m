//
//  JSUICollectionViewCustomLayout.m
//  Demo1_CollectionViewLayout_JS
//
//  Created by  江苏 on 16/3/7.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSUICollectionViewCustomLayout.h"
#define TIEM_SIZE 150.0

@implementation JSUICollectionViewCustomLayout
- (id)init
{
    self = [super init];
    if (self) {
        if(![self initialize]) self = nil;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        if (![self initialize]) {
            self=nil;
        }
    }
    return self;
}
//封装供上面的初始化方法
-(BOOL)initialize{
    //决定cell的大小
    self.itemSize=CGSizeMake(TIEM_SIZE, TIEM_SIZE);
    //CollectView的滚动方向
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //CollectView的内边距
    self.sectionInset=UIEdgeInsetsMake(50, 0, 50, 0);
    //cell之间的间距
    self.minimumInteritemSpacing=100.0;
    return YES;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;//当边界更改时更新布局
}
#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3
//返回当前rect中的所有元素（当前屏幕的cell）的布局
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* array=[super layoutAttributesForElementsInRect:rect];
    //找出需要修改布局属性的cell属性，对其进行修改
    CGRect visibleRect;
    visibleRect.origin=self.collectionView.contentOffset;
    visibleRect.size=self.collectionView.bounds.size;
    for(UICollectionViewLayoutAttributes* attribute in array) {
        CGFloat distance=CGRectGetMidX(visibleRect)-attribute.center.x;
        CGFloat distance2=distance/ACTIVE_DISTANCE;
        if (ABS(distance)<100) {
            CGFloat zoom=1+ZOOM_FACTOR*4-ABS(distance2);
            attribute.transform3D=CATransform3DMakeScale(1.05, 1.05, 1);
        }
    }
    return array;
}
//当用户手指离开时调用此方法，第一个参数是系统建议停留的位置，第二个参数是滚动的速度
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //中心线
    CGFloat horizontalCenter=proposedContentOffset.x+self.collectionView.bounds.size.width/2;
    //滚动目标Rect
    CGRect targetRect=CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    //滚动目标rect内的所有cell的属性对象
    NSArray* array=[super layoutAttributesForElementsInRect:targetRect];
    //对屏幕中UICollectViewLayoutAttributes逐个与屏幕中心进行比较，找出离屏幕中心最近的一个，并计算其离中心的距离
    CGFloat offsetAdjustment=MAXFLOAT;
    for(UICollectionViewLayoutAttributes* attributes in array){
        CGFloat itemHorizontalCenter=attributes.center.x;
        if ((ABS(itemHorizontalCenter)-horizontalCenter)<ABS(offsetAdjustment)) {
            offsetAdjustment=itemHorizontalCenter-horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x+offsetAdjustment, proposedContentOffset.y);
}
@end
