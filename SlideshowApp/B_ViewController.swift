
import UIKit

class B_ViewController: UIViewController {
    
    @IBOutlet weak var enlargedImage: UIImageView!//UIImageViewを接続
    var selectedImage: UIImage!//遷移元から受け取るための変数を宣言して用意しておく
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enlargedImage.image = selectedImage
    }

}
