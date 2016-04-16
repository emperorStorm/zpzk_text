//
//  LogMenuViewController.swift
//  zpzk-text
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class LogMenuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var logColletionView: UICollectionView!
    @IBOutlet weak var logScrollerView: UIScrollView!
    
    let menuArray = (NSUserDefaults.standardUserDefaults().objectForKey("leftMenu") as? NSArray)!
    var selector: [String:AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logColletionView.registerNib(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        logColletionView.registerClass(HeaderReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        selector = menuArray[0] as? [String:AnyObject]
        
        loadLeftMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //加载左侧菜单栏
    func loadLeftMenu() {
        logScrollerView.contentSize = CGSizeMake(100,CGFloat(menuArray.count) * 60)
        for index in 0..<menuArray.count {
            let btn = UIButton(type: .System)
            btn.frame = CGRectMake(0, CGFloat(index) * 60, 100, 60)
            btn.tintColor = UIColor.blackColor()
            btn.setTitle(menuArray[index]["name"] as? String, forState: UIControlState.Normal)
            btn.addTarget(self, action: Selector("clickLeftMenu:"), forControlEvents: .TouchUpInside)
            btn.tag = index
            if index == 0 {
                btn.tintColor = UIColor.redColor()
                btn.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }
            logScrollerView.addSubview(btn)
        }
    }
    
    //点击左侧菜单栏
    func clickLeftMenu(btn:UIButton) {
        selector = menuArray[btn.tag] as? [String:AnyObject]
        logColletionView.reloadData()
        
        for (index,subviews) in logScrollerView.subviews.enumerate() {
            if index == btn.tag {
                subviews.tintColor = UIColor.redColor()
                subviews.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }else {
                subviews.tintColor = UIColor.blackColor()
                subviews.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    

    //返回
    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let collection = selector,
            let group =  collection["sub_tag_group"] {
                return group.count
        } else {
            return 0
        }
    }
    
    //cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let collection = selector,
                let subTagGroup = collection["sub_tag_group"],
                let dict = subTagGroup[section],
                let array = dict["group_key"] as? [AnyObject] {
                    return array.count
            } else {
                return 0
            }
    }
    
    //cell的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MenuCollectionViewCell
        if  let collection = selector,
            let array = collection["sub_tag_group"] as? [AnyObject] {
                let groupKeys = array[indexPath.section]
                if let gps = groupKeys["group_key"] as? [AnyObject] {
                    let groupKey = gps[indexPath.row]
                    if let urlString = groupKey["img_url"] as? String,
                        let nameString = groupKey["sub_tag_name"] as? String {
                            let image = UIImage(named: "zpzk")
                            cell.menuImage.setWebImage(urlString, placeHolder: image)
                            cell.menuName.text = nameString
                    }
                }
        }
        return cell
    }
    
    //MARK:分组头视图设置
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)// as! HeaderReusableView
        if kind == UICollectionElementKindSectionHeader {
//            header.headerLb.text=(selector!["sub_tag_group"]![indexPath.section]["group_name"] as?String)!
        }
        return header
    }

    
    //MARK:分组头视图尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(282, 20)
    }
    
    

}
