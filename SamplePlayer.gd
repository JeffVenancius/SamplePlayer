extends Node
class_name SamplePlayer

"""
---- README ----

Functions:
	start_song(song: String)
		calls a song in the songs Dictionary and then plays it.
	play_song()
		play the song stored in the title Dictionary.
	stop_song()
		stop the song stored in the title Dictionary.
	pause_song()
		pauses (which means, at position) the song stored in the title Dictionary.

P.S: As the 'func _on_pattern_finished()' allways needs a sample to be triggered and this sample is the first index on the pattern array,
you should create a sample of total silence so you can store the timing in it and then write it instead of 0 (I'm using -1 as an example').
Probably not the right way to do it, but it's the way it works - a timer mess things up.

As for the song I'm using in this example, it's mine and I'm using it on my game, 
but you can do whatever you want with this one.

Is it worth it?
original file of this song takes 2.0 MB
With samples I was able to reduce to 326.7 KB
That's like 17% of the original + you can do a lot more with it.

"""


var songs := {
		"title_screen": {
			"path": "res://title_screen/",
			"extension": ".ogg",
			"loop": true,
			"patterns": [
				["1","0","0","0","0"],
				["1","0","0","0","0"],
				["1","0","2","0","0"],
				["1","0","2","0","0"],
				["1","2","2","0","0"],
				["1","2","2","0","0"],
				["1","0","0","0","0"],
				["1","0","0","0","2"],
				["1","2","0","0","2"],
				["1","0","3","2","3"],
				["1","2","3","3","3"],
				["1","0","3","2","3"],
				["1","2","3","3","3"],
				["1","3","3","2","0"],
				["1","0","2","4","3"],
				["1","3","2","4","3"],
				["1","2","3","4","0"],
				["-1","3","3","4","0"],
				["1","2","0","3","0"],
				["1","2","0","3","0"],
			]
		}
	}

var last_pattern : PoolStringArray
var pattern := 0
var title : Dictionary

func _ready() -> void:
	start_song("title_screen")

func start_song(song: String):
	title = songs[song]
	for i in title["patterns"][0].size():
		var new_channel = AudioStreamPlayer.new()
		add_child(new_channel)
		last_pattern.append("0")
# warning-ignore:return_value_discarded
	get_child(0).connect("finished", self, "_on_pattern_finished")
	play_song()

func play_song():
	for i in get_child_count():
		var channel = title["patterns"][pattern][i]
		if channel != "0":
			if channel == last_pattern[i]:
				get_child(i).play()
			else:
				var path = load(title["path"] + str(i) + "-" + channel + title["extension"])
				get_child(i).set_stream(path)
				get_child(i).play()

func pause_song():
	for i in get_children():
		i.set_stream_paused(true)

func stop_song():
	for i in get_children(): 
		i.stop()


func _on_pattern_finished():
	if pattern < title["patterns"].size()-1:
		pattern += 1
		play_song()
	else:
		if title["loop"]:
			pattern = 0
			play_song()
		else:
			queue_free()
