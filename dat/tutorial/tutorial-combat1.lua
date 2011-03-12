-- This is the tutorial: basic combat.

include("dat/tutorial/tutorial-common.lua")

-- localization stuff, translators would work here
lang = naev.lang()
if lang == "es" then
else -- default english
    title1 = "Tutorial: Basic combat"
    message1 = [[Welcome to tutorial: Basic combat.

Combat is an important aspect of Naev, and you will have to fight off enemies sooner or later, no matter what career you decide to pursue. In this tutorial, you will learn the basic principles of combat.]]
    message2 = [[For this tutorial, you will be flying a Lancelot fighter. It comes equipped with two advanced laser cannons. You can fire your weapons by pressing %s. Try this now.]]
    message3 = [[You may have noticed that as you fired your weapons, you depleted your energy gauge. Most energy weapons use energy while firing, and when you run out of energy you can no longer use them. Energy recharges automatically over time.

Now we will examine another type of weapon that uses ammunition instead of energy. Ammunition does not automatically recharge, you will have to buy it on planets or stations.

You have been equipped with a Mace rocket launcher, which is treated as a secondary weapon by default. Fire it now using %s and watch its ammunition deplete.]]
    message4 = [[Let's take a closer look at the difference between primary and secondary weapons.

Open the info menu by pressing %s.]]
    message5 = [[The info menu allows you to manage your weapons. You have ten weapon groups available to you. Each weapon may be assigned to any or all of these weapon groups, as either a primary or a secondary weapon. As you have just seen, primary weapons are fired with %s while secondary weapons are fired with %s. During flight, you may switch between weapon groups at any time by using the appropriate buttons (%s, %s, %s, %s, %s, %s, %s, %s, %s and %s).

Additionally, you may set weapon groups to fire when activated. If you do this, then you may fire the weapons in that weapon group simply by holding down the key for that weapon group. Your current weapon group will remain selected in this case.

Configure your weapons as you like now, or simply leave them as they are. Then close the info menu.]]
    message6 = [[A target practice drone has been placed in space close to you. This drone won't move or fight back. Your task is to fire your weapons at it until you disable it. To disable any ship, you must reduce its armor below 30% of maximum.

Before you attack the drone, you should target it. To do so, you can use %s, which will target the nearest hostile enemy. You can also click on it with the mouse.

Target the drone, then shoot at it until it becomes disabled.]]

    wepomsg = [[Use %s to test your weapons (%ds remaining)]]
    infoomsg = [[Use %s to to open the info menu]]

    shield30 = {
        "Bring on the pain!",
        "You're no match for the fearsome T. Practice!",
        "I've been shot by ships ten times your size!",
        "Let's get it on!",
        "I  haven't got all day.",
        "You're as threatening as an unborn child!",
        "I've snacked on foes much larger than yourself!",
        "Who's your daddy? I am!",
        "You're less intimidating than a fruit cake!",
        "My ship is the best in the galaxy!",
        "Bow down before me, and I may spare your life!",
        "Someone's about to set you up the bomb.",
        "Your crew quarters are as pungent as an over-ripe banana!",
        "I'm invincible, I cannot be vinced!",
        "You think you can take me?",
        "When I'm done, you'll look like pastrami!",
        "I've got better things to do. Hurry up and die!",
        "You call that a barrage? Pah!",
        "You mother isn't much to look at, either!",
        "You're not exactly a crack-shot, are you?",
        "I've had meals that gave me more resistance than you!",
        "You're a pathetic excuse for a pilot!",
        "Surrender or face destruction!",
        "That all you got?",
        "I am Iron Man!",
        "My shields are holding fine!",
        "You'd be dead if I'd remembered to pack my weapons!",
        "I'll end you!",
        "... Right after I finish eating this bucket of fried chicken!",
        "Em 5 Fried Chicken. Eat only the best.",
        "This is your last chance to surrender!",
        "Don't do school, stay in milk.",
        "I'm going to report you to the NPC Rights watchdog.",
        "Keep going, see what happens!",
        "You don't scare me!",
        "What do you think this is, knitting hour?",
        "I mean, good lord, man.",
        "It's been several minutes of non-stop banter!",
        "Haven't I sufficiently annoyed you yet?",
        "Go on, shoot me.",
        "You can do it! I believe in you.",
        "Shoot me!",
        "Okay, listen. I'm doing this for attention.",
        "But if you don't shoot me, I'll tell the galaxy your terrible secret.",
        "...",
        "...",
        "...",
        "Go away! There are no Easter Eggs here.",
    }
    armour31 = {
        "Okay, that's about enough.",
        "You can stop now.",
        "I was wrong about you.",
        "Forgive and forget?",
        "Let's be pals, I'll buy you an ale!",
        "Game over, you win.",
        "I've got a wife and kids! And a cat!",
        "Surely you must have some mercy?",
        "Please stop!",
        "I'm sorry!",
        "Leave me alone!",
        "What did I ever do to you?",
        "I didn't sign up for this!",
        "Not my ship, anything but my ship!",
        "We can talk this out!",
        "I'm scared! Hold me.",
        "Make the bad man go away, mommy!",
        "If you don't stop I'll cry!",
        "Here I go, filling my cabin up with tears.",
        "U- oh it a-pears my te-rs hav- da--age t-e co-mand cons-le.",
        "I a- T. Pr-ct---! Y-- w--l fe-r m- na-e --- Bzzzt!"
    }
