//
//  StoryboardScene.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//
import UIKit
import SwinjectStoryboard

protocol StoryboardScene: AnyObject {
    
    static var sceneStoryboard: UIStoryboard { get }
    static var sceneIdentifier: String { get }
}

extension StoryboardScene {
    static var sceneIdentifier: String {
        return String(describing: self)
    }
    
    static var sceneStoryboard: UIStoryboard {
        let id = String(describing: self)
        let storyboard = SwinjectStoryboard.create(name: id.replacingOccurrences(of: "Controller", with: ""), bundle: nil, container: SwinjectStoryboard.defaultContainer)
        return storyboard
    }
}

extension StoryboardScene where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = Self.sceneStoryboard
        let viewController = storyboard.instantiateInitialViewController()
        guard let conformingViewController = viewController as? Self else {
            fatalError("View Controller Is Not Of Type or Class '\(self)'.")
        }
        return conformingViewController
    }
    
}


