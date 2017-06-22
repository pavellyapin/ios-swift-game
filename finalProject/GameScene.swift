//
//  GameScene.swift
//  finalProject
//
//  Created by Pavel on 2016-04-03.
//  Copyright © 2016 cs2680. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    
    static let Enemy : UInt32 = 1
    static let Bullet : UInt32 = 2
    static let Person : UInt32 = 3
    
}


class GameScene: SKScene, SKPhysicsContactDelegate
{

    
    var Player = SKSpriteNode(imageNamed: "PlayerGalaga")
    
    var gameLevel : Int = 0

    
    override func didMoveToView(view: SKView)
    {
        
        
        physicsWorld.contactDelegate = self
        
        Player.position = CGPointMake(self.size.width / 2, self.size.height / 6)
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.categoryBitMask = PhysicsCategory.Person
        Player.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        Player.physicsBody?.dynamic = false
        
        if(gameLevel == 0)
        {
            var Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
            var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
            
        }
        else if(gameLevel == 1)
        {
            var Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
            var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
            
        }
        else{
            
            var Timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
            var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
            
            
        }
        
        
        
        
        
        self.addChild(Player)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        if let enemyNode = getNodeFromContact(contact, categoryBitMask: PhysicsCategory.Enemy) {
            NSLog("Planet hit")
            if let physicsBody = enemyNode.physicsBody {
                physicsBody.contactTestBitMask = 0
            }
            enemyNode.physicsBody = nil
            enemyNode.runAction(SKAction.fadeOutWithDuration(0.1))
            
            if let shipNode = getNodeFromContact(contact, categoryBitMask: PhysicsCategory.Bullet) {
                //NSLog("Ship hit")
                //shipNode.runAction(actionBlink())
            }
        }
    }
    
    func getNodeFromContact(contact: SKPhysicsContact, categoryBitMask: UInt32) -> SKNode? {
        if (contact.bodyA.categoryBitMask & categoryBitMask) > 0 {
            return contact.bodyA.node;
        } else if (contact.bodyB.categoryBitMask & categoryBitMask) > 0 {
            return contact.bodyB.node;
        }
        return nil
    }
    
    
    func SpawnBullets(){
        let Bullet = SKSpriteNode(imageNamed: "BulletGalaga")
        Bullet.zPosition = -5
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        
        let action = SKAction.moveToY(self.size.height + 30, duration: 0.5)
        let actionDone =  SKAction.removeFromParent()
        Bullet.runAction(SKAction.sequence([action , actionDone]))
        
        
        Bullet.physicsBody = SKPhysicsBody(rectangleOfSize: Bullet.size)
        Bullet.physicsBody?.affectedByGravity = false
        Bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        Bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        Bullet.physicsBody?.dynamic = false
        
        self.addChild(Bullet)
    }
    
    func SpawnEnemies(){
        let Enemy = SKSpriteNode(imageNamed: "EnemyGalaga")
        let MinValue = self.size.width / 8
        let MaxValue = self.size.width - 20
        let SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        
        
                
        Enemy.physicsBody = SKPhysicsBody(rectangleOfSize: Enemy.size)
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        Enemy.physicsBody?.dynamic = true
        
        let action = SKAction.moveToY(-70, duration: 2.0)
        let actionDone =  SKAction.removeFromParent()
        Enemy.runAction(SKAction.sequence([action , actionDone]))
        

        
        self.addChild(Enemy)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        
        

            if let touch = touches.first
            {
                let location = touch.locationInNode(self)
                
                Player.position.x = location.x

            }
        
    }
    
    

}
