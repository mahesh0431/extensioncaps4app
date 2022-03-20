namespace my.sbsextapp;

using { OP_API_PURCHASEORDER_PROCESS_SRV_0001 as PO } from '../srv/external/OP_API_PURCHASEORDER_PROCESS_SRV_0001.csn';

entity PurchaseOrder as projection on PO.A_PurchaseOrder{
    key PurchaseOrder,
    Supplier,
    SupplierPhoneNumber,
    to_PurchaseOrderItem as item: redirected to OrderItem
}

entity OrderItem as projection on PO.A_PurchaseOrderItem{
    key PurchaseOrder,
    key PurchaseOrderItem,
    PurchaseOrderItemText
}