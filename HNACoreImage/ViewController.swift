//
//  ViewController.swift
//  HNACoreImage
//
//  Created by __无邪_ on 2017/8/16.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let identifier = "identifier"
    
    var categories: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.categories = NSMutableArray()
        self.getSystemCategories()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Datas
    
    func getSystemCategories() {
        
        /*
         https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
        */
        self.categories.addObjects(from: [kCICategoryDistortionEffect,
                                          kCICategoryBuiltIn,
                                          kCICategoryGeometryAdjustment,
                                          kCICategoryCompositeOperation,
                                          kCICategoryHalftoneEffect,
                                          kCICategoryColorAdjustment,
                                          kCICategoryColorEffect,
                                          kCICategoryTransition,
                                          kCICategoryTileEffect,
                                          kCICategoryGenerator,
                                          kCICategoryReduction,
                                          kCICategoryGradient,
                                          kCICategoryStylize,
                                          kCICategorySharpen,
                                          kCICategoryBlur,
                                          kCICategoryVideo,
                                          kCICategoryStillImage,
                                          kCICategoryInterlaced,
                                          kCICategoryNonSquarePixels,
                                          kCICategoryHighDynamicRange
                                          ])
        
        if ProcessInfo().operatingSystemVersion.majorVersion >= 9 {
            self.categories.add(kCICategoryFilterGenerator)
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let title = self.categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath)
        
        cell.textLabel?.text = title as? String
        
        return cell
    }
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = FiltersController()
        controller.categoryType = self.categories[indexPath.row] as? String
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

