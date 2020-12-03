//
//  MyGamesExt.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/9/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


extension MyGamesViewController {

    
    @objc func gamesegmentValueChanged(_ sender: AnyObject?){
        
        
        print("games segment value changed")
        
        print("gameSegment.selectedIndex: \(gameSegment.selectedIndex)")
        
        if gameSegment.selectedIndex == 0 {
            self.actInd.isHidden = false
            self.actInd.startAnimating()
             self.title = "Games"
            
            self.RemoveGameArrayData()
            print("Mygames")
            //segmentControl.items = ["My Turns", "All", "Completed"]
            self.TableView.reloadData()
            
            if pickerIsAllGames {
                pickerIsAllGames = false
                UIView.animate(withDuration: 1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y + 40
                    self.TableView.center.y = self.TableView.center.y + 40
                    self.segmentControlTOP.constant = 0
                })
                
                pickerItem = false
                refreshMyGames()
                
                
            }
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })

            
            //filterContentForSearchText("", scope: "All")
            
        } else if gameSegment.selectedIndex == 1 {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            
            self.RemoveGameArrayData()
            self.SegmentValueString = "All"
            self.title = "Games"
            self.TableView.reloadData()
            
            if !pickerIsAllGames {
                pickerIsAllGames = true
                UIView.animate(withDuration: 1.0, animations: {
                    self.segmentControl.center.y = self.segmentControl.center.y - 40
                    self.TableView.center.y = self.TableView.center.y - 40
                    self.segmentControlTOP.constant = -40
                })
                
            }
            
            print("all games")
            
            pickerItem = true
            refreshPublicGames()
            
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
            
        }
    }
    
 @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            self.SegmentValueString = "All"
            self.OnlyInProcess = true
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            
           
            
          //  dispatch_async(dispatch_get_main_queue(), {
                if !self.pickerItem {
                    self.refreshMyGames()
                } else {
                    self.refreshPublicGames()
                }
           // })
            //salesValue.text = "$23,399"
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
 
            //filterContentForSearchText("", scope: "All")
            
        } else if segmentControl.selectedIndex == 1{
            
            self.OnlyInProcess = false
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            self.SegmentValueString = "My Turns"
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            

            
         //   dispatch_async(dispatch_get_main_queue(), {
                if !self.pickerItem {
                    self.refreshMyGames()
                } else {
                    self.refreshPublicGames()
                }
          //  })
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
            //filterContentForSearchText("", scope: "Complete")
            //salesValue.text = "$81,295"
        } else {
            self.OnlyInProcess = false
            self.actInd.isHidden = false
            self.actInd.startAnimating()
            
            self.SegmentValueString = "Completed"
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            
            //actInd.hidden = false
           

            
         //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
                self.refreshMyGames()
            } else {
                self.refreshPublicGames()
            }
            
            DispatchQueue.main.async(execute: {
                self.actInd.isHidden = true
                self.actInd.stopAnimating()
            })
         //   })
           // filterContentForSearchText("", scope: "In Process")
            //salesValue.text = "$199,392"
        }
    }

    
    
    
    
    
    func refreshPublicGames() {
        self.RemoveGameArrayData()
        
        DispatchQueue.main.async(execute: {
            self.DeletedGameIDs.removeAll()
            self.GetDeletedGamesData()
            print("Retrieved All hidden Games: \(self.DeletedGameIDs)")
            
            
            
            self.NumTurnsLoaded = 0
            
            if Reachability.isConnectedToNetwork() {
                
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        //  let URLData = GetUserGameDataPublic(self.username, userID: self.userID, gameSetting: "public")
                        
                        let URLData = GetUserGameDataPublic(self.username, userID: self.userID, gameSetting: "public", StartNum: self.NumTurnsLoaded, EndNum: (self.NumTurnsLoaded
                            + 50), type: self.SegmentValueString)
                        
                        self.NumTurnsLoaded = self.NumTurnsLoaded + 50
                        
                        DispatchQueue.main.async(execute: {
                            (self.GameInfo, self.GameSearchArray) = self.FilterGameData(URLData)
                            
                            //})
                            
                            print("Game Search Info Count = \(self.GameSearchArray.count)")
                            
                            if self.GameSearchInfo.count < 1 {
                                self.NoGamesLBL.isHidden = false
                                self.restartMyGames.isHidden = false
                                
                                print("showing no games label")
                            } else {
                                
                                print("hidding no games label")
                                self.NoGamesLBL.isHidden = true
                                self.restartMyGames.isHidden = true
                            }
                            
                            DispatchQueue.main.async(execute: {
                                
                                self.AddGameArrayInfo(self.GameInfo)
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    if (self.refreshControl!.isRefreshing) {
                                        self.refreshControl!.endRefreshing()
                                        print("Users turn info =\(self.GameNameInfo)")
                                        
                                        self.TableView.reloadData()
                                        self.actInd.stopAnimating()
                                        self.actInd.isHidden = true
                                        print("reloading TableView at the End")
                                        print("Users turn info =\(self.GameNameInfo)")
                                        
                                    }
                                })
                                
                            })
                            
                            
                            print("REFRESHING TABLE TEST 1 PULLED")
                            
                        })
                        print("Users turn info =\(self.UsersTurnInfo)")
                        print("Users turn ID info =\(self.UsersTurnIDInfo)")
                        print("REFRESHING TABLE, REFRESH WAS PULLED")
                        // self.TableView.reloadData()
                        
                    })
                    
                } else {
                    
                    print("no games available")
                    
                }
                
                
            }
                
            else
                
            {
         
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
            
            
            /*
            dispatch_async(dispatch_get_main_queue(), {
            
            if (self.refreshControl!.refreshing) {
            self.refreshControl!.endRefreshing()
            
            self.TableView.reloadData()
            print("reloading TableView at the End")
            }
            */
            
            
            // Masquer l'icône de chargement dans la barre de status
            // UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            // })
        })
    }
    
    
    func refreshMyGames() {
        self.RemoveGameArrayData()
        
        DispatchQueue.main.async(execute: {
            self.DeletedGameIDs.removeAll()
            self.GetDeletedGamesData()
            print("Retrieved All hidden Games: \(self.DeletedGameIDs)")
            
            
            if Reachability.isConnectedToNetwork() {
                
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        let URLData = GetUserGameData(self.username, userID: self.userID, type: self.SegmentValueString)
                        
                        DispatchQueue.main.async(execute: {
                            (self.GameInfo, self.GameSearchArray) = self.FilterGameData(URLData)
                            
                            //})
                            
                            print("Game Search Info Count = \(self.GameSearchArray.count)")
                            
                            if self.GameSearchInfo.count < 1 {
                                self.NoGamesLBL.isHidden = false
                                self.restartMyGames.isHidden = false
                                
                                print("showing no games label")
                            } else {
                                
                                print("hidding no games label")
                                self.NoGamesLBL.isHidden = true
                                self.restartMyGames.isHidden = true
                            }
                            
                            DispatchQueue.main.async(execute: {
                                
                                self.AddGameArrayInfo(self.GameInfo)
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    if (self.refreshControl!.isRefreshing) {
                                        self.refreshControl!.endRefreshing()
                                        print("Users turn info =\(self.GameNameInfo)")
                                        
                                        self.TableView.reloadData()
                                        self.actInd.stopAnimating()
                                        self.actInd.isHidden = true
                                        print("reloading TableView at the End")
                                        print("Users turn info =\(self.GameNameInfo)")
                                        
                                    }
                                })
                                
                            })
                            
                            
                            print("REFRESHING TABLE TEST 1 PULLED")
                            
                        })
                        print("Users turn info =\(self.UsersTurnInfo)")
                        print("Users turn ID info =\(self.UsersTurnIDInfo)")
                        print("REFRESHING TABLE, REFRESH WAS PULLED")
                        // self.TableView.reloadData()
                        
                    })
                    
                } else {
                    
                    print("no games available and username = nil")
                    
                }
                
                
            }
                
            else
                
            {
          
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
            
        })
    }
    
    func refreshMyGamesMyTurns() {
        self.RemoveGameArrayData()
        
        DispatchQueue.main.async(execute: {
            self.DeletedGameIDs.removeAll()
            self.GetDeletedGamesData()
            print("Retrieved All hidden Games: \(self.DeletedGameIDs)")
            
            
            if Reachability.isConnectedToNetwork() {
                
                
                if self.prefs.value(forKey: "USERNAME") != nil {
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        let URLData = GetUserGameData(self.username, userID: self.userID, type: self.SegmentValueString)
                        
                        DispatchQueue.main.async(execute: {
                            (self.GameInfo, self.GameSearchArray) = self.FilterGameData(URLData)
                            
                            //})
                            
                            print("Game Search Info Count = \(self.GameSearchArray.count)")
                            
                            if self.GameSearchInfo.count < 1 {
                                self.NoGamesLBL.isHidden = false
                                self.restartMyGames.isHidden = false
                                
                                print("showing no games label")
                            } else {
                                
                                print("hidding no games label")
                                self.NoGamesLBL.isHidden = true
                                self.restartMyGames.isHidden = true
                            }
                            
                            DispatchQueue.main.async(execute: {
                                
                                self.AddGameArrayInfo(self.GameInfo)
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    if (self.refreshControl!.isRefreshing) {
                                        self.refreshControl!.endRefreshing()
                                        print("Users turn info =\(self.GameNameInfo)")
                                        
                                        self.TableView.reloadData()
                                        print("reloading TableView at the End")
                                        print("Users turn info =\(self.GameNameInfo)")
                                        
                                    }
                                })
                                
                            })
                            
                            
                            print("REFRESHING TABLE TEST 1 PULLED")
                            
                        })
                        print("Users turn info =\(self.UsersTurnInfo)")
                        print("Users turn ID info =\(self.UsersTurnIDInfo)")
                        print("REFRESHING TABLE, REFRESH WAS PULLED")
                        // self.TableView.reloadData()
                        
                    })
                    
                } else {
                    
                    print("no games available")
                    
                }
                
                
            }
                
            else
                
            {
                
                SCLAlertView().showCustomOK(UIImage(named: "SadPixie.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Network Error", subTitle: "Please Confirm Your Network Settings", duration: nil, completeText: "Ok", style: .custom, colorStyle: 1, colorTextButton: 1)
                
            }
            
        })
    }

}
