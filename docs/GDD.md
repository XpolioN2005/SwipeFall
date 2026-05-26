# Core Idea

A mobile-first boss rush action game built entirely around touch-driven combat.

Players fight massive evolving bosses inside contained arenas using swipes, taps, holds, and gesture chains instead of traditional movement controls or virtual joysticks.

Combat focuses on:

- Timing
- Rhythm
- Pattern recognition
- Gesture precision
- Reactive decision-making

The touchscreen itself becomes the weapon.

The game combines:

- Sekiro-style timing
- Punish-based combat philosophy
- Reactive defensive play

with:

- Fruit Ninja-style input language
- Screen-space combat readability
- Mobile-first touch interaction

creating a fast, touch-driven boss combat experience built around timing, precision, and pattern mastery.

---

# Genre

- Action Game
- Boss Rush
- Character Action
- Hack and Slash
- Rhythm Action
- Action Arcade

---

# Design Philosophy

- Combat-first gameplay
- Skill-based progression
- Pattern recognition driven combat
- Precision timing and reaction focus
- Readability over realism
- Aggressive defensive play
- Minimal movement and UI clutter
- Punish-window based boss design
- Screen-space combat interaction over world-space simulation

---

# References

- Sekiro: Shadows Die Twice
- Fruit Ninja

---

# Engine

- Godot 4

---

# Core Design Pillars

## Touch Is The Combat System

No virtual joystick.

No movement stick.

No button-heavy HUD.

Every combat interaction is performed directly through touch gestures.

|Input|Function|
|---|---|
|Tap|Precision thrust|
|Swipe|Directional slash|
|Hold (TBD)|Defensive stance / charge|
|Release (TBD)|Heavy attack / counter|
|Double Tap|Emergency evade|
|Gesture Chain|Advanced combo execution|

---

## Screen-Space Combat Philosophy

Combat primarily exists in screen space rather than traditional world-space melee simulation.

Boss attacks are presented through:

- Directional telegraphs
- Timing windows
- Danger indicators
- Slash trajectories
- Reactive visual cues

3D characters and environments act primarily as cinematic presentation and combat readability framing.

Gameplay depth comes from:

- Timing
- Reaction
- Pattern recognition
- Gesture precision

rather than free movement or spatial positioning.

---

## Minimal Movement Philosophy

Movement is intentionally restricted.

The game is not built around free movement or arena traversal.

Combat is primarily about:

- Reading attacks
- Reacting correctly
- Timing inputs
- Maintaining rhythm flow
- Mastering boss patterns

### Dodge System

Dodging is a secondary defensive mechanic.

It is:

- Expensive
- Limited
- Punishable if spammed

Dodges are intended for situations where attacks cannot be parried reliably.

Instead of granting full invulnerability, dodging only avoids portions of incoming damage zones.

This creates pressure to properly understand telegraphs instead of panic-evading everything.

---

# Combat System

## Combat Loop

1. Boss telegraphs attack
2. Player reads pattern
3. Player performs correct gesture
4. Successful defense creates opening
5. Weak spot becomes exposed
6. Player chains attacks
7. Boss transitions into harder patterns

Combat should feel:

- Fast
- Aggressive
- Rhythmic
- Physical
- Highly responsive

---

# Gesture Combat

## Tap

Fast piercing strike.

Used for:

- Precision attacks
- Interrupt windows
- Weak spot punctures

---

## Swipe

Directional slash attack.

Different swipe directions create different attack arcs and responses.

Can also function defensively depending on timing and context.

---

## Hold (TBD)

Context-sensitive stance mechanic.

Possible uses:

- Parry preparation
- Charged attacks
- Counter stance
- Focus state

---

## Release (TBD)

Triggers stored action after holding.

Examples:

- Heavy slash
- Counter attack
- Shockwave
- Weak spot execution

---

## Double Tap

Emergency reposition mechanic.

Limited and costly.

Not intended as primary mobility.

Used only when parrying is unsafe or impossible.

---

## Gesture Chains

Advanced actions are performed through gesture sequences.

Example:

- Swipe Up
- Tap
- Hold
- Release

Chains can trigger:

- Combo finishers
- Armor breaks
- Counter attacks
- Execution moves

The goal is to create mastery through physical input memory and reaction speed.

---

# Defensive Philosophy

## Parry-Focused Combat (TBD)

Defense is centered around timing and precision.

Perfect defense should feel deliberate and satisfying.

Successful parries create:

- Boss stagger
- Weak spot exposure
- Counter windows
- Tempo advantage

Missed timing should feel punishing but fair.

---

# Weak Spot System

Weak spots function primarily as punish openings created through boss overextension and failed attacks, similar to openings in fencing combat.

Examples:

- Exposed joints
- Open eyes
- Broken armor sections
- Vulnerable recovery states

Players must react quickly and strike accurately before openings disappear.

Weak spots are central to:

- Damage optimization
- Stagger opportunities
- Phase transitions
- Tempo control

---

# Attack Telegraph System

Boss attacks rely heavily on visual readability.

Telegraphs include:

- Screen-space danger zones
- Directional slash indicators
- Ground markers
- Expanding impact areas
- Rhythm-based warning flashes

The player survives through recognition and reaction, not randomness.

Attacks should always feel avoidable with correct timing.

---

# Arena Design

Small contained combat arenas.

Minimal traversal.

Boss-focused framing.

Dark/simple environments to maximize readability.

Environments should support:

- Visual clarity
- Attack readability
- Telegraph visibility
- Combat focus

rather than exploration.

---

# Visual Direction

Focus on readability over realism.

## Visual Goals

- Strong silhouettes
- Clear telegraphs
- Heavy slash effects
- Sharp hit feedback
- Minimal UI clutter
- High contrast combat readability

---

# Audio Direction

Audio is critical to combat feel.

Focus areas:

- Slash impact sounds
- Timing cues
- Reactive hit feedback
- Rhythm synchronization
- Escalating phase music

Combat should sound:

- Aggressive
- Immediate
- Physical
- Reactive

---

# Difficulty Philosophy

Avoid:

- Stat inflation
- Massive health bars
- Random unavoidable attacks
- Grind-based progression

Difficulty should come from:

- Pattern complexity
- Timing pressure
- Faster transitions
- Mixed mechanics
- Adaptive boss behavior

Skill should always matter more than upgrades.

---

# Lose Condition

Player survivability is intentionally low.

Core tension comes from:

- Punishable mistakes
- Small recovery windows
- Rapid boss pressure
- Execution demands
    
Combat should remain lethal and fast throughout the game.

---

# Core Gameplay Loop

1. Enter arena
2. Learn boss patterns
3. Parry and counter attacks
4. Break weak spots
5. Survive escalating phases
6. Defeat boss
7. Unlock harder encounters

---

# Scope

## Initial Target Scope

- 4 to 6 bosses
- 1 arena biome
- Fully polished gesture combat system

---

# Technical Direction

## Platform

Primary:

- Mobile

Possible future adaptation:

- PC with mouse gesture controls

---

# Prototype Focus

The first playable prototype should focus entirely on validating:

- Touch responsiveness
- Gesture recognition
- Parry timing feel
- Telegraph readability
- Punish-based combat flow

The prototype should prioritize combat feel over content scale or visual complexity.
