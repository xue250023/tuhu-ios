//
//  ViewController.swift
//  TuhuiOSLessonDemoApp
//
//  Created by JamesDouble on 2020/6/17.
//  Copyright © 2020 jameskuo. All rights reserved.
//

import UIKit
//
import Alamofire
import  SwiftyJSON
class ViewController: UIViewController ,SliderGalleryControllerDelegate {


    var comments: JSON?
    var goodsInfo: JSON?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popview: UIView!
   //--- 轮播图----/
    //获取屏幕宽度
    let screenWidth =  UIScreen.main.bounds.size.width

    //图片轮播组件
    var sliderGallery : SliderGalleryController!

    //图片集合
    var images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767162&di=c1020f64d786a325a67ee879e3ac9e5d&imgtype=0&src=http%3A%2F%2Fimg.app178.com%2Ftu%2F201410%2Fyhrgcry32t4.jpg",
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767162&di=d006cd9610c46120b1aabe234ab4812c&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201401%2F22%2F134002dhye9qe2g2nq2geu.jpg",
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767161&di=3725ac75d78e2823033bb54bdf33e3ea&imgtype=0&src=http%3A%2F%2F01.minipic.eastday.com%2F20170330%2F20170330044723_a0c69f758cc90e87e8c8e620eb55308e_2.jpeg",
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767160&di=73123c4ec1a7def8d911d815147d385c&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201312%2F03%2F165620x7cknad7vruvec1z.jpg",
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767159&di=1bf25e664df31768dc4010fabb44d4e2&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F54fbb2fb43166d22d552b941432309f79052d23a.jpg"]

        //--轮播图--/
        override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: set Datasource
        self.tableView.dataSource = self
        self.tableView.delegate = self
        popview.isHidden = true
        //--轮播图--/
        //初始化图片轮播组件
        sliderGallery = SliderGalleryController()
        sliderGallery.delegate = self
        sliderGallery.view.frame = CGRect(x: 10, y: 40, width: screenWidth,
                                          height: (screenWidth-20)/4*3);
        //将图片轮播组件添加到当前视图
        //self.addChild(sliderGallery)
        //tableView.tableHeaderView =  sliderGallery.view
        //---轮播图--/
        
        
        
        
        
        
       AF.request("https://api.tuhu.cn/Product/GetProductDetail?activityId=&pid=OL-MO-ONE-5W40-1%7C").response { response in
               
          let data = JSON.init(response.data)
          self.goodsInfo = data
          let coms = self.goodsInfo? ["Comments"]
          let images=data["Product"]["Image"]["ImageUrls"]
          let imagesStrArr: [String] = images.arrayValue.map({ $0.stringValue })
          print("----goods11------")
          print(imagesStrArr)
          print("----goods11------")
        self.tableView.reloadData()
        

       }
        AF.request("https://api.tuhu.cn/Comment/SelectProductTopNComments?productId=OL-MO-ONE-5W40-1").response { response in
                
            let data = JSON.init(response.data)
            self.comments = data;
            
            
        }
        
        

        
    }

    
    @IBAction func popView(_ sender: UIButton) {
        popview.isHidden = false
    }
    @IBAction func closePopView(_ sender: UIButton) {
        popview.isHidden = true
    }




      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
    
    //--lunbotu--/
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: screenWidth-20, height: (screenWidth-20)/4*3)
    }

    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return images
    }


    
}

//MARK: Datasource
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifer:String;
        switch indexPath.item {
        case 0:
            identifer="ImageCell"
        case 1:
            identifer="PriceCell"
        case 2:
            identifer="TitleCell"
        case 3:
            identifer="IntroduceCell"
        case 4:
            identifer="SubtitleCell"
        case 5:
            identifer="DiscountCell"
        case 6:
            identifer="SelectedCell"
        case 7:
            identifer="SlogenCell"
        case 8:
            identifer="CommentHeadCell"
        default:
            identifer="CommentCell"
        }
        let  cell:UITableViewCell=tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        
        
         let coms = self.comments?["Comments"]
        
        
        if let imagecell : ImageCell=cell as? ImageCell{
            //设置图片
        }else if let priceCell:PriceCell=cell as? PriceCell{
            priceCell.nowPriceLabel.text = goodsInfo?["Product"]["Price"].stringValue;
            print("----1111---")
            print(goodsInfo?["Product"]["Price"])
              print("---1111----")
            //设置价格
        }else if let titleCell:TitleCell=cell as? TitleCell{
            //设置title
        }else if let subtitleCell:SubtitleCell=cell as? SubtitleCell{
        
            //设置SubtitleCell
        }else if let discountCell:DiscountCell=cell as? DiscountCell{
            //设置DiscountCell
        }else if let selectedCell:SelectedCell=cell as? SelectedCell{
            //设置SelectedCell
        }else if let slogenCell:SlogenCell=cell as? SlogenCell{
            //SlogenCell
        }else if let commentHeadCell:CommentHeadCell=cell as?CommentHeadCell {
            //设置CommentHeadCell
        }else if let commentCell:CommentCell=cell as?CommentCell
        {
            //commentCell
            //  .[i++]
            //datauserName commentTime
           
            let datauserName : [ String] = ["张三","李四","王武","张三","李四","王武","张三","李四","王武","张三","李四","王武","张三","李四","王武","张三","李四","王武","张三","李四","王武"]
            let  commentTime: [String] =  ["1998-01-23","1998-01-24","1998-01-25"]
        commentCell.userName.text = datauserName[ indexPath.item - 9]
//            commentCell.commentTime.text=commentTime
            //i 有问题，我想放在数组里一个评论取一个 但是 i 有问题
            
            
            
        }
            
        else{
           
        }
        
        return cell;
    }
    
    
}


