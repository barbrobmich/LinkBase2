//
//  Seed.swift
//  LinkBase2
//
//  Created by Rob Hernandez on 4/17/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class Seed: NSObject {
    
    
    
    class func getQuest(type: String = "ALL") -> [Question]{
        let questions: [Question]
        switch type {
            
        case "verbal":
           questions =
            [
                VerbalQuestion(question: "How are you?", limit: 30),
                VerbalQuestion(question: "What are your interests?", limit: 30),
                VerbalQuestion(question: "What are your weaknesses?", limit: 30),
                VerbalQuestion(question: "What are you strengths?", limit: 30),
                VerbalQuestion(question: "How do you figure out how many piano tuners are there in Chicago?", limit: 60)
            ]
        case "choice":
            questions =
            [
                ChoiceQuestion(question: "You have a sorted list of n integers. In big-O notation, what's the worst case efficiency of using insertSorted() to insert one more integer into the sorted list?", choices: ["O(log n)", "O(n)", "O(n log n)", "O(n^2)"], correctAnswerIndex: 1),
                ChoiceQuestion(question: "What will value be after these statements?\nstack1.push(2)\nstack1.push(3)\nstack1.push(4)\nstack1.pop()\nvalue = stack1.peek()", choices: ["1", "2", "3", "4"], correctAnswerIndex: 2),
                ChoiceQuestion(question: "A priority queue orders its items by:", choices: ["time of entry", "value", "size", "priority"], correctAnswerIndex: 3),
                
                ChoiceQuestion(question: "Of the following ADT's, which would be the best choice for the input buffer to allow the typist to correct errors by using the backspace key?", choices: ["queue", "priority queue", "stack", "tree"], correctAnswerIndex: 2),
                
                ChoiceQuestion(question: "Each node in a binary tree has:", choices: ["exactly one parent", "at most one parent", "exactly two children", "at most one child"], correctAnswerIndex: 1),
                ChoiceQuestion(question: "In terms of efficiency, order the efficiency of the following binrary tree ops", choices: ["preorder > inorder > postorder traversal", "postorder > inorder > preorder", "inorder > preorder > postorder", "preorder == postorder == inorder traversal"], correctAnswerIndex: 3),
                
                 ChoiceQuestion(question: "Assume the function ceiling() rounds up a float to the next highest integer. Ex: ceiling(3.14) is 4, ceiling(3) is 3. The minimum height of a binary tree of n nodes is:", choices: ["n", "n/2", "(n/2)-2", "ceiling(log2(n+1))"], correctAnswerIndex: 3),
            ]
            

        default:
            questions = [
                ChoiceQuestion(question: "You have a sorted list of n integers. In big-O notation, what's the worst case efficiency of using insertSorted() to insert one more integer into the sorted list?", choices: ["O(log n)", "O(n)", "O(n log n)", "O(n^2)"], correctAnswerIndex: 1),
                ChoiceQuestion(question: "What will value be after these statements?\nstack1.push(2)\nstack1.push(3)\nstack1.push(4)\nstack1.pop()\nvalue = stack1.peek()", choices: ["1", "2", "3", "4"], correctAnswerIndex: 2),
                ChoiceQuestion(question: "A priority queue orders its items by:", choices: ["time of entry", "value", "size", "priority"], correctAnswerIndex: 3),
                
                ChoiceQuestion(question: "Of the following ADT's, which would be the best choice for the input buffer to allow the typist to correct errors by using the backspace key?", choices: ["queue", "priority queue", "stack", "tree"], correctAnswerIndex: 2),
                
                ChoiceQuestion(question: "Each node in a binary tree has:", choices: ["exactly one parent", "at most one parent", "exactly two children", "at most one child"], correctAnswerIndex: 1),
                ChoiceQuestion(question: "In terms of efficiency, order the efficiency of the following binrary tree ops", choices: ["preorder > inorder > postorder traversal", "postorder > inorder > preorder", "inorder > preorder > postorder", "preorder == postorder == inorder traversal"], correctAnswerIndex: 3),
                
                ChoiceQuestion(question: "Assume the function ceiling() rounds up a float to the next highest integer. Ex: ceiling(3.14) is 4, ceiling(3) is 3. The minimum height of a binary tree of n nodes is:", choices: ["n", "n/2", "(n/2)-2", "ceiling(log2(n+1))"], correctAnswerIndex: 3),
                VerbalQuestion(question: "How are you?", limit: 30),
                VerbalQuestion(question: "What are your interests?", limit: 30),
                VerbalQuestion(question: "What are your weaknesses?", limit: 30),
                VerbalQuestion(question: "What are you strengths?", limit: 30),
                VerbalQuestion(question: "How do you figure out how many piano tuners are there in Chicago?", limit: 60)
            ]
            
        }
        return questions

    }
    
    class func getRandChoicequestions() -> [Question]{
        var questions = self.getQuest(type: "choice")
        var randQuest: [Question] = []
        for i in 1...4{
            let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            let temp: Question  = questions.remove(at: randomIndex)
            randQuest.append(temp)
        }
        return randQuest
    }
    
    class func getRandVerbalQuestion() -> [Question]{
        var questions = self.getQuest(type: "verbal")
        var randQuest: [Question] = []
        for i in 1...4{
            let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            let temp: Question  = questions.remove(at: randomIndex)
            randQuest.append(temp)
        }
        return randQuest
    }
    
    class func getCustomers() -> [Company]{
        var company: [Company] = []
        
        let list : [[String: Any]] = [
            // 5 Public Companies
            
            ["name" : "Coupa", "logo" : #imageLiteral(resourceName: "coupa"), "question": getRandVerbalQuestion(), "numEmploy": 1000, "numAcq": 7,
             "isPub": true, "wentPublic" : "Oct 6, 2016", "founder" : ["Noah Eisner, Dave Stephens"],
             "desc": "Coupa is the cloud platform for business spend. It offers a fully unified suite of financial applications for business spend management.",
             "class" : "Public", "url" : "www.coupa.com"] ,
            
            ["name" : "Uber", "logo" : #imageLiteral(resourceName: "uber"), "question": getRandChoicequestions(), "numEmploy": 10000, "numAcq": 3,
             "isPub": false, "wentPublic" : "", "founder" : ["Garrett Camp, Oscar Salazar, Travis Kalanick"],
             "desc": "Uber is a mobile app connecting passengers with drivers for hire.",
             "class" : "Series G", "url" : "http://www.uber.com"] ,
            
            ["name" : "Google", "logo" : #imageLiteral(resourceName: "google"), "question": getRandVerbalQuestion(), "numEmploy": 10000, "numAcq": 0,
             "isPub": true, "wentPublic" : "August 19, 2004", "founder" : ["Larry Page, Sergey Brin"],
             "desc": "Google is a multinational corporation that is specialized in internet-related services and products.",
             "class" : "Public", "url" : "http://www.google.com/"] ,
            
            
            ["name" : "Twitter", "logo" : #imageLiteral(resourceName: "twitter"), "question": getRandChoicequestions(), "numEmploy": 5000, "numAcq": 50,
             "isPub": true, "wentPublic" : "Nov 7, 2013", "founder" : ["Noah Glass, Jack Dorsey, Ev Williams, Biz Stone"],
             "desc": "Twitter.",
             "class" : "Public", "url" : "http://www.twitter.com/"] ,
            
            ["name" : "Microsoft", "logo" : #imageLiteral(resourceName: "microsoft"), "question": getRandVerbalQuestion(), "numEmploy": 10000, "numAcq": 193,
             "isPub": true, "wentPublic" : "Mar 13, 1986", "founder" : ["Bill Gates, Paul Allen"],
             "desc": "Microsoft, a software corporation that develops, manufactures, licenses, supports, and sells a range of software products and services.",
             "class" : "Public", "url" : "http://www.microsoft.com/"] ,
            
            // 5 series A companies
            
            ["name" : "Metamaterial Technologies", "logo" : #imageLiteral(resourceName: "MTI-Logo"), "question": getRandChoicequestions(), "numEmploy": 50, "numAcq": 1,
             "isPub": false, "wentPublic" : "", "founder" : ["Themos Kallos, George Palikaras"],
             "desc": "Mastering Light using Smart Materials & Photonics. Changing the way we use, interact and benefit from Light.",
             "class" : "Series A", "url" : "http://www.metamaterial.com"] ,
            
            ["name" : "FarmLead", "logo" : #imageLiteral(resourceName: "FarmLead-Logo"), "question": getRandVerbalQuestion(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Alain Goubau, Brennan Turner"],
             "desc": "FarmLead is an North America's grain marketplace. Changing the way farmers sell grain.",
             "class" : "Series A", "url" : "http://www.FarmLead.com"] ,
            
            ["name" : "LVH(55 Capital)", "logo" : #imageLiteral(resourceName: "55-capital-Logo"), "question": getRandChoicequestions(), "numEmploy": 40, "numAcq": 4,
             "isPub": false, "wentPublic" : "", "founder" : ["To be Determined"],
             "desc": "LVH democratizes portfolio management and enables investors and advisors to unleash the full potential of Exchange Traded Funds (ETFs).",
             "class" : "Series A", "url" : "http://www.55capitalpartners.com/"] ,
            
            ["name" : "The Yield", "logo" : #imageLiteral(resourceName: "theYield"), "question": getRandVerbalQuestion(), "numEmploy": 30, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Ros Harvey"],
             "desc": "The Yield is an Internet of Things (IoT) AgTech (Agricultural Technology) start-up.",
             "class" : "Series A", "url" : "www.coupa.com"] ,
            
            ["name": "AdAsia Holdings Pte. Ltd.", "logo" : #imageLiteral(resourceName: "AdAsia"), "question": getRandChoicequestions(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Kosuke Sogo, Otohiko Kozutsumi"],
             "desc": "AdAsia Holdings provides next-generation solutions for advertisers and marketers, accessible through a single platform.",
             "class" : "Series A", "url" : "http://www.adasiaholdings.com/"] ,
            
            // 5 series B companies
            
            ["name" : "CrunchBase", "logo" : #imageLiteral(resourceName: "CrunchBase"), "question": getRandVerbalQuestion(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Michael Arrington"],
             "desc": "Crunchbase allows users to discover innovative companies and the people behind them.",
             "class" : "Series B", "url" : "https://www.crunchbase.com"] ,
            
            ["name" : "Upskill", "logo" : #imageLiteral(resourceName: "upskill"), "question": getRandChoicequestions(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Jeffrey Jenkins, Chris Hoyt, Brian Ballard, Sean Lane, Craig Cummings"],
             "desc": "Upskill provides wearable technology to connect hands-on workers from the factory to the warehouse to the jobsite.",
             "class" : "Series B", "url" : "https://upskill.io/"] ,
            
            ["name" : "WayRay", "logo" : #imageLiteral(resourceName: "Wayray"), "question": getRandVerbalQuestion(), "numEmploy": 250, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Vitaly Ponomarev"],
             "desc": "WayRay develops AR technologies for vehicles of the future.",
             "class" : "Series B", "url" : "https://wayray.com/"] ,
            
            ["name" : "GoTenna", "logo" : #imageLiteral(resourceName: "gotenna"), "question": getRandChoicequestions(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Jorge Perdomo, Daniela Perdomo, Jorge Perdomo"],
             "desc": "GoTenna is a new device that pairs with your smartphone and lets you communicate with others even when you don't have service.",
             "class" : "Series B", "url" : "http://www.gotenna.com"] ,
            
            ["name" : "Peloton Technology", "logo" : #imageLiteral(resourceName: "Peloton"), "question": getRandVerbalQuestion(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Chris Gerdes, Josh Switkes, Steve Boyd, Dave Lyons"],
             "desc": "Peloton is a connected and automated vehicle technology company improving safety and efficiency in the trucking industry.",
             "class" : "Series B", "url" : "http://www.peloton-tech.com"] ,
            
            ["name" : "MapD", "logo" : #imageLiteral(resourceName: "MapD"), "question": getRandChoicequestions(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Thomas Graham, Todd Mostak"],
             "desc": "The fastest big data exploration platform",
             "class" : "Series B", "url" : "http://mapd.com"] ,
            
            // 5 series C companies
            
            ["name" : "Antiva Biosciences", "logo" : #imageLiteral(resourceName: "Antiva"), "question": getRandVerbalQuestion(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Karl Hostetler"],
             "desc": "A biopharmaceutical company developing novel, localized therapeutics for the treatment of diseases caused by HPV infection.",
             "class" : "Series C", "url" : "http://www.antivabio.com"] ,
            
            ["name" : "Qumulo", "logo" : #imageLiteral(resourceName: "Qumulo"), "question": getRandChoicequestions(), "numEmploy": 250, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Peter Godman, Neal Fachan, Aaron Passey"],
             "desc": "Qumulo is a startup company developing simple, scalable, and efficient enterprise data storage systems.",
             "class" : "Series C", "url" : "http://qumulo.com"] ,

            
            ["name" : "Cohesity", "logo" : #imageLiteral(resourceName: "Cohesity"), "question": getRandVerbalQuestion(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["Mohit Aron"],
             "desc": "Cohesity delivers the industry’s first hyperconverged secondary storage for backup, test/dev, file services, and analytic datasets.",
             "class" : "Series C", "url" : "http://www.cohesity.com/"] ,

            
            ["name" : "Amino", "logo" : #imageLiteral(resourceName: "amino"), "question": getRandChoicequestions(), "numEmploy": 50, "numAcq": 0,
             "isPub": false, "wentPublic" : "", "founder" : ["David Vivero, Roger Billerey-Mosier, Sumul Shah, Maudie Shah"],
             "desc": "Amino is a healthcare transparency company that helps people find care, estimate costs, and book appointments - for free.",
             "class" : "Series C", "url" : "https://amino.com/"] ,

        ]
        
        
        for comp in list{
            company.append(Company(hash: comp))
        }
        
        return company
    }
}
