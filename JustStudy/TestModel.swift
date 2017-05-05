//
//  TestModel.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import Foundation

let testdata = testData()
var expertsdata = expertsData()
var licenseData = LicenseData()

struct testData
{
    let posts = [
        ["topic":"2017 Future Commerce未來商務展",
         "time":"2017-04-27",
         "place":"台北市中山區玉門街1號",
         "image":"cat1"],
        ["topic":"策略獲利模式",
         "time":"2017-04-27",
         "place":"台北市萬華區",
         "image":"cat2"],
        ["topic":"巨人肩膀計畫",
         "time":"2017-04-02",
         "place":"台北市中正區齊東街74號",
         "image":"cat3"],
        ["topic":"你不可不知的關鍵字精準投放術",
         "time":"2017-04-03",
         "place":"台北市林森北路107巷10號",
         "image":"cat4"],
        ["topic":"搜尋引擎開發導入",
         "time":"2017-04-04",
         "place":"台北市中山區明水路569號B2",
         "image":"cat5"],
        ["topic":"網站績效分析與管理",
         "time":"2017-04-05",
         "place":"台中市",
         "image":"cat6"],
        ["topic":"搜尋引擎最佳化",
         "time":"2017-04-06",
         "place":"新北市",
         "image":"cat7"],
        ["topic":"網站分析基礎知識",
         "time":"2017-04-07",
         "place":"高雄市",
         "image":"cat8"],
        ["topic":"愛奇藝開課了",
         "time":"2017-04-08",
         "place":"新竹市",
         "image":"cat9"],
        ["topic":"台灣戲劇因為你",
         "time":"2017-04-09",
         "place":"桃園市",
         "image":"cat10"],
        
    ]
    
}

struct expertsData
{
    var posts = [
        ["image":"expert0",
         "name":"Sean",
         "topic":"為什麼要去國外取證照?",
         "video":"vE4xVSq0v2M",
         "likeCount":"26"],
        ["image":"expert1",
         "name":"Ann",
         "topic":"在學店充斥的技職餐飲校系環境，該如何脫穎而出？",
         "video":"9Gjyo0tqNm4",
         "likeCount":"52"],
        ["image":"expert2",
         "name":"Go Education",
         "topic":"密集英語課程的一天!",
         "video":"xkrcM20VrBY",
         "likeCount":"31"],
        ["image":"expert3",
         "name":"Eger",
         "topic":"密集英語學習：學員見證分享",
         "video":"vWH8AM9oih0",
         "likeCount":"9"],
        ["image":"expert4",
         "name":"David",
         "topic":"如何在菲律賓準備空服員多益成績和面試關卡",
         "video":"k1Zd1Gsa3rA",
         "likeCount":"18"]
    ]
}




