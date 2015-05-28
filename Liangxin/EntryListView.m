//
//  FilterView.m
//  Liangxin
//
//  Created by Hsu Spud on 15/5/24.
//  Copyright (c) 2015年 Hsu Spud. All rights reserved.
//

#import "EntryListView.h"
#import "EntryItemCell.h"


@interface EntryListView()

@end

@implementation EntryListView
@synthesize data=_data, view=_view;
@synthesize rows=_rows, columns=_columns;
@synthesize delegate=_delegate, type;


-(instancetype) initWithFrame:(CGRect)frame andData:(NSArray *)data rows:(int)rows columns:(int)columns{
    self.view = [[UIView alloc] initWithFrame:frame];
    self.data = data;
    self.rows = rows;
    self.columns = columns;
    self.type = EntryListViewTypeFilter;
    return self;
}

-(void) render{
    for(int i = 0 ; i < [self.data count]; i++){
        [self.view addSubview:[self cellForIndex:i]];
    }
}


- (UIView *)cellForIndex:(int)index{
    CGFloat itemWidth = CGRectGetWidth(self.view.frame) / self.columns;
    CGFloat itemHeight = CGRectGetHeight(self.view.frame) / self.rows;
    
    int r = index / self.columns;
    int c = index - r * self.rows;
    
    
    CGRect frame = CGRectMake(itemWidth * c, itemHeight * r, itemWidth, itemHeight);
    
    EntryItemCell* cell;
    
    if(type == EntryListViewTypeCategory){
        cell = [[CategoryCell alloc] initWithFrame:frame];
    }else{
        cell = [[FilterCell alloc] initWithFrame:frame];
    }
        
    NSDictionary* item = [self.data objectAtIndex:index];
    
    cell.backgroundColor = [self.delegate colorForFilterView:self andIndex:index];
    cell.title.text = item[@"title"];
    
    
    // 区别对待 new
    NSString* imageName = item[@"icon"];
    
    if([imageName isEqualToString:@"最新"]){
        cell.icon.frame = CGRectMake((itemWidth - 30) / 2, 15, 30, 9);
    }
    
    cell.icon.image = [UIImage imageNamed:imageName];
    
    
    return cell;
}

@end
