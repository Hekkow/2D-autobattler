extends Node

var projectile = load("res://Projectile.tscn")
var enemy_projectile = load("res://Enemies/EnemyProjectile.tscn")
var aoe = load("res://AOE.tscn")
var enemy = load("res://Enemies/Enemy.tscn")
var game
var projectiles
var player = load("res://Player.tscn")
var block = load("res://Blocks/Block.tscn")
var drag_and_drop = load("res://DragAndDropPanel.tscn")
var inventory_block = load("res://Blocks/InventoryBlock.tscn")
var ui = load("res://UI.tscn")
var ui_node
var spawn_indicator = load("res://SpawnIndicator.tscn")
var orbiter = load("res://Orbiter.tscn")
var theme = load("res://Theme.tres")
var shop_item = load("res://ShopItem.tscn")
var game_over = load("res://GameWonScreen.tscn")
var lost_game = load("res://LostGameScreen.tscn")

