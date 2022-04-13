using {SupplierSBSExtSrv as my} from './supl-service';

annotate my.Escalations with @(
    Common.SideEffects #PurchaseOrderUpdated : {
        SourceProperties : [PurchaseOrder_PurchaseOrder],
        TargetEntities   : [PurchaseOrder]
    },
    UI                                       : {
        FieldGroup #GenInfo : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    $Type : 'UI.DataField',
                    Value : Description,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PurchaseOrder_PurchaseOrder,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PurchaseOrder.Supplier,
                    Label : 'Supplier',
                },
                {
                    $Type : 'UI.DataField',
                    Value : Material,
                    Label : 'Material No.',
                },
                {
                    $Type : 'UI.DataField',
                    Value : ExpectedDate,
                    Label : 'Expected Date',
                },
                {
                    $Type : 'UI.DataField',
                    Value : Status_code,
                },
            ],
        },
        SelectionFields     : [
            Status_code,
            PurchaseOrder_PurchaseOrder
        ],
        LineItem            : [
            {
                $Type         : 'UI.DataFieldForAction',
                Action        : 'SupplierSBSExtSrv.resolve',
                Label         : 'Resolve',
                ![@UI.Hidden] : isInProcess
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Value : PurchaseOrder_PurchaseOrder,
            },
            {
                $Type : 'UI.DataField',
                Value : PurchaseOrder.Supplier,
                Label : 'Supplier',
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : Status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : Material,
                Label : 'Material No.',
            },
            {
                $Type : 'UI.DataField',
                Value : ExpectedDate,
                Label : 'Expected Date',
            }
        ],
        Facets              : [
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
    }
);

annotate my.Comments with @(UI : {
    Identification : [
        {
            $Type : 'UI.DataField',
            Value : comment,
            Label : 'Comment',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
    ],
    LineItem       : [
        {Value : comment, },
        {Value : createdAt, }
    ],
    Facets         : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.Identification',
        Label  : ''
    }]
});

annotate my.PurchaseOrder with @(UI : {
    SelectionFields : [
        PurchaseOrder,
        PurchaseOrderType,
        Supplier
    ],
    LineItem        : [
        {Value : PurchaseOrder, },
        {Value : PurchaseOrderType, },
        {Value : Supplier, },
        {Value : SupplierPhoneNumber, }
    ],
});

annotate my.PurchaseOrder with {
    PurchaseOrder       @(Common.Label : 'Purchase Order No.')  @readonly;
    Supplier            @(Common.Label : 'Supplier')  @readonly;
    SupplierPhoneNumber @(Common.Label : 'Supplier Ph.no')  @readonly;
};

annotate my.Escalations with {
    Description
                  @mandatory;
    PurchaseOrder @(Common.Label : 'Purchase Order No.')
                  @mandatory
                  @(Common : {ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'PurchaseOrder',
        Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                ValueListProperty : 'PurchaseOrder',
                LocalDataProperty : 'PurchaseOrder_PurchaseOrder'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'PurchaseOrderType'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Supplier'
            }
        ],
    }, });
    ExpectedDate
                  @mandatory;
    Status
                  @Common.ValueListWithFixedValues : true
                  @Common.Text                     : Status.name
                  @Common.TextArrangement          : #TextFirst;
}
