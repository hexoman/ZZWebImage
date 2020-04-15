//
//  ViewController.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let Identifier = "CollectionViewCell"
    var imageList = ["https://webresource.c-ctrip.com/ResH5HotelOnline/R1/HotelUserCouponFooter@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/HotelUserCouponHeader@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/coupon_hui.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/coupon_lihe.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_nosearch_yy@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_pic_ad@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_Subscripts@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/HotelUserCouponButton@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_icon_big_play@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_icon_bozhuan@3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_icon_jinzhuan@3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_icon_list_fav@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_img_artfont@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_logo_star_golden_list@3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_logo_star_pt_list@3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_pulldown_yy@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_tabbg_special.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_tabbg_video.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_tabbg_surrounding.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_tabbg_local.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_tabbg_guess.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_tabbg_season.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_comment_coupon@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_order_sectionheader_gradient_bg.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/Q-icon-blue45.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/Q-icon-golden45.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_detail_shop_address_background_3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_meetingroom_720@3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_coupon_multiprices_left_unselected_bg.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_barrage_topicon@2x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_video_barrage.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/receive_coupon_success@3x.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_logo_star_golden_list_grey.png",
                    "https://webresource.c-ctrip.com/ResH5HotelOnline/R1/hotel_logo_star_pt_list_grey.png",
                    "https://pages.c-ctrip.com/wireless-app/imgs/hotel_detail_shop_decorate_address_background.png",
                    "https://pages.c-ctrip.com/wireless-app/imgs/hotel_default_avatar.png",
                    "https://pages.c-ctrip.com/wireless-app/icons/hotel_main_bottom_top2@3x.png",
                    "https://pages.c-ctrip.com/wireless-app/icons/hotel_main_bottom_more2@3x.png"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 10, right: 5)
        
        let collectionView = UICollectionView.init(frame: CGRect(x:0, y:64, width:400, height:850), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: Identifier)
        self.view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 38
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! CollectionViewCell
        let index = indexPath.row
        cell.setData(imageList[index])
        return cell
    }

    func armColor()->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
