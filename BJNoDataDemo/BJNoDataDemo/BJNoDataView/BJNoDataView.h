//
//  BJNoDataView.h
//  BJNoDataDemo
//
//  Created by zbj-mac on 16/3/25.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^iconClicked) ();
@interface BJNoDataView : UIView

+(BJNoDataView*)shareNoDataView;

/**
 *  展示在父视图的中心
 *
 *  @param aview 父视图
 *  @param icon  图片（默认no_data）
 */
-(void)showCenterWithSuperView:(UIView*)aview icon:(NSString*)icon;

/**
 *  展示
 *
 *  @param aview 父视图
 *  @param frame 在父视图中的frame
 *  @param icon  图片（默认no_data）
 */
-(void)showWithSuper:(UIView*)aview Frame:(CGRect)frame icon:(NSString*)icon;

/**
 *  展示在父视图的中心
 *
 *  @param aview       父视图
 *  @param icon        图片（默认no_data）
 *  @param iconClicked 图片点击回调
 */
-(void)showCenterWithSuperView:(UIView*)aview icon:(NSString*)icon iconClicked:(iconClicked)iconClicked;

/**
 *  展示
 *
 *  @param aview       父视图
 *  @param frame       在父视图中的frame
 *  @param icon        图片（默认no_data）
 *  @param iconClicked 图片点击回调
 */
-(void)showWithSuper:(UIView*)aview Frame:(CGRect)frame icon:(NSString*)icon iconClicked:(iconClicked)iconClicked;

/**
 *  清除视图
 */
-(void)clear;
@end
