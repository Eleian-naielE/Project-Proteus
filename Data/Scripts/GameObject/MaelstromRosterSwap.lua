require("PGStateMachine")
require("SetFighterResearch")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end


function State_Init(message)
    if message == OnEnter then
        if Get_Game_Mode() ~= "Galactic" then
            ScriptExit()
        end

        local owner = Object.Get_Owner()
        local rosters = {
            ["MAELSTROM_LOADOUT_SWAP1"] = {
                lock = {"Maelstrom_Loadout_Swap1", "Acclamator_Patrol_Refit", "Imperial_I_Star_Destroyer_Patrol"},
                unlock = {"Maelstrom_Loadout_Swap2", "Acclamator_I_Assault", "Imperial_I_Star_Destroyer_Assault"}
                },
            ["MAELSTROM_LOADOUT_SWAP2"] = {
                lock = {"Maelstrom_Loadout_Swap2", "Acclamator_I_Assault", "Imperial_I_Star_Destroyer_Assault" },
                unlock = {"Maelstrom_Loadout_Swap1", "Acclamator_Patrol_Refit", "Imperial_I_Star_Destroyer_Patrol"}},
        }
		local swap = rosters[Object.Get_Type().Get_Name()]
        
        for _, unit in pairs(swap.lock) do
            owner.Lock_Tech(Find_Object_Type(unit))
        end
        for _, unit in pairs(swap.unlock) do
            owner.Unlock_Tech(Find_Object_Type(unit))
        end

        Object.Despawn()
        ScriptExit()
    end
end