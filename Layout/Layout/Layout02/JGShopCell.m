//
//  JGShopCell.m
//  瀑布流
//
//  Created by 郭军 on 16/8/13.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import "JGShopCell.h"
#import "JGShop.h"
#import "UIImageView+WebCache.h"

@interface JGShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation JGShopCell

- (void)setShop:(JGShop *)shop {
    _shop = shop;
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