end

function create()
    misn.accept()
    
    -- Set up the player here.
    player.teleport("Cherokee")
    pilot.clear()
    pilot.toggleSpawn(false) -- To prevent NPCs from getting targeted for now.

    pp = player.pilot()
    pp:setPos(vec2.new(0, 0))
    pp:rmOutfit("all")
    pp:addOutfit("Laser Cannon MK2", 2)
    -- TODO: switch to Lancelot.
    player.msgClear()

    enable = {"menu", "left", "right", "primary"}
    enableKeys(enable)

    tkMsg(title1, message1, enable)
    tkMsg(title1, message2:format(tutGetKey("primary")), enable)

    waitenergy = true
    flytime = 10 -- seconds of fly time

    omsg = player.omsgAdd(wepomsg:format(tutGetKey("primary"), flytime), 0)
    hook.timer(1000, "flyUpdate")
end

-- Make the player fire his weapons.
function flyUpdate()
    flytime = flytime - 1
    
    if waitenergy then 
        if flytime == 0 then
            waitenergy = false
            waitammo = true

            player.omsgRm(omsg)
            tkMsg(title1, message3:format(tutGetKey("secondary")), enable)

            pp:rmOutfit("all")
            pp:addOutfit("Mace Launcher", 1)

            enable = {"menu", "left", "right", "primary", "secondary"}
            enableKeys(enable)

            flytime = 10
            omsg = player.omsgAdd(wepomsg:format(tutGetKey("secondary"), flytime), 0)
            hook.timer(1000, "flyUpdate")
        else
            player.omsgChange(omsg, wepomsg:format(tutGetKey("primary"), flytime), 0)
            hook.timer(1000, "flyUpdate")
        end
    elseif waitammo then
        if flytime == 0 then
            player.omsgRm(omsg)
            waitammo = false
            waitinfo = true
            
            tkMsg(title1, message4:format(tutGetKey("info")), enable)
            omsg = player.omsgAdd(infoomsg:format(tutGetKey("info")), 0)

            enable = {"menu", "left", "right", "info"}
            enableKeys(enable)

            hook.input("input")
        else
            player.omsgChange(omsg, wepomsg:format(tutGetKey("secondary"), flytime), 0)
            hook.timer(1000, "flyUpdate")
        end
    end
end

-- Input hook.
function input(inputname, inputpress)
    if inputname == "info" and inputpress and waitinfo then
        waitinfo = false
        pp:rmOutfit("all")
        pp:addOutfit("Mace Launcher", 1)
        pp:addOutfit("Laser Cannon MK2", 2)
        
        player.omsgRm(omsg)
        tkMsg(title1, message5:format(tutGetKey("primary"), tutGetKey("secondary"), tutGetKey("weapset1"), tutGetKey("weapset2"), tutGetKey("weapset3"), tutGetKey("weapset4"), tutGetKey("weapset5"), tutGetKey("weapset6"), tutGetKey("weapset7"), tutGetKey("weapset8"), tutGetKey("weapset9"), tutGetKey("weapset0")), enable)
        
        hook.timer(1, "dummypractice") -- Ugly way to detect the closure of the info menu.
    end
end

-- Hooked function, initiates drone target practice.
function dummypractice()
    drone = pilot.add("Civilian Llama", "dummy", player.pilot():pos() + vec2.new(200, 0))[1]
    drone:setHostile()
    hook.pilot(drone, "disable", "dronedisable")
    tkMsg(title1, message6:format(tutGetKey("target_hostile")), enable)
    
    enable = {"menu", "left", "right", "primary", "secondary", "info", "target_hostile"}
    enableKeys(enable)
end

-- Drone disable hook.
function dronedisable()
    drone:setInvincible(true)
end

-- Taunt function.
function taunt()
	armour, shield = captaintTP:health()
    if shield >= 40 then
        if #shield30 > shieldtaunt then
            shieldtaunt = shieldtaunt + 1
        else
            shieldtaunt = 1
        end
        captainTP:comm(shield30[shieldtaunt])
        hook.timer(4000, "taunt")
    elseif armour >= 31 then
        if #armour31 > armourtaunt then
            armourtaunt = armourtaunt + 1
        else
            armourtaunt = 1
        end
        captainTP:comm(armour31[armourtaunt])
        hook.timer(4000, "taunt")
    end
end
 
-- Abort hook.
function abort()
    cleanup()
end

-- Cleanup function. Should be the exit point for the module in all cases.
function cleanup()
    -- Function to return to the tutorial menu here
end