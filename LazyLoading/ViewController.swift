//
//  ViewController.swift
//  LazyLoading
//
//  Created by Yogesh Rathore on 16/04/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    var totalArray: [String] = [];
    var itemsArray: [String] = [];
    var pageNum: Int = 0;
    var pageItemCount = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTotalArray()
        loadMore()
    }
    
    func loadTotalArray() {
        for i in 0...100 {
            totalArray.append("Item \(i)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell!.textLabel?.text = itemsArray[indexPath.row]
        return cell!
    }
    
    func loadMore() {
        let initialItemIndex = pageNum * pageItemCount;
        var finalItemIndex = initialItemIndex + 20;
        if(finalItemIndex >= totalArray.count) {
            finalItemIndex = totalArray.count
        }
        let totalSubArray = totalArray[initialItemIndex..<finalItemIndex].map{$0};
        itemsArray += totalSubArray;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            itemsTableView.reloadData()
            if itemsArray.count == totalArray.count {
                print("End of array reached");
            } else {
                pageNum += 1
                print("Loading more data with page \(pageNum)");
                loadMore()
                
            }
        }
    }
}

