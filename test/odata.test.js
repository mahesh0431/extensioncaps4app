const { expect, GET, POST } = require('@sap/cds').test.in(__dirname, "..").run(
    "serve",
    "--with-mocks",
    "--in-memory"
);

describe('Testing OData APIs', () => {
    it('test status codes', async () => {
        const { data } = await GET`/supplier-sbsext-srv/StatusList`
        expect(data.value).to.eql([{ "name": "Completed", "descr": null, "code": "CMP" },
        { "name": "In Process", "descr": null, "code": "INP" }]);
    })
    it('test action resolve', async () => {
        // Create a new Escalation
        const { data:draft } = await POST `/supplier-sbsext-srv/Escalations ${{"Description":"test","PurchaseOrder_PurchaseOrder":"9000000001","ExpectedDate":"2022-05-27"}}`
        const { data:post } = await POST (`/supplier-sbsext-srv/Escalations(ID=${draft.ID},IsActiveEntity=false)/SupplierSBSExtSrv.draftActivate`)
        let { data:readBeforeAction } = await GET`/supplier-sbsext-srv/Escalations(ID=${post.ID},IsActiveEntity=true)`
        expect(readBeforeAction.Status_code).to.eql('INP');

        // Perform Resolve Action
        await POST `/supplier-sbsext-srv/Escalations(ID=${draft.ID},IsActiveEntity=false)/SupplierSBSExtSrv.resolve`
        let { data:readAfterAction } = await GET`/supplier-sbsext-srv/Escalations(ID=${post.ID},IsActiveEntity=true)`
        expect(readAfterAction.Status_code).to.eql('CMP');
    })
})

