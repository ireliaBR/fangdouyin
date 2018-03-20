//
//  MusicCell.m
//  仿抖音
//
//  Created by ireliad on 2018/3/15.
//  Copyright © 2018年 正辰科技. All rights reserved.
//

#import "MusicCell.h"
#import "MusicModel.h"
#import "PlayerView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MusicCell()<PlayerViewDelegate>
@property(nonatomic,strong)PlayerView *playerView;
@property(nonatomic,strong)UIImageView *bgImageView;
@end

@implementation MusicCell
#pragma mark - 📓public method
-(void)setModel:(CardModel *)model
{
    [super setModel:model];
    self.bgImageView.hidden = NO;
    MusicModel *musicModel = (MusicModel*)model;
    self.playerView.url = musicModel.video.play_addr.url_list.firstObject;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:musicModel.video.cover.url_list.firstObject]];
}

-(void)play
{
    [self.playerView refreshPlay];
}

-(void)pause
{
    [self.playerView pause];
}

#pragma mark - 📒life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self playerView];
        [self bgImageView];
    }
    return self;
}

#pragma mark - 📕delegate
#pragma mark - PlayerViewDelegate
//-(void)playerView:(PlayerView *)playerView loadStatus:(PlayerLoadStatus)loadStatus
//{
//    if (loadStatus == PlayerLoadStatusAlready) {
//        self.bgImageView.hidden = YES;
//    }
//}

-(void)playerView:(PlayerView *)playerView currentTime:(NSTimeInterval)currentTime
{
    if (currentTime > 2) {
        self.bgImageView.hidden = YES;
    }
}

#pragma mark - 📗event response

#pragma mark - 📘private method

#pragma mark - 📙getter and setter
-(PlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [[PlayerView alloc] init];
        [self addSubview:_playerView];
        [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _playerView.delegate = self;
    }
    return _playerView;
}

-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _bgImageView;
}
@end
