//
//  ViewController.m
//  BJNoDataDemo
//
//  Created by zbj-mac on 16/3/25.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "ViewController.h"
#import "BJNoDataView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;

@end

@implementation ViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.frame=self.view.bounds;
        _tableView.rowHeight=50;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.tableFooterView=[[UIView alloc] init];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
    self.dataArray=[NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----KVO----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArray"]) {
        return;
    }
    if ([self.dataArray count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tableView icon:nil iconClicked:^{
        //图片点击回调
        [self loadData];//刷新数据
        }];
        return;
    }
    //有数据
    [[BJNoDataView shareNoDataView] clear];
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"dataArray"];
}
#pragma mark-----UITableViewDataSource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*ID=@"CellId";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text=self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self loadData];
}
-(void)loadData{
    int count=arc4random() %3;

   NSMutableArray*mut=[[NSMutableArray alloc] init];
    for (int i=0; i<count; i++) {
        
    [mut addObject:[NSString stringWithFormat:@"第%d条数据",i]];
//  [self.dataArray addObject:[NSString stringWithFormat:@"第%d条数据",i]];//不会触发KVO
    }
    self.dataArray=mut;//数组指针改变 触发KVO
    NSLog(@"共%ld条数据",[self.dataArray count]);
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}


@end
