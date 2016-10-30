// Write your briefing here
// <br /> is line break.

player createDiarySubject ["fp_radios"," - Technical Data"];

player createDiaryRecord
["fp_radios",["Medical and Revive Systems","
This is the standard medical configuration for this Framework:<br/>
Damage tolerance adjusted to 4.<br/>
No respawn.
"]];

player createDiaryRecord ["fp_radios",["Radio networks", "
For convenience's sake, the Mission Maker can draft a radio network for the players to use in this section. An example configuration is displayed below.<br/>
You may have to re-acquire radios inside the HQ's radio box or inside Platoon's Hunter car.<br/><br/>

3 - 117 	- 	HIGH COMMAND - ONLY FOR PLATOON LEAD<br/>
1 - 148/117 - 	Command Network<br/>
2 - 148 	- 	Support Network<br/>
1 - 343 	-	Alpha Squad<br/>
2 - 343 	-	Bravo Squad<br/>
3 - 343 	-	Charlie Squad<br/>
4 - 343 	-	Echo Engineer Team<br/>
5 - 343 	-	MEDEVAC<br/>
6 - 343 	-	Recon Team<br/>
7 - 343 	-	Platoon Weapons Team<br/>
"]];

player createDiaryRecord
["Diary",["Mission","
Describe the primary, secondary, and/or all known objectives related to completing the mission.<br/>
Try to omit as much fluff from this component as possible; stick to what the leadership and the players need to know in order to complete the mission.<br/>
Make sure to also specify any alternative conditions. Like situations leading to a critical mission failure.
"]];

player createDiaryRecord
["Diary",["Assets","
This component of the briefing details what non-player assets are at your disposal. All vehicles, additional equipment, and allied NPCs should be accounted for.<br/><br/>

As an example, here is what the Framework offers:<br/>
x2 Command Hunter ATV, armed<br/>
x1 Offroad<br/><br/>

x4 HEMTT Transport Truck<br/>
x8 Hunter ATV, armed<br/><br/>

x4 Pandur II Wheeled IFV, NATO color<br/>
x1 Merkava Tank<br/>
x1 Bardelas SPAAG<br/><br/>

x2 MH-6 Littlebird Observation Heli<br/>
x4 UH-80 Ghost Hawk Utility Heli<br/>
x1 RAH-66 Comanche Attack Heli<br/>
x2 CH-47I Chinook Cargo Heli<br/>
"]];

player createDiaryRecord
["Diary",["Friendly Forces","
This part of the briefing is used to offer a more detailed insight into what the players' faction is like.<br/>
Describe the current situation of equipment, structure, origin, and behaviour of the players' unit, as well as their faction's. Also, should there be a specific feature or NPC presence relevant to the faction, you should notify them of it here.

"]];

player createDiaryRecord
["Diary",["Enemy Forces","
This section is meant to describe the enemies that the players will be facing.<br/>
Make sure that information about the enemy is enough to give the players an idea of what they'll be facing, but not over the point of what the player faction's intelligence would be able to procure. Knowing every detail on the briefing screen drops the suspense.
"]];

player createDiaryRecord
["Diary",["Situation","
Explain the general situation the op is set in within this section.<br/>
General intel, information about the frontline, and in-depth insight into the tasks and the happenings in the area can be placed in here.<br/><br/>

Remember that most of the content within this should be fluff. All essential content should be repeated in the ''Mission'' file. 
"]];

//  Unomment  next line to not have squads show on the briefing
// if (true) exitWith {};

/*
    Adds squads to the map screen
    Full credits CPC-Skippy

        (optional) Mission Maker can change groups name using :
        (group this) setGroupID ["Group Name"];
        on all units in the group

        (optional) Mission Maker can change groups color using :
        (group this) setVariable ["color",'#000000']; where 000000 can be changed to whatever hexa code

        You can set a custom name on one unit by doing
        this setVariable ["displayName","Noob #1"];

*/
private["_includeAI","_rank","_role","_strRank","_strRole","_strGrp","_strColorGrp","_strFinal","_oldGrp","_newGrp","_unitsArr"];

_includeAI     = 0;//0->only players, 1->both AI and players, 2->playable units only (includes player and some AI)
_rank         = false;//true->display unit's rank        false->hide unit's rank
_role         = true;//true->display unit's role        false->hide unit's role

_strRank         = "";//will contain unit's rank
_strRole         = "";//will contain unit's role
_strGrp         = "";//will contain unit's group name
_strColorGrp     = "";//will contain unit's group color
_strFinal         = "";//will contain final string to be displayed
_oldGrp         = grpNull;//group of last checked unit
_newGrp         = grpNull;//group of current unit
_unitsArr         = [];//will contain all units that have to be processed

switch(_includeAI) do {
    case 0:{//only players
            _unitsArr = call CBA_fnc_players;
    };
    case 1:{//both AI and players
        _unitsArr = allUnits;
    };
    case 2:{//only playable units
        if(isMultiplayer) then {
            _unitsArr = playableUnits;
        } else {
            _unitsArr = switchableUnits;
        };
    };
    default{
        _unitsArr = allUnits;
    };
};

{
    if(side _x == side player) then {
        _newGrp = group _x;
        _strGrp = "";

        if(_rank) then {
            switch(rankID _x) do {
                case 0:{
                    _strRank = "Pvt. ";
                };
                case 1:{
                    _strRank = "Cpl. ";
                };
                case 2:{
                    _strRank = "Sgt. ";
                };
                case 3:{
                    _strRank = "Lt. ";
                };
                case 4:{
                    _strRank = "Cpt. ";
                };
                case 5:{
                    _strRank = "Maj. ";
                };
                case 6:{
                    _strRank = "Col. ";
                };
                default{
                    _strRank = "Pvt. ";
                };
            };
        };

        if(_role) then {
            _strRole = " - " + getText(configFile >> "CfgVehicles" >> typeOf(_x) >> "displayName");
        };

        if((_x getVariable "displayName") != "") then {
            _strRole = " - " +(_x getVariable "displayName");
        };

        if(_newGrp != _oldGrp) then {
            _strGrp = "<br/>" + (groupID(group _x)) + "<br/>";

            if((_this find ("Color"+str(side _x)))>-1) then {
                if(count _this > ((_this find ("Color"+str(side _x))) + 1)) then {
                    _strColorGrp = _this select ((_this find ("Color"+str(side _x))) + 1);
                } else {
                    hint "Skippy-Roster - Missing Param";
                    _strColorGrp = "";
                };
            } else {
                switch (side _x) do {
                    case EAST:{
                        _strColorGrp = "'#990000'";
                    };
                    case WEST:{
                        _strColorGrp = "'#0066CC'";
                    };
                    case RESISTANCE:{
                        _strColorGrp = "'#339900'";
                    };
                    case CIVILIAN:{
                        _strColorGrp = "'#990099'";
                    };

                };
            };

            if(((group _x) getVariable "color") != "") then {
                _strColorGrp = (group _x) getVariable "color";
            };
        };

        _strFinal =  _strFinal + "<font color="+_strColorGrp+">"+_strGrp+"</font>" + _strRank + format ["%1%2",if (leader group _x == _x) then {"- "}else{"  - "}, name _x] + _strRole + "<br/>";

        _oldGrp = group _x;
    };
}forEach _unitsArr;

player createDiarySubject ["fp_squads"," - Squads"];
player createDiaryRecord ["fp_squads",["Squads",_strFinal]];


// ADMIN from F3 framework

if (serverCommandAvailable '#kick') then {
    player createDiarySubject ["fp_admin"," - Admin"];
    _briefing ="
    <br />
    ADMIN SECTION<br/>
    This briefing section can only be seen by the admin.
    <br /><br />
    ";

    // ENDINGS
    // This block of code collects all valid endings and formats them properly

    _title = [];
    _ending = [];
    _endings = [];

    _i = 1;
    while {true} do {
        _title = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "title");
        _description = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "description");
        if (_title == "") exitWith {};
        _ending = [_i,_title,_description];
        _endings set [count _endings,_ending];
        _i = _i + 1;
    };

    _briefing = _briefing + "
    ENDINGS<br />
    These endings are available. To trigger an ending click on its link.<br /><br />
    ";

    {
        _briefing = _briefing + format [
        "<execute expression=""[{['end' + str(%1),true,true] call BIS_fnc_endMission},'BIS_fnc_spawn',nil,true] call BIS_fnc_MP;"">'end%1 WIN'</execute> - %2 : - <execute expression=""[{['end' + str(%1),false,true] call BIS_fnc_endMission},'BIS_fnc_spawn',nil,true] call BIS_fnc_MP;"">'end%1 FAIL'</execute>
        <br />
        %3<br /><br />"
        ,_x select 0,_x select 1,_x select 2];
    } forEach _endings;

    if (count _endings > 0) then {
        player createDiaryRecord ["fp_admin", [" - Ending",_briefing]];
    };
    _cmds = " <br />You may run these commands.<br /><br />";
    CUL_a_showUnits = {
        hint format ['UNITS\n\nWEST:%1\nEAST:%2\nINDEP:%3\nCIV:%4\nDEAD MEN:%5\nPLAYERS:%6',
            {side _x == WEST} count allUnits,{side _x == EAST} count allUnits,{side _x == independent} count allUnits,{side _x == civilian} count allUnits,count allDeadMen, count call CBA_fnc_players]
    };
    _cmds =  _cmds + "'<execute expression=""call CUL_a_showUnits"">Count all units</execute><br />'";
    CUL_serverFPSTimeout = time;
    CUL_serverFPS = {
        if (time < CUL_serverFPSTimeout) exitWith{
            hintSilent "You must wait";
        };
        CUL_serverFPSTimeout = time + 15;
        [[[player], {
            [[[diag_fps], {hint format ["Server fps: %1",_this select 0]}],"BIS_fnc_spawn",(_this select 0),false] call BIS_fnc_MP;
        }],"BIS_fnc_spawn",false,false] call BIS_fnc_MP;
    };
    _cmds =  _cmds + "'<execute expression=""call CUL_serverFPS"">Server FPS</execute>'";
    player createDiaryRecord ["fp_admin", [" - Ending",_cmds]];
};
