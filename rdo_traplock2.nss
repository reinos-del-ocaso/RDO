void SendCreature(object oCreature, object oDest)
{
    if(oCreature != OBJECT_INVALID)
    {
        AssignCommand(oCreature, ClearAllActions());
        AssignCommand(oCreature, ActionJumpToObject(oDest,FALSE));
    }
}

void main()
{
    object oidUser;
    object oidDest;
    string sDest;

    if (!GetLocked(OBJECT_SELF))
    {
        if (GetIsOpen(OBJECT_SELF))
        {
            sDest = GetLocalString(OBJECT_SELF,"Destination");

            oidUser = GetLastUsedBy();
            oidDest = GetObjectByTag(sDest);

            AssignCommand(oidUser,ActionJumpToObject(oidDest,FALSE));
            object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oidUser);
            object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oidUser);
            object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oidUser);
            object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oidUser);
            object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oidUser);

            SendCreature(oAnimal, oidDest);
            SendCreature(oDominated, oidDest);
            SendCreature(oFamiliar, oidDest);
            SendCreature(oHenchman, oidDest);
            SendCreature(oSummoned, oidDest);
            //PlayAnimation(ANIMATION_PLACEABLE_CLOSE);
        } else
        {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
            DelayCommand(7.0, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
        }
    } else
    {
    //    ActionUseSkill
    }

}
