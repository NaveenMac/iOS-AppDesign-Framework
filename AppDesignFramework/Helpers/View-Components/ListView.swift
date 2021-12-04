//
//  ListView.swift
//  UserNominees
//
//  Created by Naveen Chauhan on 03/12/21.
//

import UIKit

class ListView: UIViewController {
    var allConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
   
    var fileName:String?
    var showSearch:Bool = false {
        didSet{
            setTableHeader()
        }
        
    }
    lazy var listTable:SelfSizedTableView = {
        let tv = SelfSizedTableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        tv.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        tv.separatorStyle = .singleLine
        tv.contentInsetAdjustmentBehavior = .never
        tv.register(UITableViewCell.self, forCellReuseIdentifier:"ListCell")
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    //var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height:   500))
    var tableData:[String]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        
       
        setUpView()
        showSearch = false
    }
    
    func setUpView(){
       
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.backgroundColor = .white
        wrapper.addSubview(listTable)
        self.view.addSubview(wrapper)
        listTable.backgroundColor = .white
        
        
        let views = [ "table": listTable, "wrapper":wrapper ]


        addConstraints(views: views)
        
        animateView(view: wrapper)
      
        
    }
    func animateView(view:UIView){
        
        view.transform = CGAffineTransform(translationX: 0, y: 500)
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.5, options: [], animations: {
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: {_ in
            view.roundCorners(corners: [.topLeft,.topRight], radius: 20)
            })
    }
    func addConstraints(views:[String:UIView]){
        let metrics = [
            "leftMargin": 0,
            "rightMargin": 0,
            "topMargin":283,
            "bottomMargin":0
        ]
        
       
        
        let wrapperViewHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[wrapper]|", options: [], metrics: metrics, views: views)
        allConstraints += wrapperViewHorizontal

        let wrapperViewVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(topMargin)-[wrapper]|", options:.alignAllCenterY, metrics: metrics, views: views)
        allConstraints += wrapperViewVertical
        
        let tableViewHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[table]-rightMargin-|", options: [], metrics: metrics, views: views)
        allConstraints += tableViewHorizontal

        let tableViewViewVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[table]|", options:.alignAllCenterY, metrics: metrics, views: views)
        allConstraints += tableViewViewVertical



        NSLayoutConstraint.activate(allConstraints)
    }
    
    func setTableHeader(){
        
        let col = UIView.VStack(spacing: 8, distribution: .fill)
        col.translatesAutoresizingMaskIntoConstraints = false
        
        
        let row = UIView.HStack(spacing: 0,alignment: .fill, distribution: .fill)
        row.translatesAutoresizingMaskIntoConstraints = false
        row.isLayoutMarginsRelativeArrangement = true
        row.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 16, bottom: 32, trailing: 0)
        row.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        let label = UILabel()
        
        
        let button = Button(type: .custom, attributes: { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 60).isActive = true
            button.setImage(UIImage(named: "nominee_search"), for: .normal)
        }, action: { button in
            //self.showSearch = true
        })
       
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Relationship"
        row.addArrangedSubview(label)
        
        
        
        row.addArrangedSubview(button)
        col.addArrangedSubview(row)
        
        let row1 = UIView.VStack(spacing: 0, distribution: .fillProportionally)
        row1.translatesAutoresizingMaskIntoConstraints = false
        
        if showSearch {
            let searchBar = UITextField()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            row1.addArrangedSubview(searchBar)
            
            col.addArrangedSubview(row1)
        }
        
        
        self.listTable.tableHeaderView = col
//        self.listTable.beginUpdates()
//        self.listTable.setNeedsLayout()
//            self.listTable.endUpdates()
    }
}



extension ListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.size.width, height: 60)))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}


extension ListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        let item = tableData?[indexPath.row]
        cell.textLabel?.text = item ?? ""
        return cell
    }
    
    
}
