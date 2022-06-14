const cds = require('@sap/cds');
const { expect, GET, POST } = cds.test.in(__dirname, "..").run(
    "serve",
    "--with-mocks",
    "--in-memory"
);


describe('Testing OData APIs', () => {
    it('test status codes', async () => {
        const { data } = await GET`/supplier-sbsext-srv/StatusList?$select=code`
        expect(data.value).to.eql([{ "code": "CMP" },
        { "code": "INP" }]);
    })
    it('test action resolve', async () => {
        // Create a new Escalation
        
        // Step: 1 Create the draft data
        const { data:draft } = await POST `/supplier-sbsext-srv/Escalations ${{"Description":"test","PurchaseOrder_PurchaseOrder":"9000000001","ExpectedDate":"2022-05-27"}}`
        
        // Step: 2 Save the draft to create a new escalation
        const { data:post } = await POST (`/supplier-sbsext-srv/Escalations(ID=${draft.ID},IsActiveEntity=false)/SupplierSBSExtSrv.draftActivate`)
        
        // Read the escalation before executing the resolve action
        let { data:readBeforeAction } = await GET`/supplier-sbsext-srv/Escalations(ID=${post.ID},IsActiveEntity=true)`
        
        // Check if the initial status is 'INP - In process
        expect(readBeforeAction.Status_code).to.eql('INP');

        // Perform Resolve Action
        await POST `/supplier-sbsext-srv/Escalations(ID=${draft.ID},IsActiveEntity=false)/SupplierSBSExtSrv.resolve`
        
        // Read the escalation after executing the resolve action
        let { data:readAfterAction } = await GET`/supplier-sbsext-srv/Escalations(ID=${post.ID},IsActiveEntity=true)`
        
        // Check if the escalation is updated to the status 'CMP' - Completed
        expect(readAfterAction.Status_code).to.eql('CMP');
    })
})

