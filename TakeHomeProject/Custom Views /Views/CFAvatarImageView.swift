//
//  CFAvatarImageView.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 28.08.2024.
//

import UIKit

class CFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")
    let chace = NetworkManager.shared.chace

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func downloadImage(from urlString: String){
        
        let chaceKey = NSString(string: urlString)
        
        if let image = chace.object(forKey: chaceKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {return}
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {return}
            

            guard let image = UIImage(data: data) else {return}
            
            self.chace.setObject(image, forKey: chaceKey)
            
            DispatchQueue.main.async{
                self.image = image
            }
        } 
        task.resume()
    }
}
