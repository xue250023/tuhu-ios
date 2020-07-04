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
class ViewController: UIViewController  {

    var comments: JSON?
    var goodsInfo: JSON?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popview: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: set Datasource
        self.tableView.dataSource = self
        self.tableView.delegate = self
        popview.isHidden = true
//        GetProductDetail();
//        SelectProductTopNComments();
       
        AF.request("https://api.tuhu.cn/Comment/SelectProductTopNComments?productId=OL-MO-ONE-5W40-1").response { response in
                
            let data = JSON.init(response.data)
            self.comments = data;
            print (self.comments)
        }
        
        
        AF.request("https://api.tuhu.cn/Product/GetProductDetail?activityId=&pid=OL-MO-ONE-5W40-1%7C").response { response in
                
            let data = JSON.init(response.data)
            self.goodsInfo = data
            let coms = self.goodsInfo?["Comments"]
            print("----goods------")
            print(coms?[0])
             print("----goods------")

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
        
        
        
        if let imagecell : ImageCell=cell as? ImageCell{
            //设置图片
        }else if let priceCell:PriceCell=cell as? PriceCell{
            priceCell.nowPriceLabel.text="$100"
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


