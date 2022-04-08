using my.sbsextapp as my from '../db/data-model';

service SupplierSBSExtSrv {
    @odata.draft.enabled
    entity Escalations as projection on my.Escalations;
    entity Comments as projection on my.Comments;
    entity PurchaseOrder as projection on my.PurchaseOrder;
}