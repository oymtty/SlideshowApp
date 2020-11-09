
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!//UIImageViewを接続
    @IBOutlet weak var startButton: UIButton!//再生ボタンを接続
    @IBOutlet weak var nextButton: UIButton!//進むボタンを接続
    @IBOutlet weak var backButton: UIButton!//戻るボタンを接続
    
    var timer: Timer!//タイマーを宣言
    var displayImageNo = 0//表示するImageの番号を変数として宣言
    let imageArray:[UIImage] = [//スライドショーさせる画像配列を宣言
        UIImage(named:"image_A")!,UIImage(named:"image_B")!,UIImage(named:"image_C")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "image_A")//定数imageを宣言し、引数としてimage_Aを選択
        imageView.image = image//変数iamgeViewのプロパティを、値"image"にする
    }
//-------------------------------------------------------------------------------------
//再生ボタンを押した時の処理
    @IBAction func startSlideshow(_ sender: Any) {
        if self.timer == nil {//再生するとき
            self.timer = Timer.scheduledTimer(timeInterval:2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)//タイマーをセットする
            startButton.setTitle("停止", for: .normal)//ボタンの名前を"停止"に変える
            nextButton.isEnabled = false//進むボタンを非有効にする
            backButton.isEnabled = false//戻るボタンを非有効にする
            
        } else {//停止するとき
            timer.invalidate()//タイマーを停止する
            timer = nil//タイマーを削除
            startButton.setTitle("再生", for: .normal)//ボタンの名前を"再生"にする
            nextButton.isEnabled = true//進むボタンを有効にする
            backButton.isEnabled = true//戻るボタンを有効にする
        }
    }
 //画像を切替える処理
    @objc func changeImage() {
        displayImageNo += 1//変数である"Image番号"を増やす（画像を切り替える）
        if (displayImageNo == imageArray.count){//Image番号が表示予定の画像の数と同じ場合
            displayImageNo = 0//Image番号を一番最初の数字に戻す
        }
        imageView.image = imageArray[displayImageNo]//変数iamgeViewのプロパティを、値"画像配列"にする
    }
//進むボタンを押した時の処理
    @IBAction func nextSlideshow(_ sender: Any) {
        if displayImageNo == 2 {//Imageが一番最後である"2"の時
            displayImageNo = 0//Image番号を一番最初の"0"に戻す
        } else {//それ以外の時
            displayImageNo += 1//Image番号を+1する
        }
        imageView.image = imageArray[displayImageNo]
    }
//戻るボタンを押した時の処理
    @IBAction func backSlideshow(_ sender: Any) {
        if displayImageNo == 0 {//Imageが一番最初である"0"の時
            displayImageNo = 2//Image番号を一番最後の"2"にする
        } else {//それ以外の時
            displayImageNo -= 1//Image番号を-1する
        }
        imageView.image = imageArray[displayImageNo]
    }
//imageViewをタップした時の処理（User Interaction Enabledをonにしておく）
    @IBAction func tapAction(_ sender: Any) {//Tap Gesture Recognizerを被せると、ImageViewにActionをつけられる
        performSegue(withIdentifier: "toB_ViewController",sender: nil)//segueを呼び出す
        if self.timer != nil {//自動送りしている（timer != nil）場合に限った処理
                timer.invalidate()//タイマーを停止する
                timer = nil//タイマーを削除
                startButton.setTitle("再生", for: .normal)//ボタンの名前を"再生"にする
                nextButton.isEnabled = true//進むボタンを有効にする
                backButton.isEnabled = true//戻るボタンを有効にする
        }
    }
//遷移先に値を受け渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toB_ViewController" {//遷移先がtoB_ViewControllerである時
            let b_ViewController = (segue.destination as! B_ViewController)
            b_ViewController.selectedImage = imageArray[displayImageNo]
        }
    }
//B_ViewControllerから戻るsegue
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}
