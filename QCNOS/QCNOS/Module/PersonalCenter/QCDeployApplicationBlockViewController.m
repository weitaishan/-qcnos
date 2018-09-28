//
//  QCDeployApplicationBlockViewController.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCDeployApplicationBlockViewController.h"
#import "QCPersonSelectNodeView.h"
#import "QCPersonSelectNodeListCell.h"
#import "QCGetBlockType.h"

@interface QCDeployApplicationBlockViewController ()

@property (nonatomic, strong) NSMutableArray<QCGetBlockTypeChildList *>* listArr;

@property (nonatomic,strong) NSMutableArray<NSNumber *> *flagArray;


@end

static NSString * const QCPersonSelectNodeListCellId = @"QCPersonSelectNodeListCellId";

@implementation QCDeployApplicationBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseInfo];
    
    //根据type获取不同接口
    if (self.type == 0) {
        [self getBlockTypeListRequest];
    }
    else {
        [self getNodeTypeListRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBlockTypeListRequest {
    
    NSURLRequest *request = [NSURLRequest getBlockTypeListWithParameters:nil];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        
        QCGetBlockType* model = [QCGetBlockType yy_modelWithJSON:responseObject];
        [self.listArr removeAllObjects];
        [self.listArr addObjectsFromArray:model.data];
        if (self.flagArray.count != self.listArr.count) {
            [self.listArr enumerateObjectsUsingBlock:^(QCGetBlockTypeChildList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.flagArray addObject:@1];
            }];
        }
        
        [self.tableView reloadData];
        
        
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

- (void)getNodeTypeListRequest {
    
    NSURLRequest *request = [NSURLRequest getNodeTypeListWithParameters:nil];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        QCGetBlockType* model = [QCGetBlockType yy_modelWithJSON:responseObject];
        [self.listArr removeAllObjects];
        [self.listArr addObjectsFromArray:model.data];
        if (self.flagArray.count != self.listArr.count) {
            [self.listArr enumerateObjectsUsingBlock:^(QCGetBlockTypeChildList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.flagArray addObject:@1];
            }];
        }
        
        [self.tableView reloadData];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}


- (void)setBaseInfo{
    
    
    if (self.type) {
        
        self.navigationItem.title = @"部署应用节点";

    }else{
        
        self.navigationItem.title = @"配置应用区块";

    }
    
    [self addTableViewWithGroupFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonSelectNodeListCell class]) bundle:nil] forCellReuseIdentifier:QCPersonSelectNodeListCellId];
    
}


#pragma mark - 数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([self.flagArray[section] isEqualToNumber:@0]){
        
        return 0;
        
    }
    
    return self.listArr[section].childList.count;
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    QCPersonSelectNodeListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonSelectNodeListCellId forIndexPath:indexPath];
    
    
    return cell;
    
}


#pragma mark - 代理方法

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    return self.tableView.rowHeight;
    
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 78;
    
    
}

//底部视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 16)];
    
    view.backgroundColor =  kBgColor;
    
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 60)];
    
    QCPersonSelectNodeView* nodeView = [[NSBundle mainBundle] loadNibNamed:@"QCPersonSelectNodeView" owner:self options:nil].firstObject;
    
    [view addSubview:nodeView];
    [nodeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(view);
    }];
    
    BOOL status = [self.flagArray[section] boolValue];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        NSNumber *num = status ? @0 : @1;
        [self.flagArray replaceObjectAtIndex:section withObject:num];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

    
    return view;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return UITableViewCellEditingStyleDelete & UITableViewCellEditingStyleInsert;
    
}
#pragma mark - 懒加载
-(NSMutableArray<QCGetBlockTypeChildList *> *)listArr{
    
    if (!_listArr) {
        
        _listArr = @[].mutableCopy;
    }
    
    return _listArr;
}


-(NSMutableArray *)flagArray{
    
    if (!_flagArray) {
        
        _flagArray = @[].mutableCopy;
    }
    
    return _flagArray;
}


@end
