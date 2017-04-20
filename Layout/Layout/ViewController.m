//
//  ViewController.m
//  Layout
//
//  Created by xiangronghua on 2017/4/20.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ViewController.h"
#import "LayoutViewController-01.h"
#import "LayoutViewController-02.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString *tableViewCellID = @"tableViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.dataSource = self;
    _tableView.delegate   = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"放大类型的瀑布流";
        cell.textLabel.backgroundColor = [UIColor cyanColor];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"普通类型的瀑布流";
        cell.textLabel.backgroundColor = [UIColor grayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LayoutViewController_01 *layout1 = [[LayoutViewController_01 alloc] init];
        [self.navigationController pushViewController:layout1 animated:YES];
    }
    if (indexPath.row == 1) {
        LayoutViewController_02 *layout2 = [[LayoutViewController_02 alloc] init];
        [self.navigationController pushViewController:layout2 animated:YES];
    }
}

@end
