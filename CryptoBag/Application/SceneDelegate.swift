import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        let loginViewModel = LoginViewModel()
//        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
        
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(mainViewModel: mainViewModel)
        
        var navigationController: UINavigationController!
        
//        let loggedIn = loginViewModel.isUserLoggedIn()
        
        let regVM = RegistrationViewModel()
        let regVC = RegistrationViewController(registrationViewModel: regVM)
        
        
        
        //        if !loggedIn {
        //            navigationController = UINavigationController(rootViewController: loginViewController)
        //        } else {
        //            navigationController = UINavigationController(rootViewController: mainViewController)
        //        }
        navigationController = UINavigationController(rootViewController: regVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