//MARK: Delegate 设置宽高的
extension ViewController: UITableViewDelegate {
    
    /// Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0 :
            return 360
        case 1:
            return 66
        case 2:
            return 83
        case 3:
            return 48
        case 4:
            return 81
        case 5:
            return 169
        case 6:
            return 63
        case 7:
            return 43.5
        case 8:
            return 138
        case 9:
            return 327
        default:
            return  327
        }
    }
    
}

/// Cell subclass
class ImageCell: UITableViewCell {
    
}

class PriceCell: UITableViewCell {
    @IBOutlet weak var nowPriceLabel: UILabel!
    @IBOutlet weak var perPrice: UILabel!
    //xuyaokjiaohu
    
}

class TitleCell : UITableViewCell{
   // @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var titlelable: UILabel!
    
}
class IntroduceCell : UITableViewCell{
    
}
class SubtitleCell : UITableViewCell{
    
}
class DiscountCell : UITableViewCell{
    
}
class SelectedCell : UITableViewCell{
    
}
class SlogenCell : UITableViewCell{
    
}
class CommentHeadCell : UITableViewCell{
    
}
class CommentCell : UITableViewCell{
    
    @IBOutlet weak var userName: UILabel!
    // @IBOutlet weak var tuhuusername1: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    @IBOutlet weak var CarTypeDes: UILabel!
    @IBOutlet weak var InstallShop: UILabel!

    @IBOutlet weak var OrderTime: UILabel!
    
}


/// MARK: TableView's flow
/**
    Controller -> TableView
        TableVew's datasource  (protocol)
     1 tableview -> datasource -> ask how much cell amount
      2.  IndexPath (postion) -> datasouce -> display what cell
      3. dequeueReusableCell:
            reuseId -> storybaord -> cell's style -> cell's class -> cell's instance (calss: PriceCell)
             
 */


//class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, SliderGalleryControllerDelegate {
//    @IBOutlet weak var tableView: UITableView!
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1;
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let identifer:[String] = [
//                    "imageCell"
//                ]
//                let id = identifer[indexPath.item]
//                let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
//                return cell
//    }
//    //Mark:设置高度
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.item {
//        case 0 :
//            return 360
//        default:
//            return 0
//        }
//    }
//
//    //获取屏幕宽度
//    let screenWidth =  UIScreen.main.bounds.size.width
//
//    //图片轮播组件
//    var sliderGallery : SliderGalleryController!
//
//    //图片集合
//    var images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767162&di=c1020f64d786a325a67ee879e3ac9e5d&imgtype=0&src=http%3A%2F%2Fimg.app178.com%2Ftu%2F201410%2Fyhrgcry32t4.jpg",
//        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767162&di=d006cd9610c46120b1aabe234ab4812c&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201401%2F22%2F134002dhye9qe2g2nq2geu.jpg",
//                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767161&di=3725ac75d78e2823033bb54bdf33e3ea&imgtype=0&src=http%3A%2F%2F01.minipic.eastday.com%2F20170330%2F20170330044723_a0c69f758cc90e87e8c8e620eb55308e_2.jpeg",
//                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767160&di=73123c4ec1a7def8d911d815147d385c&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201312%2F03%2F165620x7cknad7vruvec1z.jpg",
//                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593665767159&di=1bf25e664df31768dc4010fabb44d4e2&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F54fbb2fb43166d22d552b941432309f79052d23a.jpg"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //MARK: set Datasource
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//
//        //初始化图片轮播组件
//        sliderGallery = SliderGalleryController()
//        sliderGallery.delegate = self
//        sliderGallery.view.frame = CGRect(x: 10, y: 40, width: screenWidth,
//                                          height: (screenWidth-20)/4*3);
//        //将图片轮播组件添加到当前视图
//        self.addChild(sliderGallery)
//        tableView.tableHeaderView =  sliderGallery.view
//    }
//
//    //图片轮播组件协议方法：获取内部scrollView尺寸
//    func galleryScrollerViewSize() -> CGSize {
//        return CGSize(width: screenWidth-20, height: (screenWidth-20)/4*3)
//    }
//
//    //图片轮播组件协议方法：获取数据集合
//    func galleryDataSource() -> [String] {
//        return images
//    }
//
//
//
//}
