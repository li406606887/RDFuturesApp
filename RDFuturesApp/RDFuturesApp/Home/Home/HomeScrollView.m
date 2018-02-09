//
//  HomeScrollView.m
//  RDFuturesApp
//
//  Created by user on 17/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeScrollView.h"
#import "HomeScrollModel.h"
#import "HomeViewModel.h"
#import "RDCommon.h"
#import "ScrollCollectionViewCell.h"


#define kCount self.imageArray.count


@interface HomeScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
/***/
@property (nonatomic, strong) HomeViewModel *homeViewModel;
/***/
@property (nonatomic, strong) UIPageControl *pageControl;
/**计时器*/
@property (nonatomic, strong) NSMutableArray *imageArray;
/**计时器*/
@property (nonatomic, strong) NSTimer *timer;
/**当前滚动的位置*/
@property (nonatomic, assign) NSInteger currentIndex;
/**上次滚动的位置*/
@property (nonatomic, assign) NSInteger lastIndex;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end
@implementation HomeScrollView



-(void)setupViews{
    self.currentIndex = 1;
    [self setBackgroundColor:[UIColor greenColor]];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];

    _pageControl.numberOfPages = self.imageArray.count;

}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    
    self.homeViewModel = (HomeViewModel*)viewModel;
    return [super initWithViewModel:(HomeViewModel *)viewModel];
    
}
# pragma mark 跟新约束
-(void)updateConstraints{
    WS(weakself)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 20));
    }];
    [super updateConstraints];
}
# pragma mark collectionView代理事件
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ScrollCollectionViewCell class])] forIndexPath:indexPath];
    HomeScrollModel *model = self.imageArray[indexPath.row];

    cell.image_url = model.image;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.row;
    HomeScrollModel *model = self.imageArray[index];
    [self.homeViewModel.imageclickSubject sendNext:model];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size;
}
# pragma mark scrollView代理事件
- (void)removeNSTimer
{
    [self.timer invalidate];
    self.timer =nil;
}
- (void)addNSTimer
{
    if (self.timer == nil) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
}
- (void)nextPage
{

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self scrollToIndexPath:indexPath animated:YES];

}
- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    if (self.imageArray.count > indexPath.row)
    {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeNSTimer];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.dragging == YES) {

    }else{
        self.userInteractionEnabled = YES;
    }
    if (velocity.x!=0) {
        self.userInteractionEnabled = NO;
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.dragging==YES){
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.dragging==NO){
        [self addNSTimer];
        self.userInteractionEnabled = YES;

    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.frame.size.width;
    self.currentIndex = scrollView.contentOffset.x/width+1;
    
    //当滚动到最后一张图片时，继续滚向后动跳到第一张
    if (scrollView.contentOffset.x == (kCount-1)*width)
    {
        self.currentIndex = 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    
    //当滚动到第一张图片时，继续向前滚动跳到最后一张
    if (scrollView.contentOffset.x == 0)
    {
        self.currentIndex = kCount-2;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    self.pageControl.currentPage = self.currentIndex-2;

}

# pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout = layout;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ScrollCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ScrollCollectionViewCell class])]];
    }
    return _collectionView;
}

-(void)refreshData{
    NSArray *array = self.homeViewModel.dataArray;
    if (array.count<1) {
        return;
    }
    self.pageControl.numberOfPages = array.count;
    if (self.imageArray.count>0) {
        [self.imageArray removeAllObjects];
    }
    for (NSInteger i =0; i<array.count+2; i++) {
        if (i==0) {
            [self.imageArray addObject:array[array.count-1]];
        }else if (i==array.count+1){
            [self.imageArray addObject:array[0]];
        }else{
            [self.imageArray addObject:array[i-1]];
        }
    }
    [self removeNSTimer];
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self scrollToIndexPath:indexPath animated:YES];
    [self addNSTimer];

}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.userInteractionEnabled = NO;//小圆点
    }
    return _pageControl;
}
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}
@end
