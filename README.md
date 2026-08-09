
# About Tappy the Fake Bird

This is my first entry for the [20 games challange](https://20_games_challenge.gitlab.io/) as a flappy bird clone. Despite the fact that I am not exactly a beginner I had fun remaking this in a few hours of work. Some things that I have unexpectedly struggled with was the UI not being resized properly and the fact that the `Parallax2D` node will not work properly if anything is scaled from that node downwards in the hierarchy (so the fix is to have a parent and scale that).

I am excited for the next project which is Jetpack Joyride.

## Features

- A simple physics based character that gets killed to obstacles or the floor
- Game state and scene loading: intro menu and game over screen
- Highscore saving between sessions via [ConfigFile](https://docs.godotengine.org/en/stable/classes/class_configfile.html)
- Parallax via the Godot nodes
- A few randomized pitch sounds

## Credits

Made by me (Bogdan Mocanu).

Assets, fonts and sounds by [Kenney](www.kenney.nl).
