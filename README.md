# CADvanced MDT

This repository is the FiveM resource that provides integration between CADvanced (https://cadvanced.app) and FiveM in the form of an in-game MDT

The resource is offered as an optional, free plugin with CADvanced.

## Download and installation

### IMPORTANT: It is very important that the resource is installed in a folder called `cadvanced_mdt`, if this is not the case, the resource will not work correctly.


### Using [FVM](https://github.com/qlaffont/fvm-installer)

```
fvm install --save CADvanced/cadvanced_mdt
```

### Using Git

```
cd resources

git clone https://github.com/CADvanced/cadvanced_mdt.git
```

### Manually

Download the latest release from the [Releases](https://github.com/CADvanced/cadvanced_mdt/releases) tab above.

## Configuration

After you download the resource, you will need to configure it before uploading it to your FiveM server.

Rename the file `mdt_config.lua.sample` to `mdt_config.lua`

Edit mdt_config.lua and modify the line:

```
cfg.cad_url = "https://<your_cadvanced_url_here>"
```
replace `<your_cadvanced_url_here>` with the full URL of your CADvanced server, for example: `mycadvanced.cadvanced.app`

```
cfg.homepage = "WELCOME TO MY MDT!"
```
The text that will be displayed on the front page of your MDT
```
cfg.api_token = ""
```
A random string of characters. You also need to enter this value in Admin > Preferences > API token. These values must match but can be anything you want.

```
cfg.enable_whitelist = false
```
Determines whether to use the in-built whitelist, i.e. only allow users with "Player" role on the CAD to join
```
cfg.sound_volume = 0.5
```
Determines the volume of the alert sound when an update from the CAD arrives in game

```
cfg.debug = false
```
Leave this set to default unless otherwise instructed to do so by the CADvanced support team

```
cfg.panic_command = "panic"
```
The command used to initiate a panic in-game

```
cfg.panic_keybind = "168"
```
The keybinding used to initiate a panic in-game, see a full list of keybindings <a href="https://docs.fivem.net/docs/game-references/controls/">here</a>

```
cfg.panic_flash_mdt = true
```
Should the border of the MDT flash when a panic has been initiated

```
cfg.panic_play_tone = true
```
Should a panic tone play in-game when a panic has been initiated

```
cfg.panic_duration = 10
```
If the MDT border is flashing or a tone is playing, how long (in seconds) should this happen for

```
cfg.panic_create_marker = true
```
Should officers who are assigned to the panic call have a marker and route set in-game to the call


Once you have done this, install the resource in the same way as any other FiveM resource. If you are not familiar with this process, here's a quick step by step tutorial:

* When you unzipped the zip file you should have found a number of files inside
* Once you have configured mdt_config.lua as described above, you can continue
* On your FiveM server, locate your `server-data` folder
* In the `server-data` folder, go into the `resources` folder
* Copy the contents of the `cadvanced_mdt` directory from the zip file onto your FiveM server, into a `resources/cadvanced_mdt` folder
* Your resource is now installed
* If you want to start the resource immediately, type `start cadvanced_mdt` in the FiveM console
* If you want the resource to start when the FiveM server starts, edit the `server.cfg` file inside `server-data` folder
  * You will see a number of lines starting with `start`, add a new line at the bottom of this list saying `start cadvanced_mdt`
* You're done!


