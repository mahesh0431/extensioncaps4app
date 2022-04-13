const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const po = await cds.connect.to('OP_API_PURCHASEORDER_PROCESS_SRV_0001');
    const { Escalations } = this.entities;

    this.on('READ', 'Escalations', async (req, next) => {
        if (req.query.SELECT.columns) {
            const expandIndex = req.query.SELECT.columns.findIndex(
                ({ expand, ref }) => expand && ref[0] === "PurchaseOrder"
            );
            if (expandIndex < 0) return next();

            // Remove expand from query
            req.query.SELECT.columns.splice(expandIndex, 1);

            // Make sure PurchaseOrder_PurchaseOrder will be returned
            if (!req.query.SELECT.columns.find(column => column === "*")) {
                if (!req.query.SELECT.columns.find(
                    column => column.ref.find((ref) => ref == "PurchaseOrder_PurchaseOrder"))
                ) {
                    req.query.SELECT.columns.push({ ref: ["PurchaseOrder_PurchaseOrder"] });
                }
            }
        }
        const escalations = await next();

        const asArray = x => Array.isArray(x) ? x : [x];

        // Request all associated Purchase Orders (only one here)
        const purchaseOrders = asArray(escalations).map(esc => esc.PurchaseOrder_PurchaseOrder);
        const PODetails = await po.run(SELECT.from('SupplierSBSExtSrv.PurchaseOrder').where({ PurchaseOrder: purchaseOrders }));

        // Convert in a map for easier lookup
        const poMap = {};
        for (const po of PODetails)
            poMap[po.PurchaseOrder] = po;

        // Add PurchaseOrders to result
        for (const esc of asArray(escalations)) {
            esc.PurchaseOrder = poMap[esc.PurchaseOrder_PurchaseOrder];
        }

    });

    this.after('READ', 'Escalations', each => {
        if (each.Status_code === 'INP') { 
            each.isInProcess = true 
        } else { 
            each.isInProcess = false 
        }
    });

    this.on('READ', 'PurchaseOrder', async (req) => {
        return po.run(req.query);
    });

    this.before('NEW', 'Escalations', (req) => {
        req.data.Status_code = 'INP';
    });

    this.on('resolve', async (req) => {
        await cds.tx(req).run(UPDATE(Escalations).set({ 'Status_code': 'CMP' }).where({ ID: req.params[0].ID }))
    })
});