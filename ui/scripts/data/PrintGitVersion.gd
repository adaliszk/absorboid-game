extends Label

const GIT = preload("res://git_version.gd")


func _ready():
	self.text = "%s" % GIT.HASH
