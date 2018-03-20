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
@property(nonatomic,strong)UILabel *atLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *musicNameLabel;
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
    self.atLabel.text = [NSString stringWithFormat:@"@%@", musicModel.author.nickname];
    self.contentLabel.text = musicModel.desc;
    self.musicNameLabel.text = musicModel.music.title;
    [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:musicModel.music.cover_large.url_list.firstObject]];
}

-(void)play
{
    [self.playerView refreshPlay];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 3;
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = MAXFLOAT;
    [self.musicImageView.layer addAnimation:animation forKey:nil];
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
        [self musicNameLabel];
        [self contentLabel];
        [self atLabel];
    }
    return self;
}

#pragma mark - 📕delegate
#pragma mark - PlayerViewDelegate
-(void)playerView:(PlayerView *)playerView loadStatus:(PlayerLoadStatus)loadStatus
{
    
}

-(void)playerView:(PlayerView *)playerView currentTime:(NSTimeInterval)currentTime
{
    if (currentTime > 2) {
        self.bgImageView.hidden = YES;
        
    }
}

-(void)playerViewDidFinish:(PlayerView *)playerView
{
    [self play];
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
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _bgImageView;
}

-(UILabel *)musicNameLabel
{
    if (!_musicNameLabel) {
        _musicNameLabel = [UILabel new];
        _musicNameLabel.font = [UIFont systemFontOfSize:15];
        _musicNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_musicNameLabel];
        [_musicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self).offset(-60);
        }];
    }
    return _musicNameLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.preferredMaxLayoutWidth = 150;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self.musicNameLabel.mas_top).offset(-10);
            make.width.mas_equalTo(150);
        }];
    }
    return _contentLabel;
}

-(UILabel *)atLabel
{
    if (!_atLabel) {
        _atLabel = [UILabel new];
        _atLabel.font = [UIFont systemFontOfSize:15];
        _atLabel.textColor = [UIColor whiteColor];
        [self addSubview:_atLabel];
        [_atLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self.contentLabel.mas_top).offset(-10);
        }];
    }
    return _atLabel;
}

-(UIImageView *)musicImageView
{
    if (!_musicImageView) {
        _musicImageView = [UIImageView new];
        _musicImageView.layer.cornerRadius = 22.5;
        _musicImageView.layer.masksToBounds = YES;
        _musicImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _musicImageView.layer.borderWidth = 1;
        [self addSubview:_musicImageView];
        [_musicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.bottom.equalTo(self.musicNameLabel);
            make.width.height.mas_equalTo(45);
        }];
    }
    return _musicImageView;
}
@end
