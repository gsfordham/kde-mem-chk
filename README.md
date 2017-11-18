# kde-mem-chk
This repository contains 2 scripts which can be used to reset KDE Plasma (plasmashell) if its memory usage gets too high

I made this because I, personally, was having trouble with KDE Plasma leaking memory over several hours, when left running.
This may be a glitch for my specific version (KDE 5.10.5 for Fedora 26 -- at the time of this writing [2017-11-17]), or it may be more.
I only noticed it over the last few days, so I put this together. If anyone else is having trouble, feel free to download these and use them.

Both of the scripts must be executable. So, chmod them to at least be 754.
They should also be in a directory that is in your path.

These scripts do the following:
1) Detects if plasmashell is running
2) Detects how much RAM it's using
3) Determines if the RAM usage is ok (below 1GB, in my case, but feel free to set it higher or lower)
4) If not, it restarts KDE Plasma
5) Makes sure that closing the outside script (plasma-mem-usage.sh), such as when closing the terminal you have this running on, will not re-kill Plasma, leaving you without a DE
