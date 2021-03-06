/*
    Increase masterwork weapons strength bonus by +1
*/
#include "prc_inc_clsfunc"
void main()
{
    object oPC = GetPCSpeaker();
    object oWeapon = GetItemPossessedBy(oPC, "codi_sam_mw");
    itemproperty ip;
    if (TRUE)
    {
        int iValue;
        ip = GetFirstItemProperty(oWeapon);
        int iBreak = FALSE;
        while (GetIsItemPropertyValid(ip) && !iBreak)
        {
            if(GetItemPropertyType(ip) == ITEM_PROPERTY_ABILITY_BONUS && GetItemPropertyDurationType(ip) == DURATION_TYPE_PERMANENT)
            {
                //SpeakString("Ability Strength: " + IntToString(ABILITY_DEXTERITY));
                //SpeakString("Cost Table: " + IntToString(GetItemPropertyCostTable(ip)));
                //SpeakString("Cost Table Value: " + IntToString(GetItemPropertyCostTableValue(ip)));
                //SpeakString("Param1: " + IntToString(GetItemPropertyParam1(ip)));
                //SpeakString("Param1Value: " + IntToString(GetItemPropertyParam1Value(ip)));
                //SpeakString("SubType: " + IntToString(GetItemPropertySubType(ip)));
                if(GetItemPropertySubType(ip) == ABILITY_DEXTERITY)
                {
                    iValue = GetItemPropertyCostTableValue(ip);
                    RemoveItemProperty(oWeapon, ip);
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(ABILITY_DEXTERITY, iValue + 1), oWeapon);
                    iBreak = TRUE;
                }
            }
            ip = GetNextItemProperty(oWeapon);
        }
        if(!iBreak)
        {
            ip = ItemPropertyAbilityBonus(ABILITY_DEXTERITY, 1);
            AddItemProperty(DURATION_TYPE_PERMANENT, ip, oWeapon);
        }
    }
    WeaponUpgradeVisual();
}


