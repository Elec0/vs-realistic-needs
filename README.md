


## Features
- Manage your hunger, thirst, fatigue, and cleanliness
- Bonuses and penalties according to your needs levels


## Installation
- Install [Cyber Engine Tweaks](https://github.com/yamashi/CyberEngineTweaks) (v1.18.1 or newer)
- Install [Native Settings](https://github.com/justarandomguyintheinternet/CP77_nativeSettings) (v1.2 or newer)
- Extract into the Cyber Engine Tweaks mod folder
```
Cyberpunk 2077/bin/x64/plugins/cyber_engine_tweaks/mods
``` 

## Detailed Feature Explanation
I currently track the following needs:
* Hunger
* Thirst
* Fatigue (sleep)
* Cleanliness

Internally these are represented by a decimal number from 110-0, where 110 is the need being most fulfilled (Bloated), 
and 0 is needing it the most (Starving.)

There are 6 normal stages that all needs share, then 1 extra stage that only Hunger and Thirst have.  
This extra stage is over-full, or bloated. If you eat or drink too much, you'll hit this stage.

You cannot reach the over-full stage without already being in stage 1.   
This prevents something like being near the top
of stage 2, eating a large meal and getting shot straight up to bloated. Won't happen, you'll stop at the top of
stage 1.

Stage 2 and up will give you bonuses (with Stage 0 reducing the bonus slightly), whereas below Stage 2 will start imposing penalties of increasing severity.

If the 'Can die from low needs' setting is enabled, dropping below Stage 6 in hunger or thirst will kill you.

Hitting the bottom of Stage 6 in fatigue will instead start causing spontaneous fainting. (Assuming I can figure out how to do it) This will black out your screen for a moment, and ragdoll your character for a few seconds.  
I don't recommend doing that during a firefight, let me tell you.

### Hunger
Stages of hunger, from least to most hungry:
0. Bloated > 100
1. Full > 80
2. Satisfied > 60
3. Peckish > 40
4. Hungry > 30
5. Very Hungry > 10
6. Starving > 0

Food is either a small, medium, or large meal.

### Thirst
Stages of thirst, from least to most thirsty:
0. Bloated
1. Quenched
2. Satisfied
3. Slightly thirsty
4. Thirsty
5. Very Thirsty
6. Dehydrated


### Fatigue

Stages of fatigue from least to most sleepy:
1. Rested
2. Normal
3. Flagging
4. Tired
5. Very Tired
6. Sleep deprived

### Cleanliness
Stages of cleanliness from least to most dirty:
1. 
2. 
3. 
4. 
5. 
6. 


### Drain Rates
Each need drains at different rates, depending on a number of factors.

[TODO: Put in the base rates and factors]  

## Todo List
- [ ] What does alcohol do?
- [ ] Multi-language support
- [ ] Determine if using stamina depletes needs faster

#### Credits
* [psiberx](https://github.com/psiberx) for [CET kit](https://github.com/psiberx/cp2077-cet-kit)
* [FoNoicH](https://www.nexusmods.com/cyberpunk2077/users/1360640) for [Live in Night City](https://www.nexusmods.com/cyberpunk2077/mods/3729), which I used as reference