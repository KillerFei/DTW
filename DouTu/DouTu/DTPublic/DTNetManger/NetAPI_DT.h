//
//  NetAPI_DT.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#ifndef NetAPI_DT_h
#define NetAPI_DT_h

#define kDTBaseHostUrl                  @"http://api.jiefu.tv"


//主页面广场热门接口
//http://api.jiefu.tv/app2/api/dt/tag/hotList.html
#define kDTHotListUrl                   @"app2/api/dt/tag/hotList.html"
//主页面广场最新接口
//http://api.jiefu.tv/app2/api/dt/shareItem/newList.html?pageNum=0&pageSize=48
#define kDTNewListUrl                   @"app2/api/dt/shareItem/newList.html"
//主页面广场分类接口
//http://api.jiefu.tv/app2/api/dt/shareItem/getByTag.html?tagId=5&pageNum=0&pageSize=48
#define kDTGetByTagUrl                  @"app2/api/dt/shareItem/getByTag.html"
//主页面制作接口
//http://api.jiefu.tv/app2/api/dt/item/recommendList.html?pageNum=0&pageSize=48
#define kDTRecommendListUrl             @"app2/api/dt/item/recommendList.html"

//制作编辑接口
//http://api.jiefu.tv/app2/api/dt/item/getDetail.html?itemId=7141
#define kDTGetDetailUrl                 @"app2/api/dt/item/getDetail.html"

//分类总接口
//http://api.jiefu.tv/app2/api/dt/tag/allList.html
#define kDTAllListUrl                   @"app2/api/dt/tag/allList.html"

#endif /* NetAPI_DT_h */
