const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() { 
    const po = await cds.connect.to('OP_API_PURCHASEORDER_PROCESS_SRV_0001');

    this.on('READ','PurchaseOrder', async (req, next) => {
        return po.run(req.query);
    });
});