using my.sbsextapp as my from '../db/data-model';

service SupplierSBSExtSrv {
    @readonly entity PurchaseOrder as projection on my.PurchaseOrder;
    @readonly entity OrderItem as projection on my.OrderItem;
}