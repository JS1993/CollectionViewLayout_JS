//
//  JSCollectionViewCell.m
//  Demo1_CollectionViewLayout_JS
//
//  Created by  江苏 on 16/3/7.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSCollectionViewCell.h"

@implementation JSCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.label.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.font=[UIFont boldSystemFontOfSize:30.0];
        self.label.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:self.label];
        self.contentView.layer.borderWidth=1.0f;
        self.contentView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    return self;
}
@end
