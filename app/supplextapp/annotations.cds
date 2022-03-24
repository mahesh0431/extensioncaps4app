using SupplierSBSExtSrv as service from '../../srv/supl-service';

annotate service.PurchaseOrder with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'PurchaseOrder',
            Value : PurchaseOrder,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Supplier',
            Value : Supplier,
        },
        {
            $Type : 'UI.DataField',
            Label : 'SupplierPhoneNumber',
            Value : SupplierPhoneNumber,
        },
    ]
);
annotate service.PurchaseOrder with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'PurchaseOrder',
                Value : PurchaseOrder,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Supplier',
                Value : Supplier,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SupplierPhoneNumber',
                Value : SupplierPhoneNumber,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
