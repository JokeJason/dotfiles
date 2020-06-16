# URxvt configuration

This is a how-to doc that I wrote for myself to learn urxvt configuration

## How to install & configure urxvt 

[Youtube Video - urxvt: Jump Start](https://www.youtube.com/watch?v=_kjbj-Ez1vU) this is where I started learning urxvt

### Installation

Install urxvt via `sudo apt-get install rxvt-unicode`

### Configuration

According to [rxvt-unicode ArchWiki](https://wiki.archlinux.org/index.php/Rxvt-unicode)

>  Rxvt-unicode is controlled by command-line arguments or Xresources. Command-line arguments override, and take precedence over resource settings

Details of Xresources are available in [X resources ArchWiki](https://wiki.archlinux.org/index.php/x_resources) 

Following are simple steps to configue urxvt:

1. Edit URxvt configuration in ~/.Xresources
2. Reload Xresoures by `xrdb ~/.Xresources`

### Colour Configuration

urxvt support colour, but setting colour pattern is complicated. Here are few good resources: 

* Others' dotfiles in unixporn
* Base16 colour builder [base16-builder](https://github.com/base16-builder/base16-builder) which helps to create colour template 
* Color Picker website [terminal.sexy](https://terminal.sexy)

## How to install Extensions for urxvt

Youtube video where I learnd following content: [urxvt: Extensions](https://www.youtube.com/watch?v=OVko_lhkQjs)

Suggested resource from video: [Awesome urxvt](https://github.com/bookercodes/awesome-urxvt) for further explain

Steps to install extensions:

1. Download urxvt extension perl files into correct place (e.g. wget URL) 
2. Copy perl file into `~/.urxvt/ext` 
3. Edit ~/.Xresources, put extension in the comma separated list `URxvt.perl-ext-common: <extension1>, <extension2>`
4. Add custom keybind shortcut in ~/.Xresources: `URxvt.keysym.<key e.g.F11>: perl:<extension>:switch`

Sometimes, problem will happen, need to refer to github page of these extensions to debug

## Tips

* According to urxvt man page, `Meta` modifier (Alt) is denoted as `M` or `A`
* Currently there are problems between coorperation of `tabbed` and `font-size`. Resizing font, will results displacement of character. Just need make fullscreen and comeback to refresh it. Everything will be fine 
* Copy and Paste in urxvt: From urxvt 9.20, urxvt can support default clipbard copy paste via `Ctrl+Meta(Alt)+c/v` 

## Todo:

* [ ] Understand [X Logical Font Description](https://wiki.archlinux.org/index.php/X_Logical_Font_Description) 
* [ ] Understand how to enable ranger + image preview in urxvt
* [ ] Separate all changable configuration into seperated files in `.Xresources.d/`

## Frequent Questions

### tmux cannot be initiated on rxvt-unicode

Q: Why `tmux` in urxvt will result in error: "open terminal failed: missing or unsuitable terminal: rxvt-256color"

A: That's because the environment variable `$TERM` for urxvt is incorrect. You need check whether rxvt-256color is available within your terminfo database, and give it correct name

Steps:

1. Locate rxvt-unicode related compiled **terminfo** 
   1. According to `man terminfo`, the terminfo database is available at `/etc/terminfo`. After my check there is only a REAMDE file overthere, which listed search path for terminfo command: `${HOME}/.terminfo`, `/etc/terminfo`, `/lib/terminfo` and last `/usr/share/terminfo`.
   2. After search, the only available terminfo database in my laptop is within `/lib/terminfo`.
   3. There `rxvt`, `rxvt-basic`, `rxvt-unicode`, and `rxvt-unicode-256-color`
2. (If terminfo is located) Pick the name of file and put it in `.Xresources`, `URxvt*termName: rxvt-unicode-256-color` for my case, as I want 256 colour support
3. (If terminfo database does not contain correct terminfo file for rxvt-unicode-256color, we need to program it according to [Fix Urxvt Terminfo](http://mfuchs.org/blog/fix-urxvt-terminfo/)
   1. infocmp -L rxvt-unicode-256color -A <dir to terminfo database> > ~/urxvt.tic
   2. tic urxvt.tic

### Why `clear` in urxvt will return `database is inaccessible`

Q: Why `clear` in urxvt will result in `terminals database is inaccessible`

A: Because ncurses is looking for the compiled description of terminfo, but the database is not available within ncurses search path.

Solution: according to `man terminfo`, ncurses will search `$HOME/.terminfo`. So just copy the terminfo database to there. This problem should be solved by `install.conf.yaml` already 


