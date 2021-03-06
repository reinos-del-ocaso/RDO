//::///////////////////////////////////////////////
//:: [Endurance]
//:: [NW_S0_Endurce.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Gives the target 1d4+1 Constitution.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff
//#include "spinc_common"

//#include "x2_inc_spellhook"
#include "spinc_common"
#include "spinc_massbuff"

void main()
{

DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_TRANSMUTATION);
    /*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
   // End of Spell Cast Hook




    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eCon;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nModify = d4() + 1;
    float fDuration = HoursToSeconds(CasterLvl);
    int nMetaMagic = GetMetaMagicFeat();
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENDURANCE, FALSE));
    //Check for metamagic conditions
    if (CheckMetaMagic(nMetaMagic, METAMAGIC_MAXIMIZE))
    {
        nModify = 5;
    }
    if (CheckMetaMagic(nMetaMagic, METAMAGIC_EMPOWER))
    {
        nModify = FloatToInt( IntToFloat(nModify) * 1.5 );
    }
    if (CheckMetaMagic(nMetaMagic, METAMAGIC_EXTEND))
    {
        fDuration = fDuration * 2.0;
    }
    //Set the ability bonus effect
    eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,nModify);
    effect eLink = EffectLinkEffects(eCon, eDur);

	// bleedingedge - Strip old spell off to deal with mass buffs.
	StripBuff(oTarget, SPELL_ENDURANCE, SPELL_MASS_ENDURANCE);
	
    //Appyly the VFX impact and ability bonus effect
    SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration,TRUE,-1,CasterLvl);
    SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name

}
