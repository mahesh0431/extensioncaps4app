using my.sbsextapp as my from '../db/data-model';

service SupplierSBSExtSrv {
    entity SupplierInfo as projection on my.SupplierInfo 
    entity PurchaseOrder as projection on my.PurchaseOrder;
    entity OrderItem as projection on my.OrderItem;
}