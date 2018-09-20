//
//  QCInvitationDetailsViewController.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/20.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCInvitationDetailsViewController.h"
#import "QCInvitaitionBaseListCell.h"
#import "QCInvitaitionDetailsCell.h"
#import "QCInvitaitionListModel.h"
@interface QCInvitationDetailsViewController ()

@property (nonatomic, strong) NSMutableArray<QCInvitaitionListModel *>* listArray;

@end

static NSString * const QCInvitaitionListCellId = @"QCInvitaitionListCellId";
static NSString * const QCInvitaitionDetailsCellId = @"QCInvitaitionDetailsCellId";


@implementation QCInvitationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight - TabbarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCInvitaitionBaseListCell class]) bundle:nil] forCellReuseIdentifier:QCInvitaitionListCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCInvitaitionDetailsCell class]) bundle:nil] forCellReuseIdentifier:QCInvitaitionDetailsCellId];
    
}


#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        QCInvitaitionBaseListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCInvitaitionListCellId forIndexPath:indexPath];
        
        return cell;
        
        
    }
    
    QCInvitaitionDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:QCInvitaitionDetailsCellId forIndexPath:indexPath];
    //    QCInvitaitionListModel* model = self.listArray[indexPath.row];
    //    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        return 208;
        
    }
    
    return 140;
    
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
