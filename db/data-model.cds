namespace my.sbsextapp;

using {managed} from '@sap/cds/common';
using {OP_API_PURCHASEORDER_PROCESS_SRV_0001 as PO} from '../srv/external/OP_API_PURCHASEORDER_PROCESS_SRV_0001.csn';


entity SupplierInfo {
    key ID      : UUID  @(Core.Computed : true);
        someField     : String @(Core.Description : 'Some Field');
        PurchaseOrder : Association to PurchaseOrder;
};

@Capabilities: {
    InsertRestrictions.Insertable: true,
    UpdateRestrictions.Updatable: true,
    DeleteRestrictions.Deletable: true
}
view PurchaseOrder as
    select from PO.A_PurchaseOrder
    mixin {
        supplierInfo : Association to SupplierInfo
                           on $projection.PurchaseOrder = supplierInfo.PurchaseOrder.PurchaseOrder;
    }
    into {
        key PurchaseOrder,
            Supplier,
            SupplierPhoneNumber,
            supplierInfo,
            to_PurchaseOrderItem as item : redirected to OrderItem
    };
// entity PurchaseOrder as projection on PO.A_PurchaseOrder{
//     key PurchaseOrder,
//     Supplier,
//     SupplierPhoneNumber,
//     to_PurchaseOrderItem as item: redirected to OrderItem
// }

entity OrderItem as projection on PO.A_PurchaseOrderItem {
    key PurchaseOrder,
    key PurchaseOrderItem,
        PurchaseOrderItemText
};
