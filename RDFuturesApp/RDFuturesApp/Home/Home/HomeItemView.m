//
//  HomeItemView.m
//  RDFuturesApp
//
//  Created by user on 17/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeItemView.h"
#import "HomeViewModel.h"
#import "HomeItemCollectionCell.h"

@interface HomeItemView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomeViewModel *homeViewModel;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) int oldAnnouncementState;
@end

@implementation HomeItemView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.homeViewModel = (HomeViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
    [self addSubview:self.collectionView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)bindViewModel{
    [self.homeViewModel.refreshAnnouncementStateSubject subscribeNext:^(id  _Nullable x) {
        if (self.oldAnnouncementState!=[x intValue]) {
           self.imageArray[6] = [x intValue]==1 ?@"item_publicnotice_selected":@"item_publicnotice";
            [self.collectionView reloadData];
        }
        self.oldAnnouncementState = [x intValue];
    }];
}
-(void)updateConstraints{
    WS(weakself)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}
# pragma mark collection代理事件
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeItemCollectionCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeItemCollectionCell class])] forIndexPath:indexPath];
    
    cell.icon = self.imageArray[indexPath.row];
    cell.title = self.titleArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self.homeViewModel.itemclickSubject sendNext:index];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH*0.333, 98);
//    return CGSizeMake((SCREEN_WIDTH-30)/3-0.5, SCREEN_WIDTH*0.33333);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.10f;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",self.collectionView.frame.size.height);
}
# pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor]; //DEFAULT_BG_COLOR
        [_collectionView registerClass:[HomeItemCollectionCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeItemCollectionCell class])]];
    }
    return _collectionView;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] initWithObjects:@"item_brand",@"item_service",@"item_connection",@"item_business",@"item_box",@"item_bills",@"item_publicnotice",@"item_help",@"item_feedback", nil];
        
    }
    return _imageArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"瑞达品牌",@"我的客服",@"联系我们",@"业务办理",@"百宝箱",@"账单查询",@"公司公告",@"帮助信息",@"信息反馈 ", nil];
        
    }
    return _titleArray;
}
-(int)oldAnnouncementState{
    if (!_oldAnnouncementState) {
        _oldAnnouncementState = 2;
    }
    return _oldAnnouncementState;
}
@end
