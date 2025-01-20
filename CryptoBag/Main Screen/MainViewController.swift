import UIKit


final class MainViewController: UIViewController {
    
    private var mainViewModel: MainViewModelProtocol
    
    init(mainViewModel: MainViewModelProtocol) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
