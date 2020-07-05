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
class ViewController: UIViewController {

    var timeStamp1 : Int?
    var comments: JSON?
    var goodsInfo: JSON?
    var timeStamp2: Int?
    var timeStamp3: Int?
    var timeStamp4: Int?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottombar: UIView!
    @IBOutlet weak var popview: UIView!

        override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: set Datasource
        self.tableView.dataSource = self
        self.tableView.delegate = self
       popview.isHidden = true
            
        let now1 = NSDate()
        let timeInterval1:TimeInterval = now1.timeIntervalSince1970

        self.timeStamp2 = Int(timeInterval1)
            print(" timeStamp2-timeStamp1")
            print(timeStamp2)
            print(timeStamp1)
            print(timeStamp2! - timeStamp1!)
            print(" timeStamp2-timeStamp1")
        let parameters: [String: String] = [
                "url": "test1",
                "th_app_id": "ios",
                "duration":"100"
            ]
            AF.request("https://geylnu.com/tuhu/pageloadDuration", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
                .responseJSON { test in
              //  print(test)
            }
            
            
            
       AF.request("https://api.tuhu.cn/Product/GetProductDetail?activityId=&pid=OL-MO-ONE-5W40-1%7C").response { response in
               
          let data = JSON.init(response.data)
          self.goodsInfo = data
          let coms = self.goodsInfo? ["Comments"]
          //let imagesStrArr: [String] = images.arrayValue.map({ $0.stringValue })
        let parameters: [String: String] = [
                "url": "test1",
                "th_app_id": "ios",
                "duration":"100",
                "httpCode":"200"
            ]
            AF.request("https://geylnu.com/tuhu/networkRequestMonitor", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
                .responseJSON { test in
              //  print(test)
            }
          self.tableView.reloadData()
        
       }
        AF.request("https://api.tuhu.cn/Comment/SelectProductTopNComments?productId=OL-MO-ONE-5W40-1").response { response in
                
            let data = JSON.init(response.data)
            self.comments = data;
            self.tableView.reloadData()
            let parameters: [String: String] = [
                    "url": "test1",
                    "th_app_id": "ios",
                    "duration":"100",
                    "httpCode":"200"
                ]
                AF.request("https://geylnu.com/tuhu/networkRequestMonitor", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
                    .responseJSON { test in
                  //  print(test)
                }
        }
    }
    
    override func  loadView() {
        super.loadView()
        let parameters: [String: String] = [
            "url": "test1",
            "th_app_id": "ios",
        ]
        let now = NSDate()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        print("---timStamep1----")
        self.timeStamp1 = Int(timeInterval)
        print(self.timeStamp1)
        print("---timStamep1----")
        AF.request("https://geylnu.com/tuhu/pageview", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .responseJSON { test in
          //  print(test)
        }
    }
    @IBAction func popView(_ sender: UIButton) {
        popview.isHidden = false
        tableView.isUserInteractionEnabled=true;
        bottombar.isUserInteractionEnabled=true;
        popview.isUserInteractionEnabled=false
        let parameters: [String: String] = [
                "elementId": "productInfo_shopping_cart",
                "th_app_id": "ios",
                "productId":"AP-GP-CL",            ]
        AF.request("https://geylnu.com/tuhu/clickElement", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .responseJSON { test in
          //  print(test)
        }
        
        
        
        
    }
    @IBAction func closePopView(_ sender: UIButton) {
        popview.isHidden = true
 
    }
    
    @IBAction func add(_ sender: UIButton) {
          popview.isHidden = true

    }
    @IBAction func close(_ sender: UIButton) {
  popview.isHidden = true

    }
    
    
    
    
}

//MARK: Datasource
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 11
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
            //identifer="spaceCell"
        case 4:
            identifer="SubtitleCell"
           // identifer="spaceCell"
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
//            let images=data["Product"]["Image"]["ImageUrls"][0]
//            print(images)
//            imagecell.headimage
            let
            userimage=goodsInfo?["Product"]["Image"]["ImageUrls"][0].stringValue
            let url : URL = try! URL.init(string: userimage ??  "https://img1.tuhu.org/UserHead/7da1/0e0e/24e0981f04e48e239248e278_w390_h390.png@100w_100h_100Q.png") as! URL
             let data : NSData! = NSData(contentsOf: url as URL)
             if(data != nil)
             {
                    imagecell.headimage.image =  UIImage.init(data: data as Data, scale: 1)
             }else{

                   imagecell.headimage.image = UIImage.init(named: "") // 否则就赋值默认图片
                 
             }
            
            
            
        }else if let priceCell:PriceCell=cell as? PriceCell{
            //最好前面再加点东西
            priceCell.nowPriceLabel.text = goodsInfo?["Product"]["Price"].stringValue;
            print(goodsInfo?["Product"]["Price"].stringValue)
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
//            commentHeadCell.keyworks1.layer.cornerRadius = 13
//            commentHeadCell.keywords2.layer.cornerRadius = 13
//            commentHeadCell.keywords3.layer.cornerRadius = 13
//            commentHeadCell.keywords4.layer.cornerRadius = 13
//            commentHeadCell.keywords5.layer.cornerRadius = 13
//            commentHeadCell.keywords6.layer.cornerRadius = 13
            [commentHeadCell.keyworks1.layoutIfNeeded];//iOS 10需要添加这个
           commentHeadCell.keyworks1.layer.cornerRadius = 13
           commentHeadCell.keyworks1.clipsToBounds = true;
             
            
            
            
        }else if let commentCell:CommentCell=cell as?CommentCell
        {
            let images=comments?["Comments"][indexPath.item-9]["CommentImages"].arrayValue.map({$0.stringValue})
            let
               userimage=comments?["Comments"][indexPath.item-9]

            let url : URL = try! URL.init(string: images?[0] ??  "https://img1.tuhu.org/UserHead/7da1/0e0e/24e0981f04e48e239248e278_w390_h390.png@100w_100h_100Q.png") as! URL
            let data : NSData! = NSData(contentsOf: url as URL)
            if(data != nil)
            {
                   commentCell.commentimg1.image =  UIImage.init(data: data as Data, scale: 1)
            }else{

                  commentCell.commentimg1.image = UIImage.init(named: "") // 否则就赋值默认图片
                
            }
            let url1 : URL = try! URL.init(string: images?[0] ?? "https://img1.tuhu.org/UserHead/7da1/0e0e/24e0981f04e48e239248e278_w390_h390.png@100w_100h_100Q.png")!
             let data1 : NSData! = NSData(contentsOf: url1 as URL)
             if(data != nil)
             {
                //diergetup
                
                commentCell.commenting2.isHidden=true
                  commentCell.commenting2.image =  UIImage.init(data: data1 as Data, scale: 1)
             }else{

                  commentCell.commenting2.image = UIImage.init(named: "") // 否则就赋值默认图片
             }
            let url2 : URL = try! URL.init(string: userimage?["HeadImage"].stringValue ?? "https://img1.tuhu.org/UserHead/7da1/0e0e/24e0981f04e48e239248e278_w390_h390.png@100w_100h_100Q.png")!
             let data2 : NSData! = NSData(contentsOf: url2 as URL)
             if(data != nil)
             {
                //头像
                
                  commentCell.portrait.image =  UIImage.init(data: data2 as Data, scale: 1)
             }else{

                  commentCell.portrait.image = UIImage.init(named: "") // 否则就赋值默认图片
                 
             }
            
            
            commentCell.userName.text = comments?["Comments"][ indexPath.item - 9]["UserName"].stringValue
            commentCell.commentTime.text=comments?["Comments"][indexPath.item-9]["CommentTime"].rawString()
            commentCell.CarTypeDes.text=comments?["Comments"][indexPath.item-9]["CarTypeDes"].stringValue
            commentCell.InstallShop.text = comments?["Comments"][indexPath.item-9]["InstallShop"].stringValue
            commentCell.OrderTime.text = comments?["Comments"][indexPath.item-9]["OrderTime"].stringValue
            commentCell.commentcontent.text = comments?["Comments"][indexPath.item-9]["CommentContent"].stringValue
         
            
        }else if let spaceCell: SpaceCell=cell as? SpaceCell{
            
            
        }else{
           
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
            return 155
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
    
    @IBOutlet weak var headimage: UIImageView!
    
    
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
    
    @IBOutlet weak var keyworks1: UILabel!
    @IBOutlet weak var keywords2: UILabel!
    @IBOutlet weak var keywords3: UILabel!
    @IBOutlet weak var keywords4: UILabel!
    @IBOutlet weak var keywords5: UILabel!
    @IBOutlet weak var keywords6: UILabel!
}
class CommentCell : UITableViewCell{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    @IBOutlet weak var CarTypeDes: UILabel!
    @IBOutlet weak var InstallShop: UILabel!
   // @IBOutlet weak var commentcontant: UIView!
    @IBOutlet weak var OrderTime: UILabel!
    @IBOutlet weak var commentcontent: UILabel!
    
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var commentimg1: UIImageView!
    
    @IBOutlet weak var commenting2: UIImageView!
}
class SpaceCell :UITableView{
    
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
