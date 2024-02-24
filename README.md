# Tydax's LÖVE toys

**Tydax's LÖVE toys** is a repository containing a variety of “toys” (or very basic games or experiences) created during my learning of game development using the [LÖVE 2D framework](https://love2d.org/).

Each folder contains a single toy.

## Requirements

To run a toy, you need the [LÖVE 2D framework](https://love2d.org/) v11.5 installed (or compatible) on your machine.

## How to run a toy

A toy can be ran by passing the toy's folder to LÖVE after cloning this repository, either by dropping the folder directly on the application or executable, or passing it as a parameter of the command. Make sure to pass the folder and not its `main.lua` file.

These commands are pulled from [LÖVE's wiki's _Getting started_](https://love2d.org/wiki/Getting_Started), refer to that page for alternative ways of running games or other platforms.

### Linux

```zsh
love ~/love-toys/hello-world
```

### macOS

```zsh
/Applications/love.app/Contents/MacOS/love ~/love-toys/hello-world
```

or whichever `alias` you have set up for the LÖVE application.

### Windows

```powershell
& "C:/Program Files/LOVE/love.exe" "C:/Users/GuillermoDeLaCruz/love-toys/hello-world"
```
