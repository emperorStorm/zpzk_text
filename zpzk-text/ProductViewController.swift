//
//  ProductViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

class ProductViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let menuArray = LogMenu.getMenu()//标签数据
    var products = [Product]()//商品数据
    var activity = UIActivityIndicatorView()//活动指示器
    var refresh = UIRefreshControl()//下拉刷新
    var details = Detail()//商品详情
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivity()
        loadMenu()
        loadProduct(6)
        loadRefresh()
        
        collectionView.registerNib(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //刷新
    func loadRefresh() {
        refresh.addTarget(self, action: Selector("refreshDown"), forControlEvents: .ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新")
        refresh.tintColor = UIColor.redColor()
        collectionView.addSubview(refresh)
    }
    
    //下拉
    func refreshDown() {
        collectionView.reloadData()
        refresh.endRefreshing()
    }
    
    //创建活动指示器
    func loadActivity() {
        activity = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activity.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)
        activity.hidden = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.redColor()
        self.view.addSubview(activity)
    }
    
    //加载标签
    func loadMenu() {
        scrollView.contentSize = CGSizeMake(CGFloat(menuArray.count) * 65, 30)
        for index in 0..<menuArray.count {
            let btn = UIButton(type: .System)
            btn.frame = CGRectMake(CGFloat(index) * 65, 0, 65, 30)
            btn.setTitle(menuArray[index]["name"] as? String, forState: .Normal)
            btn.tintColor = UIColor.blackColor()
            btn.tag = index
            if index == 0 {
                btn.tintColor = UIColor.redColor()
            }
            btn.addTarget(self, action: Selector("clickMenu:"), forControlEvents: .TouchUpInside)
            scrollView.addSubview(btn)
        }
    }
    
    //点击标签
    func clickMenu(btn:UIButton) {
        //根据标签id加载对应的商品
        loadProduct(menuArray[btn.tag]["id"] as! Int)
        for (index,button) in scrollView.subviews.enumerate() {
            if index == btn.tag {
                button.tintColor = UIColor.redColor()
            }else {
                button.tintColor = UIColor.blackColor()
            }
        }
    }
    
    //加载商品
    func loadProduct(tagid:Int) {
        activity.startAnimating()
        var param = [String:AnyObject]()
        param["sort_type"] = "created_at-desc"
        param["tag_id"] = tagid
        param["page"] = 1
        Alamofire.request(.GET, "http://api.zpzk100.com/client/product_list", parameters: param).responseJSON {
            (response) -> Void in
            if let JSON = response.result.value {
                self.products = Product.getProduct(JSON)
                self.collectionView.reloadData()
                self.activity.stopAnimating()
            }
        }
    }
    
    //cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    //cell的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.productImage.setWebImage(products[indexPath.row].image!, placeHolder: UIImage(named: "zpzk"))
        cell.productDescribe.text = products[indexPath.row].content!
        cell.productDiscount.text = String(products[indexPath.row].discount!) + "折"
        cell.productPrice.text = "¥" + String(products[indexPath.row].price!)
        return cell
    }
    
    //点击进入页面详情
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var prame = [String:AnyObject]()
        prame["id"] = products[indexPath.row].id
        Alamofire.request(.GET, "http://api.zpzk100.com/client/product_detail", parameters: prame).responseJSON {
            (response) -> Void in
            if let JSON = response.result.value {
                self.details = Detail.setDetail(JSON)
                let selectDetail = ProductDetailViewController()
                NSBundle.mainBundle().loadNibNamed("ProductDetailViewController", owner: selectDetail, options: nil)
                
                selectDetail.detailImage.setWebImage(self.details.detailImage!, placeHolder: UIImage(named: "zpzk"))
                selectDetail.detailIntroduction.text = self.details.detailIntroduction!
                selectDetail.oldPrice.text = "￥"+String(self.details.discountPrice!)
                selectDetail.newPrice.text = "原价:"+String(self.details.originalPrice!)
                selectDetail.discount.text = self.details.discount!+"折"
                selectDetail.detailUrl = self.details.detailUrl!
                self.presentViewController(selectDetail, animated: true, completion: nil)
            }
        }
    }

    //点击进入左侧分类菜单
    @IBAction func logMenu(sender: UIButton) {
        
    }
}
