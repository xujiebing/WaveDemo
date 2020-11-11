//
//  WaveView.m
//  WaveDemo
//
//  Created by 徐结兵 on 2020/8/18.
//  Copyright © 2020 徐结兵. All rights reserved.
//

#import "WaveView.h"

#define kLineWidth 1.f
#define kSpace 1
 
@implementation WaveView
 
- (void)setPointArray:(NSArray *)pointArray
{
    _pointArray = pointArray;
    
    //调用该方法会重新加载drawRect方法
    [self setNeedsDisplay];
}
 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}
 
- (void)drawRect:(CGRect)rect
{
    if (self.pointArray.count == 0) {
        return;
    }
    //获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(ref, kLineWidth);
    //路径
    CGContextBeginPath(ref);
    //设置颜色
    CGContextSetStrokeColorWithColor(ref, [UIColor orangeColor].CGColor);
    
    NSInteger count = self.pointArray.count;
    NSArray *pointArray = self.pointArray;
    if (count * kLineWidth * kSpace > self.bounds.size.width) {
        NSInteger num = self.bounds.size.width / (kLineWidth * kSpace);
        pointArray = [self.pointArray subarrayWithRange:NSMakeRange(count - num, num)];
    }
    for (int i = 0; i < pointArray.count; i++) {
        CGPoint point = [[pointArray objectAtIndex:i] CGPointValue];
        //设置起点坐标
        CGContextMoveToPoint(ref, i * kLineWidth * kSpace, self.bounds.size.height/2 + point.y);
        //设置下一个点坐标
        CGContextAddLineToPoint(ref, i * kLineWidth * kSpace, self.bounds.size.height/2 - point.y);
    }
    //渲染，连接起点和下一个坐标点
    CGContextStrokePath(ref);
}
 
@end
