# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Redo the sprites for the character
- Redo the sprites for the enemies

### Added

- Add new rooms
- Add new weapons

### Fixed

- Fix the player not being placed inside the next room whenever it appears

## [0.9.0] 2024-12-21

### Changed 

- Change the name of the debug room to be the main room
- Rework the camera values to match the size of the rooms

### Added

- Add a door to transition into the next room
- Add a smooth transition between each room

## [0.8.0] 2024-12-11

### Changed

- Change the weapon stats UI to use sprites instead of text
- Move the damage types enumerator to a respective file

### Added

- Add sprites that will be used to hold the weapon information and show it
- Alucard

## [0.7.1] 2024-12-09

### Changed

- Adjust the values of the UI that shows the weapon stats

### Added

- Add a low chance of the player being instantly dead upon spawning

## [0.7.0] 2024-12-03

### Changed

- Change the location of the function that allows the player to pick up weapons to a dedicated file

### Added

- Add the stats of a weapon to the corner of the screen
- Add a face to the banana

### Removed

- Remove other fonts and maintain only the original

### Fixed

- Fix the game crashing if the player tried to shoot without a weapon
- Fix the weapon not being aligned when it is dropped
- Fix the weapon damage type not appearing

## [0.6.0] 2024-11-20

### Changed

- Change the default weapon

### Added

- Add a function that allows the player to grab weapons from the ground
- Add a font to the tooltip that appears when the players hovers a weapon
- Add Cell

### Fixed

- Allow the player to choose which weapon he wants to grab from the ground

## [0.5.0] 2024-11-19

### Changed

- Revert the changes made to the bullets
- Redo the size of the player sprites

### Added

- Add the function to show the healthbar of the enemies
- Add a healthbar to the corner of the screen to show the player's health

### Fixed

- Fix the enemies not being able to attack the player

## [0.4.1] 2024-11-11

### Changed

- Change the enemy code so that they enter idle if they don't have a path
- Change the enemy code so that they move until they are close enough to the player
- Revert the size of the weapon to it's original

### Fixed

- Fix the initial timer not working

## [0.4.0] 2024-11-10

### Changed

- Adjust the values that force the cursor to be inside the screen
- Reverted the player size back to the original values

### Added

- Add a timer that doesn't allow the player to immediately shoot their gun
- Add the attack function to the enemies

### Fixed

- Fix the buttons not being at the center of the screen
- Fix the enemy losing the player after getting hit

## [0.3.0] 2024-10-30

### Changed

- Change the menu font to a more appropriate one
- Change the play button to temporarily move the player to the debug room
- Change the player cursor to a more appropriate one

### Added

- Add a new font for the controls/help button
- Add a quit button to close the game

### Fixed

- Change the event that draws the text on the help button to fix it not being centered
- Fix the player not being able to be unarmed

## [0.2.1] - 2024-10-28

### Changed

- Change the menu font
- Lock the mouse to the screen to prevent it from going outside of it
- Move the tile size macro to be inside of the respective file
- Slightly increase the size of the player sprites
- Slightly increase the size of the weapon template

### Fixed

- Fix the game having black bars at the side of the screen

## [0.2.0] - 2024-10-07

### Added

- Add fonts to the buttons on the menu
- Add the button parent to hold the main code for each button
- Add a button to start the game, a button that will show the controls in the future

## [0.1.0] - 2024-10-04

### Changed

- Relocate the state enums to a dedicated file
- Redo the values of the knockback so the enemy has more knockback

### Added

- Add a random chance of whenever an idle animation ends to do a special animation
- Add knockback to the enemies whenever they are hit
- Add a room specifically for debugging purposes
- Add sprites to the buttons on the menu
- Add sprites for the player idle animation

### Fixed

- Fix the issue where the enemies don't disappear after dying
- Fix a typo in the code

## [0.0.1] - 2024-09-17

### Added

- Initial release of the project with the base for the building of the game
- Add the first tileset of the game
- Add the templates for other tilesets
