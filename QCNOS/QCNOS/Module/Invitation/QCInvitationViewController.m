//
//  QCInvitationViewController.m
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/18.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCInvitationViewController.h"
#import "QCInvitaitionListModel.h"
#import "QCInvitaitionFiltrateCell.h"
#import "QCInvitaitionBaseListCell.h"

@interface QCInvitationViewController ()
@property (nonatomic, strong) NSMutableArray<QCInvitaitionListModel *>* listArray;

@end

static NSString * const QCInvitaitionListCellId = @"QCInvitaitionListCellId";

@implementation QCInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    self.navigationItem.title = @"邀约";
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCInvitaitionBaseListCell class]) bundle:nil] forCellReuseIdentifier:QCInvitaitionListCellId];
}


#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.listArray.count;
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    QCInvitaitionBaseListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCInvitaitionListCellId forIndexPath:indexPath];
//    QCInvitaitionListModel* model = self.listArray[indexPath.row];
//    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return 111;
    
    return 260;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 懒加载
-(NSMutableArray<QCInvitaitionListModel *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
    }
    
    return _listArray;
    
}
@end
