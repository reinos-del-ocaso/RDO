//::///////////////////////////////////////////////
//:: FileName sc_001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 30/08/2004 11:08:45 PM
//:://////////////////////////////////////////////
#include "pnp_shft_main"

int StartingConditional()
{

    // Inspect local variables
    if(GetLevelByClass(CLASS_TYPE_PNP_SHIFTER)>10)
        return TRUE;

    return FALSE;
}

