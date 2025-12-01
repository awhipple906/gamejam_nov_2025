extends Node
var playerMaxHealth = 100
var playerCurrentHealth = 5
var playerMeleeDamage = 5.0
var playerCoolDown = 5.0
var playerMoveSpeed = 14
var chits = 0
var damagecost = 50
var movespeedcost = 50
var healthcost = 50
var attackspeedcost = 50
signal getchits()
signal losechits()
signal chitchange()