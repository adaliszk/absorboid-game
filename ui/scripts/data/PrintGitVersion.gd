extends Label


func _ready():
	if Git.Build != null:
		self.text = "Build#%s" % Git.Build
		return

	self.text = "%s #%s" % [Git.Branch, Git.Commit]
