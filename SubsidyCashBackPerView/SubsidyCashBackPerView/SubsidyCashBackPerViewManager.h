//
//  SubsidyCashBackPerViewManager.h
//  SubsidyCashBackPerView
//
//  Created by Jn_Kindle on 16/10/10.
//  Copyright © 2016年 HuaDa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SubsidyCashBackPerViewManagerDelegate <NSObject>

@optional

- (void)didSelectItemAtIndex:(NSInteger)index;


@end

@interface SubsidyCashBackPerViewManager : NSObject

@property (nonatomic, strong)id<SubsidyCashBackPerViewManagerDelegate>delegate;

/**
 *  创建单例模式
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  商品及返现比例view
 *
 *  @param subsidyCashBackPerDataArray subsidyCashBackPerDataArray description
 */
- (void)showSubsidyCashBackPerViewWithSubsidyCashBackPerDataArray:(NSArray *)subsidyCashBackPerDataArray;


/**
 *  隐藏商品及返现比例view
 */
- (void)hideSubsidyCashBackPerView;

@end
