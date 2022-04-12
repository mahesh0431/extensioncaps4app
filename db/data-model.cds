namespace my.sbsextapp;

using {managed, cuid, sap.common.CodeList} from '@sap/cds/common';

using {OP_API_PURCHASEORDER_PROCESS_SRV_0001 as PO} from '../srv/external/OP_API_PURCHASEORDER_PROCESS_SRV_0001.csn';

@cds.autoexpose
entity StatusList: CodeList{
    key code: String(3);
}
type StatusType : Association to one StatusList;

entity Escalations: managed, cuid {
    Description     : String @(Common.Label : 'Escalation Description');
    Status: StatusType @(Common.Label : 'Status') @readonly ;
    PurchaseOrder : Association to PurchaseOrder;
    Material: String(30);
    ExpectedDate: Date;
    Comments: Association to many Comments on Comments.escalation = $self;
};

entity Comments: managed, cuid{
    comment: String;
    escalation: Association to Escalations;
}

// @cds.persistence.skip
view PurchaseOrder as
    select from PO.A_PurchaseOrder
    {
        key PurchaseOrder,
            PurchaseOrderType,
            Supplier @readonly,
            SupplierPhoneNumber
    };