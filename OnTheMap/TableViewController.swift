//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 18.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//
import UIKit

class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var tabController: TabBarController?
        tabController=navigationController?.viewControllers.first(where: {$0 is TabBarController}) as? TabBarController
        print("jestm w liscie i: \(tabController)")
        tabController?.setNavigationBarTitle(title: "Student List")
    }

}
