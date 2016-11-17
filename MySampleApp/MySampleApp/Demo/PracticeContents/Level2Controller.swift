//
//  MainViewController.swift
//  MySampleApp
//
//
// Copyright 2016 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.4
//

import UIKit
import AWSMobileHubHelper

class Level2Controller: UITableViewController {
    
    var sections: [Section] = []
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        
        // You need to call `- updateTheme` here in case the sign-in happens before `- viewWillAppear:` is called.
        // you could replace the contents of this function with an HTTP GET, a database fetch request,
        // or anything you like, as long as you return an array of Sections this program will
        // function the same way.
        
        let workEnglish = Section(title: "Work English", objects: ["Networking", "The Virtual Classroom", "Scheduling"," Company Organizations 1"," Company Organizations 2","Business Travel","Meetings","Project Management","Purchasing"],icon: "IconLessons", storyBoard: "VideoView")
        let lifeEnglish = Section(title: "Life English", objects: ["Family", "Small Talk", "Weekend Plans","Personal Travel","Shopping","Health","Emergencies","Fast Food","Dining Out"],icon: "IconLessons", storyBoard: "VideoView")
        
        
        
        sections.append(workEnglish)
        sections.append(lifeEnglish)
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MainViewCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.imageView!.image = UIImage(named: sections[indexPath.section].icon)
        cell.detailTextLabel!.text = ""

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let demoFeature = sections[indexPath.row]
        let storyboard = UIStoryboard(name: demoFeature.storyBoard, bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier(demoFeature.storyBoard)
        self.navigationController!.pushViewController(viewController, animated: true)
        
    }
    
}



