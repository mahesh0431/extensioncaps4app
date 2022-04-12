using my.sbsextapp as my from '../db/data-model';

service SupplierSBSExtSrv {
    @odata.draft.enabled
    entity Escalations as projection on my.Escalations actions{
        @sap.applicable.path: 'isNew' action complete();
    };
    entity Comments as projection on my.Comments;
    @readonly entity PurchaseOrder as projection on my.PurchaseOrder;
}