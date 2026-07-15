# The Humble Circuit Mine

*TL;DR: The circuit mine is a proof-of-concept meant to demonstrate how the changes to mines in Factorio v2.1.7 enable access to Triggers based on circuit conditions.*

Modding in Factorio often results in a balancing act between keeping Updates-Per-Second (UPS) low while making sure our actions and scripts run when they need to. Often we need to check against certain conditions that don't have Triggers that can carry calls to our scripts, so we have to resort to nth-tick polling. Every poll that doesn't activate the script is a tax on our UPS with no benefit, which we Factorio players all know is the worst sin of all: **Wasted Capacity**.

I'm a new modder and doing my best to learn Factorio modding. In my explorations, I quickly ran into this problem. I was trying to have something Trigger off a completed crafting run and quickly realized that there's no trigger for that, and thus no native way to do it without polling the crafting process or checking the output, etc. etc. But that couldn't be right, could it? Because the circuit network exposes that via the optional `Read Recipe Finished` signal pulse. Alas, I couldn't find a non-janky way of causing a circuit condition to fire a Trigger without constantly polling it. 

But then I said to myself, "Wait. Everything with health has an on_destroyed trigger at least. And... mines destroy themselves when they're triggered." 

After a hasty search of the recent patch notes, I found what I was looking for: Mines can now be activated by circuits. 

Alright, I'll spare you the rest of the discovery process and cut to the chase.

# The Facts

* Factorio v2.1.7 instituted a change whereby landmines can now be triggered by circuits. 
* This allows us to deepcopy a landmine and substitute its explosion with a script call. 
* Furthermore, **we don't even need to destroy it.** We can use its built-in `action` that fires on proximity or (now) circuit condition, then set `force_die_on_attack` to false and it can just fire (or keep firing) as long as the circuit condition is true.
* We substitute the explosion for a script call, and voila: We have a way to push a script call from inside the engine to our control.lua without having to poll.
* Zero. Wasted. Polls.
* Maybe we don't want to spam our script if the circuit condition is steady rather than a pulse. That's fine; we can set the mine's `timeout` using the script to a custom value to either give it a cooldown, or set it arbitrarily high and have something else set it back to 0 when we want it to start listening again.
* We can also use the `event.source_entity` reference from the trigger to fetch the values of the circuit network with a single on-event call. It's still a push, not a per-tick poll.

# What This Means

* We can trigger scripts off of circuit conditions without costly nth-tick polls. 
* We can trigger off of crafting machines finishing.
* We can trigger off of items entering, exiting, or reaching a certain count in an inventory.
* We can trigger off of *any circuit condition you could imagine.* 

To the best of my knowledge, we could not do this before. We had similar applications using it for range-detection, but triggering off of pure circuit condition wasn't possible until now. For a few niche uses, this could be huge. At worst it could help modders reduce needless polling on scripts that don't have to run frequently.

This mod contains a single item, the Circuit Sensor Mine. It works in most ways like a landmine, except that its proximity detection is disabled, and instead of exploding when triggered, it yells at you. Its entire purpose is to prove that this concept works. The real takeaway is the fact that **as of Factorio v2.1.7, we can now push script triggers from the native engine on *any circuit condition* without having to poll, using deepcopied landmines.** These ideally would be invisible, noninteractable, and placed and destroyed by the host entity as appropriate. Placing their info in storage could open a lot of doors as well.
