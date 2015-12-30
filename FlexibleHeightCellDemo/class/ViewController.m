//
//  ViewController.m
//  FlexibleHeightCellDemo
//
//  Created by 周际航 on 15/12/29.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "ViewController.h"
#import "LifeModel.h"
#import "FlexibleHeightCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, weak) UITableView *tableView;
// 算cell高度的标准cell
@property (nonatomic, strong) FlexibleHeightCell *standardCell;

// 数据源
@property (nonatomic, strong) NSArray *liftModelArr;
// cell高度缓存
@property (nonatomic, strong) NSMutableArray *cellHeightMArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    [self setUpData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self layoutPosition];
}
// 创建视图控件
- (void)setUpViews{
    self.navigationItem.title = @"猴王的说说";
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [tableView registerNib:[UINib nibWithNibName:@"FlexibleHeightCell" bundle:nil] forCellReuseIdentifier:[FlexibleHeightCell identify]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
// 布局视图控件的位置
- (void)layoutPosition{
    
    self.tableView.frame = self.view.bounds;
}
// 初始化数据
- (void)setUpData{
    self.liftModelArr = [LifeModel fakeLifeModelArr];
    self.cellHeightMArr = [@[] mutableCopy];
    for (int i=0; i<self.liftModelArr.count; i++){
        [self.cellHeightMArr addObject:@(0)];
    }
    [self.tableView reloadData];
}

#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.liftModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlexibleHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:[FlexibleHeightCell identify]];
    
    if (indexPath.row < self.liftModelArr.count) {
        cell.lifeModel = self.liftModelArr[indexPath.row];
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.liftModelArr.count) return 0;
    
    CGFloat cellHeight = 0;
    // 使用缓存的高度或者重新算高度
    if (indexPath.row<self.cellHeightMArr.count && [self.cellHeightMArr[indexPath.row] floatValue]!=0) {
        cellHeight = [self.cellHeightMArr[indexPath.row] floatValue];
    }else{
        LifeModel *lifeModel = self.liftModelArr[indexPath.row];
        self.standardCell.lifeModel = lifeModel;
        cellHeight = [self.standardCell cellHeight];
        if (indexPath.row < self.cellHeightMArr.count) {
            self.cellHeightMArr[indexPath.row] = @(cellHeight);
        }
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row < self.liftModelArr.count) {
        // 如果cell点击事件会修改cell高度，这里需要在select方法中调用此句避免约束冲突，如果cell高度不变，可以忽略if语句块
        FlexibleHeightCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        LifeModel *lifeModel = self.liftModelArr[indexPath.row];
        cell.lifeModel = lifeModel;
    }
    
    NSLog(@"tap:%@",indexPath);
}

- (FlexibleHeightCell *)standardCell{
    if (!_standardCell) {
        _standardCell = [[[NSBundle mainBundle] loadNibNamed:@"FlexibleHeightCell" owner:nil options:nil] firstObject];
    }
    return _standardCell;
}


@end
