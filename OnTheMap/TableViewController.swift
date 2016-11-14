//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Teodor Niżyński on 18.10.2016.
//  Copyright © 2016 Teodor Niżyński. All rights reserved.
//
import UIKit

class TableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tabController: TabBarController?
    var fakeUrl:[String]=["https://developer.apple.com/reference/appkit/nsworkspace#relationships",
                          "https://discussions.udacity.com/t/problem-with-submit-link/188544",
                          "http://kwejk.pl/obrazek/2792607/czymam-sie.html",
                          "https://www.bitmarket.pl/market.php?market=BTCPLN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = .zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabController=navigationController?.viewControllers.first(where: {$0 is TabBarController}) as? TabBarController
        print("jestm w liscie i: \(tabController)")
        tabController?.setNavigationBarTitle(title: "Student List")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return fakeUrl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=UITableViewCell(style: .default, reuseIdentifier: "StudentList")
        cell.textLabel?.text=fakeUrl[indexPath.row]
        cell.imageView?.image=UIImage(imageLiteralResourceName: "PinIcon")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("test")
        openIfPosibleLinkInBrawser(notSafeURL:fakeUrl[indexPath.row])
    }

    /* same as in mapViewController,FindLocation and SetLink - feels like unnecessary duplication of code :/
    but I didnt want to create new indicator and then destroy it - over and over */
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func setActivityIndicatorAsHidden(hide:Bool)
    {
        activityIndicator?.isHidden=hide
    }
}
