using {SupplierSBSExtSrv as my} from './supl-service';

annotate my.Escalations with @(UI : { 
    FieldGroup #GenInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Value : PurchaseOrder_PurchaseOrder,
                Label : 'Purchase Order No',
            },
            {
                $Type : 'UI.DataField',
                Value : Status,
            },
        ],
    },
    LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : Status,
        },
    ],
    Facets                  : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GenInfo',
            Label  : 'General Information'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : 'Comments/@UI.LineItem',
            Label  : 'Comments'
        },
    ],
});

annotate my.Comments with @(UI : { 
    Identification  : [
        {
            $Type : 'UI.DataField',
            Value : comment,
        },{
            $Type : 'UI.DataField',
            Value : createdAt,
        },
    ],
    LineItem                : [
        {
            Value : comment,
        },
        {
            Value : createdAt,
        }
    ],
});

annotate my.PurchaseOrder with @(UI : {
    SelectionFields         : [
        PurchaseOrder,
        PurchaseOrderType,
        Supplier
    ],
    LineItem                : [
        {
            Value : PurchaseOrder,
        },
        {
            Value : PurchaseOrderType,
        },
        {
            Value : Supplier,
        },
        {
            Value : SupplierPhoneNumber,
        }
    ],
});

annotate my.PurchaseOrder with {
    PurchaseOrder @(Common.Label : 'Purchase Order');
    Supplier @(Common.Label : 'Supplier');
    SupplierPhoneNumber @(Common.Label : 'Supplier Ph.no');
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
