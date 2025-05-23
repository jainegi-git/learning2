const { validate } = require('@sap/cds');
const cds = require('@sap/cds');

class AdminService extends cds.ApplicationService{

    init() {
 
        const { Authors } =  this.entities;
        this.before
        ( 
            ['CREATE', 'UPDATE'],     // Event Name 
            Authors,                  // Entity Name
            this.validateLifeData     // Calling Function
        );
        return super.init();
    }

    
    validateLifeData(req) 
    { 
        const { dateOfBirth, dateOfDeath } = req.data;
        if (!dateOfBirth || !dateOfDeath ){
            return;
        }
        const birth = new Date(dateOfBirth);
        const death = new Date(dateOfDeath);

        if( birth < death) {
            req.console.error( 'The date of death (${dateOfDeath}) is before the date of birth(${dateOfBirth}).' );
        }    
    };

}
module.exports = AdminService;