struct LicenseData
{
    var posts =
    [
        [
            ["id":"1",
             "subject":"托福英文考試課程",
             "address":"555 Richards Street Vancouver, B.C. Canada, V6B 2Z5",
             "type":"托福",
             "course_detail":"早上的課程第一堂進行是聽力、閱讀、寫作、口說的練習，下午則由學生自行選修其他課程，來搭配自己能力的提升，比如下午可以選擇閱讀寫作、聽力練習，也有學生覺得口條需要再加強，而選擇辯論或是社會問題探討等高階的口說課程來輔助，每個禮拜學校會給與學生一次電腦上機模擬考試，經由多次的模擬考過程中，一方面熟悉題型與答題技巧，二方面增加自己的英文能力深度，進而增加自己的自信心",
             "school_detail":"ILSC的托福課程，目標在把學生的托福iBT成績提升到能進入當地大學的入學水平，並順利進入當地大專院校就讀。由於ILSC的多倫多與溫哥華校區本身是托福官方授權的考試中心，學生可以在學校考照，占有熟悉環境的優勢。",
             "school_name":"ILSC",
             "image":"ILSC_Van",
             "lat":49.283776,
             "log":-123.113901],
            ["id":"2",
             "subject":"商用英文與企業實習",
             "address":"800 Market St, San Francisco, CA 94102",
             "type":"商用企業實習",
             "course_detail":"每星期不同主題商務課程可參加4-12週 20堂標準英文+8堂商務課程定期安排當地企業參觀: Sincerely (app development), BMW, Wells, Fargo 等等客座企業人士講堂，可在課程後加上企業實習, 體驗美國公司工作環境及文化",
             "school_detail":"Embassy 語言中心舊金山校區這裏以餐廳、商店、電影院和地方娛樂表演聞名。從 學校到旅館和學生公寓走路就會到，且靠近所有的大眾運輸工具。我們舊金山校區最多可容納180位學生。 有12間設備完善的教室",
             "school_name":"Embassy",
             "image":"Embassy",
             "lat":37.795442,
             "log":-122.402768]
        ],
        [
            ["id":"1",
             "subject":"時尚彩妝課程",
             "address":"100 - 555 W 12TH AVENUE, VANCOUVER, BC",
             "type":"彩妝",
             "course_detail":"學院所有的師資是由世界各地最知名度的專業人士所組成，例如Todd Mclntosh是世界十大知名化妝師之一，活躍於好萊塢電影界。他們教授學員基本的學科知識、相關理論以及最新的實際操作技巧。",
             "school_detail":"從1960年成立的Blanche Macdonald Centre是加拿大規模最大的流行專業學院。 學校提供專業培訓課程，包括: 時尚行銷採購文憑課程，時尚設計文憑課程，專業彩妝師文憑課程",
             "school_name":"Blanche Macdonald Centre",
             "image":"Blanche",
             "lat":49.283776,
             "log":-123.113901],
            ["id":"2",
             "subject":"時尚設計課程",
             "address":"14 Round Church Street Cambridge CB5 8AD",
             "type":"設計",
             "course_detail":"劍橋視覺及表演藝術學校Cambridge School Of Visual & Performing ARTS (CSVPA) 除了在課程上提供眾多的藝術課程及一流的教學團隊之外，也提供了劍橋視覺及表演藝術學校Cambridge School Of Visual & Performing ARTS (CSVPA) 的學生最完善的學習環境",
             "school_detail":"劍橋視覺及表演藝術學校Cambridge School Of Visual & Performing ARTS (CSVPA) 所提供的大學預修課程，以獨特學習的創造性，讓對藝術及設計有興趣的學子們，充分發揮其自己的潛力及天份",
             "school_name":"CVSPA",
             "image":"CVSPA",
             "lat":52.208923,
             "log":0.118872],
        ],
        [
            ["id":"1",
             "subject":"廚藝證書課程",
             "address":"Roob-1 28-13 Sarugaku-Cho Shibuya-ku , Tokyo , 150-0033 Japan",
             "type":"廚藝",
             "course_detail":"在現代美食藝術與酒店管理體系快速發展、技術不斷革新的時代，藍帶所堅持的”卓越傳統”自學院創立以來絲毫沒有改變，目前藍帶在全世界20多個國家設立50多所分校，毎年有高達兩萬人的畢業生，藍帶的卓越",
             "school_detail":"藍帶選擇日本開設分校的優勢是考量日本是亞洲西餐與西點文化的領軍者，這裡聚集眾多的米其林星級餐廳、高級甜品店與烘焙坊，相對的日本餐飲競爭度也強，可以給學生比較正面的刺激。",
             "school_name":"Le Cordon Bleu",
             "image":"BHMS",
             "lat":35.710294,
             "log":139.810726],
            ["id":"2",
             "subject":"廚藝帶薪實習課程",
             "address":"Baselstrasse 57 CH-6003 Luzern Switzerland",
             "type":"廚藝實習",
             "course_detail":"全職帶薪實習是BHMS瑞士工商飯店管理學院學習的重要組成部分，學生有機會獲得在所學領域的帶薪實習工作，對於學生畢業後申請管理崗位具有非常重要的作用。根據學生的才能及經驗，學生將會完成所實習崗位的工作。",
             "school_detail":"BHMS瑞士工商飯店管理學院（BHMS International AG, Business & Hotel Management School）坐落於瑞士著名的旅遊勝地盧塞恩市(Luzern)，隸屬於瑞士歷史悠久的Benedict教育集團",
             "school_name":"George Brown College",
             "image":"George",
             "lat":47.053638,
             "log":8.294087],
        ]
    ]
}




//35.710294, 139.810726    :晴空塔
//49.283776, -123.113901   :溫哥華
//10.373932, 123.918832    :菲律賓
//37.820157, -122.478212   :金門大橋
//37.795442, -122.402768   :泛美金字塔
//47.053902, 8.294148      :瑞士
//43.675969, -79.410746    :多倫多

/*
 ["id":"2",
 "subject":"12周多益進步200分課程",
 "address":"6000 Talamban, Cebu City, Philippines Across Maryville Subdivision Tigbao",
 "type":"多益",
 "course_detail":"針對聽、說、讀、寫各方面專精的老師個別輔導學生，同時也有定期的考試時時檢定學習的成效，幫助學生順利達成多益、托福或雅思的目標分數。",
 "scholl_detail":"日系的C2UBEC語言學校，整合了更多學校的資源，除了提供最多堂的一對一課程之外，同時也特別打造了學生諮詢系統，定期關心學生的學習狀況，排解學生的壓力，每天也會安排字彙測驗，檢視學習成效",
 "image":"C2UBEC",
 "lat":10.373932,
 "log":123.918832],
 
 */









