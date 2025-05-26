# Brick Breaker Game (COAL)
 
# Brick Breaker Game 🧱⚾

A classic arcade-style brick breaker game implemented in Assembly Language (MASM615) as part of a Computer Organization & Assembly Language course project.

## 🎮 Game Overview

Break all the bricks by bouncing a ball off your paddle! Navigate through three challenging levels while managing your lives and aiming for the highest score. Each level introduces new mechanics and increased difficulty to keep you engaged.

## ✨ Features

### Core Gameplay
- **Three Progressive Levels** with increasing difficulty
- **Lives System** - Start with 3 lives (displayed as heart shapes)
- **Score System** - Different colored bricks award different points
- **Timer** - 4-minute time limit per game
- **Paddle Control** - Move left/right using arrow keys
- **Ball Physics** - Realistic bouncing mechanics

### Level Progression
- **Level 1**: Basic brick breaking gameplay
- **Level 2**: Faster ball speed, shorter paddle, bricks require 2 hits
- **Level 3**: Fixed unbreakable bricks, 3-hit bricks, special power brick

### Special Features
- **Power-ups** from special bricks:
  - Multiple balls (3+ balls simultaneously)
  - Enlarged paddle
  - Super ball (breaks any brick in 1 hit for 10+ seconds)
- **Sound Effects** for enhanced gameplay experience
- **File Handling** - Persistent high score storage
- **Multiple Screen Navigation**

## 🖥️ Game Screens

1. **Welcome Screen** - Enter player name
2. **Main Menu** - Navigate game options
3. **Gameplay Screen** - Main game interface
4. **Instructions Screen** - How to play
5. **High Score Display** - View top players
6. **Pause Functionality** - Pause/resume gameplay

## 🎯 Game Mechanics

### Level Details
- **Level 1**: Standard gameplay with single-hit bricks
- **Level 2**: 
  - Increased ball speed
  - Reduced paddle size
  - Bricks change color after first hit, disappear after second
- **Level 3**:
  - Some bricks are indestructible (bounce ball back)
  - Regular bricks require 3 hits to break
  - Special random brick removes 5 random bricks when hit
  - Further increased ball speed

### Scoring System
- Points awarded based on brick color/type
- High scores saved with player names
- Persistent score tracking across game sessions

## 🛠️ Technical Implementation

- **Language**: Assembly Language (MASM615)
- **Graphics**: Custom VGA graphics implementation
- **Input**: Keyboard input handling (arrow keys)
- **File I/O**: Score persistence using file handling
- **Sound**: Audio feedback for game events

## 🎮 Controls

- **Left Arrow**: Move paddle left
- **Right Arrow**: Move paddle right
- **ESC**: Pause game
- **Enter**: Navigate menus

## 📋 Requirements

- MASM615 compatible system
- VGA graphics support
- Sound card (optional, for audio features)

## 🏆 Project Highlights

This project demonstrates:
- Low-level graphics programming in Assembly
- Game physics implementation
- File I/O operations
- User interface design
- Sound integration
- Multi-level game progression

## 📸 Screenshots

*Game Menu Screen and Gameplay Interface shown in project documentation*

## 🚀 Getting Started

1. Ensure MASM615 is installed and configured
2. Compile the assembly source files
3. Run the executable
4. Enter your name and start playing!

## 📝 Development Notes

- Developed as a Computer Organization & Assembly Language course final project
- Implements good programming practices with well-commented code
- Modular design with clear separation of game components
- Extensive use of Assembly language graphics and I/O operations

---

*This classic arcade game brings nostalgic brick-breaking action with modern features and challenging gameplay progression!*