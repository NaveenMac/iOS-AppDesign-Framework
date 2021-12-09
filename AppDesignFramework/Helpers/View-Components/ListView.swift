//
//  ListView.swift
//  UserNominees
//
//  Created by Naveen Chauhan on 03/12/21.
//

import UIKit

class ListView: UIViewController {
    var allConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var doneAction:((_ text:String)->Void)?
    var cancelAction:(()->Void)?
   
    var fileName:String?
    var showSearch:Bool = false
    lazy var listTable:SelfSizedTableView = {
        let tv = SelfSizedTableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        tv.separatorStyle = .singleLine
        tv.contentInsetAdjustmentBehavior = .never
        tv.register(DefaultCell.self, forCellReuseIdentifier:"ListCell")
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    //var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height:   500))
    var tableData:[String]?
    var filteredData:[String]?
    var searchBar: UISearchBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filteredData = tableData
       
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(closePopup))
//        self.view.addGestureRecognizer(gesture)
       
        setUpView()
       // setTableHeader()
        
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
    
   @objc func closePopup(){
    if let action = cancelAction {
        self.view.gestureRecognizers?.removeAll()
        action()
       
    }
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
            "leftMargin": 12,
            "rightMargin": 32,
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
    
    func setTableHeader()->UIView{
        
        let col = UIView.VStack(spacing: 8,alignment: .fill, distribution: .fill)
        col.translatesAutoresizingMaskIntoConstraints = false
        
        
        let row = UIView.HStack(spacing: 0,alignment: .fill, distribution: .fill)
        row.translatesAutoresizingMaskIntoConstraints = false
        row.isLayoutMarginsRelativeArrangement = true
        row.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 38, leading: 22, bottom: 0, trailing: 25)
        row.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        let label = UILabel()
        
        
        let button = Button(type: .custom, attributes: { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 60).isActive = true
            button.setImage(UIImage(named: "nominee_search"), for: .normal)
        }, action: { button in
            self.showSearch = self.showSearch ? false : true
            DispatchQueue.main.async {
               // self.listTable.performBatchUpdates(nil, completion: nil)
                self.listTable.reloadData()
            }
            
        })
       
        button.isHidden = showSearch
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Relationship"
        label.font = UIFont(name: "OpenSans-Bold", size: 16)
        label.textColor = UIColor(hex: "#474747FF")
        row.addArrangedSubview(label)
        
        
        
        row.addArrangedSubview(button)
        col.addArrangedSubview(row)
        
        let row1 = UIView.VStack(spacing: 0, alignment: .fill, distribution: .fill)
        row1.translatesAutoresizingMaskIntoConstraints = false
       
        searchBar = UISearchBar()
        
        searchBar?.delegate = self
        
        searchBar?.isHidden = !showSearch
       searchBar?.translatesAutoresizingMaskIntoConstraints = false
        searchBar?.heightAnchor.constraint(equalToConstant: 52).isActive = true
        searchBar?.layer.cornerRadius = 26
        searchBar?.layer.masksToBounds = true
        searchBar?.barTintColor = UIColor.white
        searchBar?.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        row1.addArrangedSubview(searchBar!)
        
        col.addArrangedSubview(row1)
        return col
//        self.listTable.beginUpdates()
//        self.listTable.setNeedsLayout()
//            self.listTable.endUpdates()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if touch?.view == self.listTable {
            print("inside table")
        }else{
            cancelAction?()
        }
    }
}



extension ListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if let action = doneAction,let relation = self.tableData?[indexPath.row] {
            self.view.gestureRecognizers?.removeAll()
            action(relation)
        }
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = setTableHeader()
        return headerView
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
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? DefaultCell else { return UITableViewCell()}
        
        let item = filteredData?[indexPath.row]
        cell.textLabel?.text = item ?? ""
        return cell
    }
    
    
}

extension ListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            if text.count == 0 {
                self.filteredData = self.tableData
            }else{
                self.filteredData =  self.filteredData?.filter{ $0.lowercased().contains(text.lowercased())}
            }
            
            
        }
        self.listTable.reloadData()
       
    }
}


class DefaultCell: UITableViewCell {
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//
    override func layoutSubviews() {
        super.layoutSubviews()

      //  contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

