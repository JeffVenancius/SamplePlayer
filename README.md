# SamplePlayer
Sample Player for the Godot Game Engine

## Functions:
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

As for the song I'm using in this example, it's mine and I'm using it on my game (Ghosts Of Blue, it's on progress), 
but you can do whatever you want with this one.

### Is it worth it?
original file of this song takes 2.0 MB

With samples I was able to reduce to 326.7 KB

That's like 17% of the original + you can do a lot more with it.
