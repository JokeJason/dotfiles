# dotfiles
This respository serves as base of version controlling my dotfiles

## 1. DotBot for Bootstrap

I'm currently building my personal dotfile management system for all my linux development environment. For dotfiles management I followed guideline of [Managing Your Dotfile, by anishathalye](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/). He also developed [dotbot](https://github.com/anishathalye/dotbot/) as a tool to bootstrap dotfiles. Please check out his work first, before using my dotfile configurations

After you setup `install.conf.yaml`, just hit `.install`, and dotbot should take care everything for you

## 2. dotfiles-local

After embrasing *anishathalye*'s workflow, I also follow his path to create `dotfiles-local` respository for containing local customization. Hence, this repository to housing general configuraion, while `dotfiles-local` to contain customized support for different platforms.

## 3. i3wm configuration

Since the first time using i3, I found beauty in its simplisity. I start my i3 journey following [addy-dclxvi's i3-starterpack](https://github.com/addy-dclxvi/i3-starterpack). You are welcome to check his configuration. Or you can directly follow my path.

### 3.1 For i3 Beginner

I will not repeat too much on how to set up from the scratch, please take sometime to watch *Code Cast*'s [i3wm youtube series](https://www.youtube.com/watch?v=j1I63wGcvU4). It's a really good source for any new comer. After you go through his videos, setting will be easy.

### 3.2 Media control in i3

In i3 configuration, you have to configure key binding to control media by yourself, here is my experience

There are multiple choices of audio program available, the i3 config file I followed at beginning use amixer, while I choose PulseAudio. Please check "addy-dclxvi/i3-staterpack" 

His volume/music control config is shown as below:

```
# change volume
bindsym XF86AudioRaiseVolume exec amixer -q set Master
bindsym XF86AudioLowerVolume exec amixer -q set Master 5%-
bindsym XF86AudioMute exec amixer set Master toggle

# music control
bindsym XF86AudioNext exec mpc next
bindsym XF86AudioPrev exec mpc prev
bindsym XF86AudioPlay exec mpc toggle
bindsym XF86AudioStop exec mpc stop
```

Following are the step I took to create my Media/Volume control in i3

#### 3.2.1 Volume Control using PulseAudio

* Install `PulseAudio` (Pulse Audio Sound server system)
* Install `pactl` as commandline controller `PulseAudio`
* Install `pavucontrol` as GUI controler of `PulseAudio` 

##### 3.2.1.1 Check `pactl` controller is working and learn how to use it and add to i3

1. Play music on youtube or Spotify
2. Open `pavucontrol` to check sound is player correctly
3. Find correct Sink by `pactl list`, the playing one should be the "Sink" that has "State: Running"
4. Increase volume by `pactl set-sink-volume <sink number> 70%`, which change volume and should be reflected on `pavucontrol` and your ear
5. Now you know which sink is using and add the command line into i3 config
6. Create keybindings to control volume in configuration

```
bindsym XF86AudioRaiseVolume exec pactl set-sink-volume 1 +5%
bindsym XF86AudioLowerVolume exec pactl set-sink-volume 1 -5%
bindsym XF86AudioMute        exec pactl set-sink-mute 1 toggle
```

##### 3.2.1.2 Check `playerctl` controller is working and learn how to use it and add to i3 

1. Play music on Spotify
2. Pause the music by `playerctl play-pause`, and check whether the music stopped
3. After confimring this commandline worked, add it to with keybind in your i3
4. Create keybindings to control music play in configuration

```
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
bindsym XF86AudioPlay exec playerctl play-pause
```

#### 3.2.2 Media control in separate mode

Some keyboard does not have media keys like XF86AudioRaiseVolume, we can get around it by creating specific mode

1. Create a mode "media" in i3 configuration
2. In the mode, add bindsym to control media flow

```
# Media control using separate mode (for 60% keyboard)
bindsym $super+m mode "media"
mode "media" {
        bindsym Up      exec pactl set-sink-volume 1 +5%
        bindsym Down    exec pactl set-sink-volume 1 -5%
        bindsym 9       exec pactl set-sink-volume 1 90%
        bindsym 8       exec pactl set-sink-volume 1 80%
        bindsym 7       exec pactl set-sink-volume 1 70%
        bindsym 6       exec pactl set-sink-volume 1 60%
        bindsym 5       exec pactl set-sink-volume 1 50%
        bindsym 4       exec pactl set-sink-volume 1 40%
        
        bindsym Right exec playerctl next
        bindsym Left  exec playerctl previous
        bindsym space exec playerctl play-pause 
        bindsym Return mode "default"
}
```

#### 3.2.3 Volume control using TUI

Sometimes you still want to working under GUI or TUI, here is TUI volume conotroller

1. Install `pulsemixer` 
2. Use `pulsemixer` TUI to change volume, this program cannot do single channel change, it can only do change on both channel at once

#### 3.2.4 Volume control using GUI (Suggested in Ubuntu Distro)

For GUI volumne controller, `pavucontrol` is a good choice

1. Install `pavucontrol`
2. Use `pavucontrol` to change volume

#### 3.2.5 Adding media control for both playerctl and mpc (Added on 2020-05-31)

After some tweeking, I'm starting to use *mopidy+ncmpcpp* as music player. Official Spotify (linux version) is still installed under my system. Just try to taste something different.

There are many configuration tutorial online about Mopidy+Spotify+ncmpcpp, please refer them for detail. This README is just for i3wm rice (How to operate music player using keyboard only).

After having both mopidy+ncmpcpp (which use Mopidy-MPD as backend) and Spotify app installed, my keyboard shortcut need adapt both applications. Spotify app can be controled using `playerctl` as shown in 3.2.2, mopidy can be controlled using `mpc` (ncmpcpp is just a TUI interface). Hence I created `mediactrl.sh` as a tool to play/pause/next/prev music on both software.

If both Spotify and Mopidy(MPD) are running, `mediactrl.sh` will control Spotify. If there is only Mopidy is running, `mediactrl.sh` will control Mopidy using `mpc` command lines.

Controlling Spotify via: following commands:

```bash
playerctl play-pause --player spotify
playerctl next --player spotify
playerctl previous --player spotify
```

Controlling Mopidy via following commands

```bash
mpc toggle
mpc next
mpc prev
```

### 3.3 Screen backlight control using `xbacklight`

Follow [backlight](https://wiki.archlinux.org/index.php/backlight), it will provide step by step guidance to use xbacklight on most setup\

### 3.4 ibus multi-language input

As English is my second language, I choose `ibus` as my multi-language input engine. 

#### 3.4.1 Checking ibus is working

* Check current ibus engine: `ibus engine`
* Check available ibus engine: `ibus list-engine`

#### 3.4.2 Add ibus into i3 config

* start ibus engine at beginning by adding `ibus-daemon &` in i3 config

```
exec --no-startup-id ibus-daemon &
All links have been set up to specific screen as follow:

```
workspace $workspace1 output DP-2
```
