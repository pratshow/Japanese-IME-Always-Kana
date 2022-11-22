# Japanese-IME-Always-Kana
A simple script for the Google Japanese IME on Windows to automatically be in Hiragana mode when switching to the JP keyboard.

## Installation
To use this script simply install AutoHotKey from their [official site](https://www.autohotkey.com/) and run the file "Japanese IME Auto Kana.ahk". This automatically binds to Win & Space to swap to the JP keyboard(default bind).

## Usage
By default when using the Japanese Google IME for windows it starts on romaji, this is not very useful because when you swap keyboards you probably want to type in Japanese. This Script automatically switches to Katagana when swapping to the JP keyboard saving you from the extra annoying ctrl + Caps keyboard press. The Kana keyboard also persists when changing text fields so you don't have to keep changing back.

You can easily rebind the key for swapping keyboards to something different other than Win + Space by replacing line 25 of the script `#Space::` with whatever you desire. Please reference the [AHK documentation](https://www.autohotkey.com/docs/Hotkeys.htm) for keybind information.

## Possible bugs
This Script makes a few assumptions about how your IME is set up.
1. It assumes you only have 2 keyboards (US-English and Google Japanese IME)
2. Keybinds are default. That is: Win + Space for keyboard swap and Ctrl + Caps for Hiragana.

I cannot guarantee this script will work if your settings are different. I may make a more robust version in the future.
