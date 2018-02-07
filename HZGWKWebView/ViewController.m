//
//  ViewController.m
//  HZGWKWebView
//
//  Created by Jack on 2018/2/6.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewController.h"
#import "WKWebViewBridgeViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titleArray;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    _titleArray = @[@"WKWebView",@"WKWebViewBridge"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self pushToWKWebViewAction];
            break;
        case 1:
            [self pushToWKWebViewBridgeAction];
            break;
        default:
            break;
    }
}

-(void)pushToWKWebViewAction{
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)pushToWKWebViewBridgeAction{
    WKWebViewBridgeViewController *webVC = [[WKWebViewBridgeViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
