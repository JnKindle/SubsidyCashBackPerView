//
//  SubsidyCashBackPerCell.m
//  SubsidyCashBackPerView
//
//  Created by Jn_Kindle on 16/10/10.
//  Copyright © 2016年 HuaDa. All rights reserved.
//

#import "SubsidyCashBackPerCell.h"
#import "SubsidyCashBackPerView.h"

@interface SubsidyCashBackPerCell ()

@end

@implementation SubsidyCashBackPerCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  kScreenViewBounds.size.width/2-20, 30)];
    
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.titleLabel.layer.cornerRadius = 5;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    
    
    
    [self.contentView addSubview:self.titleLabel];
    
    
    
}

@end
