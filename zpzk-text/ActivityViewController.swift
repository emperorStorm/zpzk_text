//
//  ActivityViewController.swift
//  zpzk-text
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

class ActivityViewController: UIViewController,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!

    
    var sumArray = [Activity]()
    var showArray = [Activity]()
    var timer = NSTimer()
    var shops = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.redColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        loadImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    

    
    //从接口获取数据
    func loadImage() {
        let dic = [String : AnyObject]()
        Alamofire.request(.GET, "http://api.zpzk100.com/client/brand_theme_index", parameters: dic).responseJSON { (response) -> Void in
            if let JSON = response.result.value {
                self.sumArray = Activity.saveActivity(JSON)
                self.shops = Activity.getActivityShop(JSON)
                self.tableView.reloadData()
                self.loadShowArray()
            }
        }
    }
    
    //加载ShowArray数据
    func loadShowArray() {
        for image in self.scrollView.subviews{
            image.removeFromSuperview()
        }
        
        scrollView.contentSize = CGSizeMake(CGFloat(sumArray.count) * scrollView.frame.width, scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        changeShowArray()
        
        for (index,imageStr) in showArray.enumerate() {
            let picture = UIImageView(frame: CGRectMake(CGFloat(index) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height))
            
            picture.setWebImage(imageStr.image_path!, placeHolder: UIImage(named: "zpzk"))
            
            scrollView.addSubview(picture)
        }
        pageControl.numberOfPages = sumArray.count
        
        //将视图移至中间
        scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width,0), animated: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("nextImage"), userInfo: nil, repeats: true)
    }
    
    //下一张图片
    func nextImage() {
        scrollView.setContentOffset( CGPoint(x: CGFloat(2) * self.scrollView.frame.size.width,y: 0), animated: true)
    }
    
    //当scrollView的contentOffset发生变化时调用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //判断是不是这个scrollView，可能存在多个scrollView的contentOffset发生变化
        if scrollView != self.scrollView{
            return
        }
        
        let x = scrollView.contentOffset.x
        var page = pageControl.currentPage
        let n = sumArray.count
        //根据contentOffset.x判断page，从而获得显示内容
        if x >= 2 * scrollView.frame.size.width {
            page = (page + 1) % n    //0的下一页 1，2，3，4，0
            pageControl.currentPage = page
            changeShowView()
        }else if x <= 0 {
            page = (page + (n - 1)) % n    //0的上一页 4，3，2，1，0
            pageControl.currentPage = page
            changeShowView()
        }
    }
    
    //设置showArray的图片
    func changeShowView() {
        changeShowArray()
        var scrollImages = scrollView.subviews as! [UIImageView]

        for (index,imageStr) in showArray.enumerate() {
            scrollImages[index].setWebImage(imageStr.image_path!, placeHolder: UIImage(named: "zpzk"))
        }
        scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width,0), animated: false)
    }
    
    
    //改变showArray的数组
    func changeShowArray() {
        let page = pageControl.currentPage
        switch page {
        case 0 :
            setShowArray(sumArray.count - 1, current: page, last: page + 1)
        case sumArray.count - 1:
            setShowArray(page - 1, current: page, last: 0)
        default :
            setShowArray(page - 1 , current: page, last: page + 1)
        }
    }
    
    //showArray的排列顺序添加规则
    func setShowArray(first : Int,current : Int, last : Int) {
        showArray.removeAll()
        showArray.append(sumArray[first])
        showArray.append(sumArray[current])
        showArray.append(sumArray[last])
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ActivityTableViewCell
        let shop = shops[indexPath.row]
        cell.shopName.text = shop.name
        cell.shopDiscount.text = String(shop.discount)+"折起"
        cell.shopImage.setWebImage(shop.image_url, placeHolder: UIImage(named: "zpzk"))

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
}
