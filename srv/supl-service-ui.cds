using {SupplierSBSExtSrv as my} from './supl-service';

annotate my.PurchaseOrder with @(UI : {
    SelectionFields         : [
        PurchaseOrder,
        Supplier
    ],
    LineItem                : [
        {
            Value : PurchaseOrder,
        },
        {
            Value : Supplier,
        },
        {
            Value : SupplierPhoneNumber,
        }
    ],
    FieldGroup #GeneralInfo : {
        $Type : 'UI.FieldGroupType',
        Label : 'General Information',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : PurchaseOrder,
            },
            {
                $Type : 'UI.DataField',
                Value : Supplier,
            },
            {
                $Type : 'UI.DataField',
                Value : SupplierPhoneNumber,
            },
        ],
    },
    Facets                  : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GeneralInfo',
            Label  : 'General Information'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : 'item/@UI.LineItem',
            Label  : 'Items',
        },
    ],
});

annotate my.PurchaseOrder with {
    PurchaseOrder @title : 'Purchase Order';
    Supplier @title : 'Supplier';
    SupplierPhoneNumber @title : 'Supplier Ph.no';
};


annotate my.OrderItem with @(UI : {LineItem : [
    {Value : PurchaseOrderItem, },
    {Value : PurchaseOrderItemText, }
], });

annotate my.OrderItem with {
    PurchaseOrderItem @title : 'Item No.';
    PurchaseOrderItemText @title : 'Description';
};
