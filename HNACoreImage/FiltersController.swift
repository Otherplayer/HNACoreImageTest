//
//  FiltersController.swift
//  HNACoreImage
//
//  Created by __无邪_ on 2017/8/16.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class FiltersController: UITableViewController {

    public var categoryType: String?
    
    let identifier = "identifier"
    var filters: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Filters"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        self.getfilterDatas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Datas
    func getfilterDatas() {
        let filterNames = CIFilter.filterNames(inCategory: categoryType!);
        self.filters = filterNames
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let title = self.filters[indexPath.row]
        
        cell.textLabel?.text = title
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        do {
            let image = try filterGaussianBlur(filterName: title)
            cell.imageView?.image = image
        } catch let err as NSError {
            print(err)
            cell.imageView?.image = nil
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AttributesController()
        controller.filterType = self.filters[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func filterGaussianBlur(filterName: String) -> UIImage {
        
        let image = UIImage(named: "6468495.jpeg")
        let inputImage = CIImage(image: image!)
        // 创建 CIFilter
        let filter = CIFilter(name: filterName)
        let atts = filter?.attributes
        
        if atts!["inputImage"] != nil {
            
            // 设置滤镜输入参数
            filter?.setValue(inputImage, forKey: "inputImage")
            // 设置参数
            filter?.setDefaults()
            // 输出
            let outputImage = filter?.outputImage
            if outputImage != nil {
                let context = CIContext(options: nil)
                let cgImage = context.createCGImage(outputImage!, from: (inputImage?.extent)!)
                return UIImage(cgImage: cgImage!)
            }
            
        }
        
        return image!
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
