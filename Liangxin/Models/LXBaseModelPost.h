//
//  LXBaseModelPost.h
//  Liangxin
//
//  Created by xiebohui on 5/29/15.
//  Copyright (c) 2015 Hsu Spud. All rights reserved.
//

#import "MTLModel.h"

@interface LXBaseModelPost : MTLModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDictionary *author;
@property (nonatomic, copy) NSString *excerpt;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSArray *videos;
@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic, copy) NSString *attend_status;
@property (nonatomic, copy) NSString *event_date;
@property (nonatomic, copy) NSString *event_address;
@property (nonatomic, copy) NSString *event_type;
@property (nonatomic, copy) NSString *class_type;
@property (nonatomic, copy) NSString *banner_position;
@property (nonatomic, copy) NSString *has_due_date;
@property (nonatomic, copy) NSString *due_date;
@property (nonatomic, strong) NSArray *attendees;
@property (nonatomic, copy) NSString *comments_count;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSDictionary *group;
@property (nonatomic, strong) NSDictionary *poster;
@property (nonatomic, copy) NSString *liked;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, copy) NSString *group_id;
@property (nonatomic, copy) NSString *poster_id;
@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, copy) NSString *is_favorite;
@property (nonatomic, strong) NSArray *favored_users;
@property (nonatomic, copy) NSString *liked_users;
@property (nonatomic, copy) NSString *parent;
@property (nonatomic, copy) NSString *attended;

@end
