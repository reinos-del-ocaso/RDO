////////////
// Evento OnOpened para el merchant Herrero
// Author: Inquisidor
//
// ADVERTENCIA: La clave formada con los primeros 16 caracteres del tag de una instancia de Store, debe ser �nica dentro del area donde este ubicada.
////////////////

#include "IPS_RTG_inc"
#include "Store_inc"
#include "Skills_sinergy"

const int Store_DESIRED_ITEMS_QUANTITY = 24; // cuatro por cada uno de los seis cases del switch


void Store_generateItems( int actualTime, int expectedItemsQuality, int lacking ) {

    if ( lacking > Store_MAXIMUM_ITEMS_TO_GENERATE_IN_ONE_STEP ) {
        DelayCommand( 5.0, Store_generateItems( actualTime, expectedItemsQuality, lacking - Store_MAXIMUM_ITEMS_TO_GENERATE_IN_ONE_STEP ) );
        lacking = Store_MAXIMUM_ITEMS_TO_GENERATE_IN_ONE_STEP;
    }

    object item;
    while( --lacking >= 0 ) {
        float quality = Random_generateLevel( expectedItemsQuality );
        switch( Random(6) ) {
            case 0:
                item = IPS_Item_generateArmor( OBJECT_SELF, quality, MEDIUM_ARMOR_DESCRIPTORS_ARRAY, TRUE );
                break;
            case 1:
                item = IPS_Item_generateArmor( OBJECT_SELF, quality, HEAVY_ARMOR_DESCRIPTORS_ARRAY, TRUE );
                break;
            case 2:
                item = IPS_Item_generateSmallShield( OBJECT_SELF, quality, TRUE );
                break;
            case 3:
                item = IPS_Item_generateLargeShield( OBJECT_SELF, quality, TRUE );
                break;
            case 4:
                item = IPS_Item_generateTowerShield( OBJECT_SELF, quality, TRUE );
                break;
            case 5:
                item = IPS_Item_generateHelmet( OBJECT_SELF, quality, TRUE );
                break;
        }
        Store_setExpirationDate( item, actualTime );
    }
}

void main() {
    if( !GetLocalInt( OBJECT_SELF, Store_wasOpenedBefore_VN ) )
        Store_initialize( OBJECT_SELF );

    object cliente = GetLastOpenedBy();
    if( GetIsPC( cliente ) ) {
        Skills_Sinergy_storeOnOpen( cliente, STORE_TYPE_ARMOR );
        Store_actualizarPrecioItemsArrivoCliente( cliente );
        IPS_Subject_onOpenStore( GetLastOpenedBy() );
    }

    int expectedItemsQuality = GetLocalInt(OBJECT_SELF, Store_itemsExpectedQuality_PN );
    int actualTime = Time_secondsSince1300();
    int lacking = Store_DESIRED_ITEMS_QUANTITY - Store_getNumberOfNotExpiredItemsAndDestroyTheOthers( actualTime );
    Store_generateItems( actualTime, expectedItemsQuality, lacking );
}
