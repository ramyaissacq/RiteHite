

import UIKit
import SwiftEntryKit

class SuccessfullDialog: BaseViewController {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var messageString = ""
    var titleString = ""
    var buttonLabel = ""
    
    var confirmationButtonClicked:(()->Void)?
    var tapped:(()->Void)?
    var closed:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel.text = messageString
        titleLabel.text = titleString
        okButton.setTitle(buttonLabel, for: .normal)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnView))
        backView.addGestureRecognizer(tap)
    }
    
    @objc func tappedOnView(){
//         tapped?()
//         SwiftEntryKit.dismiss()
     }
    
    static func instance()-> SuccessfullDialog
    {
        let storyboard = UIStoryboard.init(name: "Dialogs", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SuccessfullDialog") as! SuccessfullDialog
        return vc
    }
    
    @IBAction func actionClose(_ sender: Any) {
        SwiftEntryKit.dismiss()
        closed?()
    }
    

    @IBAction func okButtonClicked(_ sender: Any) {
        SwiftEntryKit.dismiss()
        confirmationButtonClicked?()
    }
    
}
