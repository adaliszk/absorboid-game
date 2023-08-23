extends RichTextLabel

func _ready():
	if OS.get_name() != "HTML5":
		meta_clicked.connect(func(meta): OS.shell_open(meta))
