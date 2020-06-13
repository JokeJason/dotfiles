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

urxvt support colour, but setting colour pattern is complicated. Here are two good resources: 

* Others' dotfiles in unixporn
* Base16 colour builder [base16-builder](https://github.com/base16-builder/base16-builder) which helps to create colour template 

## How to install Extensions for urxvt

Youtube video where I learnd following content: [urxvt: Extensions](https://www.youtube.com/watch?v=OVko_lhkQjs)

Suggested resource from video: [Awesome urxvt](https://github.com/bookercodes/awesome-urxvt) for further explain

Steps to install extensions:

1. Download urxvt extension perl files into correct place (e.g. wget URL) 
2. Copy perl file into /usr/lib/urxvt/perl
3. Edit ~/.Xresources, put extension in the comma separated list `URxvt.perl-ext-common: <extension1>, <extension2>`
4. Add custom keybind shortcut in ~/.Xresources: `URxvt.keysym.<key e.g.F11>: perl:<extension>:switch`

Sometimes, problem will happen, need to refer to github page of these extensions to debug

## Tips

* According to urxvt man page, `Meta` modifier (Alt) is denoted as `M` or `A`
* Currently there are problems between coorperation of `tabbed` and `font-size`. Resizing font, will results displacement of character. Just need make fullscreen and comeback to refresh it. Everything will be fine 

## Todo:

* [ ] Understand [X Logical Font Description](https://wiki.archlinux.org/index.php/X_Logical_Font_Description) 
* [ ] Understand how to enable ranger + image preview in urxvt
