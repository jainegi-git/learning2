const cds = require('@sap/cds');
const { select } = require('@sap/cds/libx/_runtime/hana/execute');

class catalogService extends cds.ApplicationService{



    init() {

        const { Books }  = this.entities;

        //Add discount for overstock books
        this.after( 'READ', Books, this.grantDiscount);

        // Reduce the stock after order placed
        this.on( 'submitOrder', this.reduceStock);


        return super.init();
    }

    grantDiscount(results) {
        for( let b of results) {
            if (b.stock > 200){
                b.title += ' -- 11% Discount!'; }
        }
    }

    async reduceStock(req){
        const { Books } = this.entities;
        const { book , quantity } = req.data;

        if(quantity < 1 ) {
            return req.error('The Quantity must be atleast 1.');            
        }
        const b = await SELECT.one.from(Books).where({ ID : book }).columns( b => { b.stock });
        if (!b) {
            return req.error('Book with ID ${ book } does not exist.' );
        }

        let { stock } = b;

        if( quantity > stock ) {
            return req.error('${ quantity } exceeds the stock ${stock} for book id ${book}.');
        }

        await UPDATE(Books).where({ID : book}).with({stock : { '-=': quantity }});
        return{ stock : stock - quantity};
    }
}

module.exports = catalogService;