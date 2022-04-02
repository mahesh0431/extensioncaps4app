using {SupplierSBSExtSrv as my} from './supl-service';

annotate my.SupplierInfo with @(UI : { 
    FieldGroup #SupplInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : someField,
            },
        ],
    },
});

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
            Target : 'supplierInfo/@UI.FieldGroup#SupplInfo',
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



// annotate my.PurchaseOrder with @odata.draft.enabled;
