namespace my.sbsextapp;

using {managed, cuid} from '@sap/cds/common';
using {OP_API_PURCHASEORDER_PROCESS_SRV_0001 as PO} from '../srv/external/OP_API_PURCHASEORDER_PROCESS_SRV_0001.csn';


entity Escalations: managed, cuid {
    Description     : String @(Common.Label : 'Escalation Description');
    Status: String @(Common.Label : 'Status');
    PurchaseOrder : Association to PurchaseOrder;
    Comments: Association to many Comments on Comments.escalation = $self;
};

entity Comments: managed, cuid{
    comment: String;
    escalation: Association to Escalations;
}

@Capabilities: {
    InsertRestrictions.Insertable: false,
    UpdateRestrictions.Updatable: false,
    DeleteRestrictions.Deletable: false
}

// @cds.persistence.skip
view PurchaseOrder as
    select from PO.A_PurchaseOrder
    {
        key PurchaseOrder,
            PurchaseOrderType,
            Supplier,
            SupplierPhoneNumber
    };