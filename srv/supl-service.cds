using my.sbsextapp as my from '../db/data-model';

service SupplierSBSExtSrv {
    @odata.draft.enabled
    entity Escalations as projection on my.Escalations actions{
        @(
            cds.odata.bindingparameter.name : '_it',
            Common.SideEffects              : {
                TargetProperties : ['_it/Status_code']
            }
        ) 
        action resolve();
    };
    entity Comments as projection on my.Comments;
    @readonly entity PurchaseOrder as projection on my.PurchaseOrder;
}