//
//  ViewController.m
//  SubsidyCashBackPerView
//
//  Created by Jn_Kindle on 16/10/10.
//  Copyright © 2016年 HuaDa. All rights reserved.
//

#import "ViewController.h"

#import "SubsidyCashBackPerView.h"

@interface ViewController ()<SubsidyCashBackPerViewManagerDelegate>

@property (nonatomic, strong) NSArray *tempArray;

@end

@implementation ViewController

-(NSArray *)tempArray
{
    if (!_tempArray) {
        _tempArray = @[
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%",
                       @"黄金珠宝 | 返现 5%"];
    }
    return _tempArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[SubsidyCashBackPerViewManager sharedInstance] showSubsidyCashBackPerViewWithSubsidyCashBackPerDataArray:self.tempArray];
    [SubsidyCashBackPerViewManager sharedInstance].delegate = self;
}

-(void)didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%@",self.tempArray[index]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
@end
