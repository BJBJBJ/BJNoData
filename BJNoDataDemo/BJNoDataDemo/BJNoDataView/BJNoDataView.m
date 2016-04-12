//
//  BJNoDataView.m
//  BJNoDataDemo
//
//  Created by zbj-mac on 16/3/25.
//  Copyright © 2016年 zbj. All rights reserved.
//
#define kAnimateDuration 0.25f
#import "BJNoDataView.h"
@interface BJNoDataView()
@property(nonatomic,strong)UIImageView*iconView;
@property(nonatomic,copy)iconClicked iconClicked;
@end
@implementation BJNoDataView
//图片点击动画
+(void)animationPopupWith:(UIView*)aview duration:(CGFloat)duration{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration ? duration : 0.5f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aview.layer addAnimation:animation forKey:nil];
    
}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView=[[UIImageView alloc] init];
        _iconView.contentMode=UIViewContentModeScaleAspectFit;
        _iconView.userInteractionEnabled=YES;
        [_iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked)]];
        _iconView.frame=CGRectMake(0, 0, 100, 100);
    }
    return _iconView;
}

+(BJNoDataView*)shareNoDataView{
    static BJNoDataView* instance;
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[BJNoDataView alloc] init];
        });
    }
    return instance;
}
+(instancetype)noDataView{
    return [[self alloc] init];
}
-(instancetype)init{
    if (self=[super init]) {
        [self addSubview:self.iconView];
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    //设置iconView的位置
 
    self.iconView.center=self.center;
}
#pragma mark----Method----
-(void)showSuper:(UIView*)aview icon:(NSString*)icon{
    if (!aview){
        // 抛出异常
        NSException *excp = [NSException exceptionWithName:@"BJNoDataViewException" reason:@"未设置父视图。" userInfo:nil];
        [excp raise];
        return;
    };
    icon=icon? icon:@"no_data";
    self.backgroundColor=aview.backgroundColor;
    [aview insertSubview:self atIndex:0];//插在父视图中的最底层(看情况设置)
    self.iconView.image=[UIImage imageNamed:icon];
}
-(void)showCenterWithSuperView:(UIView*)aview icon:(NSString*)icon{
    [self showSuper:aview icon:icon];
    self.frame=aview.bounds;
}
-(void)showWithSuper:(UIView*)aview Frame:(CGRect)frame icon:(NSString*)icon{
   [self showSuper:aview icon:icon];
   self.frame=frame;
}
-(void)showCenterWithSuperView:(UIView *)aview icon:(NSString *)icon iconClicked:(iconClicked)iconClicked{
    [self showCenterWithSuperView:aview icon:icon];
    self.iconClicked=iconClicked;
}
-(void)showWithSuper:(UIView *)aview Frame:(CGRect)frame icon:(NSString *)icon iconClicked:(iconClicked)iconClicked{
    [self showWithSuper:aview Frame:frame icon:icon];
    self.iconClicked=iconClicked;
}
-(void)imageViewClicked{
    if (!self.iconClicked) return;
    [BJNoDataView animationPopupWith:self.iconView duration:kAnimateDuration];
    self.iconClicked();
}
-(void)clear{
   !self ?:[self removeFromSuperview];
}

-(void)wipeOut{
    for (UIView*bview in self.superview.subviews) {
        if ([bview isKindOfClass:[BJNoDataView class]]) {
            [bview removeFromSuperview];
        }
    }
}
@end