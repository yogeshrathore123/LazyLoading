//
//  ApiDataViewController.swift
//  LazyLoading
//
//  Created by Yogesh Rathore on 17/04/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit
import SDWebImage

class ApiDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    var pageNum: Int = 1;
    var pageItemCount = 0;
    var userItems: [User] = [];
    var totalArrayCount: Int = 0
    var totalPagesCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        itemsTableView.register(cellNib, forCellReuseIdentifier: "UserTableViewCell")
        
        loadMore()
    }
    
    func loadMore() {
        let url = URL(string: "https://reqres.in/api/users?page=\(pageNum)")!
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                print("error in call \(error?.localizedDescription as Any)")
            } else {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(APIResults.self, from:
                        data!)
                    self.pageNum = results.pageNum!
                    self.pageItemCount = results.pageSize!
                    self.totalArrayCount = results.totalItemsCount!
                    self.totalPagesCount = results.totalPagesCount!
                    self.userItems += results.contentItems
                    self.itemsTableView.reloadData()
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            
        })
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell {
            cell.firstNameLabel.text = "\(indexPath.row)" + userItems[indexPath.row].firstName
            cell.lastNameLabel.text = userItems[indexPath.row].lastName
            let img = userItems[indexPath.row].avatar
            print(img)
            
            
            //            let url = URL(string: img)
            //
            //            DispatchQueue.global().async {
            //                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            //                DispatchQueue.main.async {
            //                    cell.avatarImageView.image = UIImage(data: data!)
            //                }
            //            }
            
            cell.avatarImageView.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "icon.png"))
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            itemsTableView.reloadData()
            if (userItems.count == totalArrayCount || pageNum == totalPagesCount) {
                print("End of array reached");
            } else {
                pageNum += 1
                print("Loading more data with page \(pageNum)");
                loadMore()
            }
        }
    }
}

