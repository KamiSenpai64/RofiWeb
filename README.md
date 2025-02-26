# Rofi Web Searcher

A simple web searcher built with **Rofi**, designed to quickly search the web directly from your Linux desktop environment. This tool is ideal for anyone who uses Rofi as a launcher and wants to search the web without opening a browser first.

![](https://github.com/KamiSenpai64/RofiWeb/blob/master/untitled.gif)

## Features
- Fast and efficient search integration with Rofi.
- Easily configurable and modular for bookmarks, different search engines and more
- Lightweight and minimal setup.

## Installation

### Prerequisites
- [Rofi](https://github.com/davatorium/rofi) must be installed on your system.
- A web browser for viewing the search results.

### Steps
1. Clone this repository to your local machine:
    	```
    	git clone https://github.com/KamiSenpai64/RofiWeb.git
    	```
2. Navigate to the directory:
    	```
    	cd RofiWeb
    	```
3. Make the script executable (if applicable):
    	```
    	chmod +x web-search.sh
    	```

4. Add the script to your system's PATH or launch it directly from the terminal:
    	```
    	./web-search.sh
    	```

## Usage
- Run the script through Rofi by binding it to a keyboard shortcut 
	{Example: i3wm}
	```
	bindsym $mod+l exec /path/to/rofi-web.sh
	```
- Or run it manually from the terminal
   	```
   	./rofi-web.sh
   	```
## Configuration
- The script can be modified to your liking by changing the config files inside RofiWeb/:

- Default browser is Firefox but can be changed to anything else.

- Default search engine is Google but can be changed to anything else.

## Why?
- I guess some people might ask: Why would I use this instead of opening a browser and searching for whatever I need?
	My answer: yes.
	- I have been using i3wm for quite some time now and I always loved it. so I always tried to make everything as customized as possible. At first, this was a script for opening files in Okula, but then, I thought: I will do it for web searching , music, PDF files, and so on. I had a plethora of ideas, so here is the first one. I will make the next ones soon, and if anyone likes this project, thumbs up! Use, customize, and change it to your liking. All is welcome.
