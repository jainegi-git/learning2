namespace com;

using { 
    cuid, 
    managed,
    Country,
    Currency,
    sap.common.CodeList
     } from '@sap/cds/common';


// Define Types--> 

type Genre : Integer enum {
        fiction = 0;
        non_fiction = 1;
};

type noOfBooks : Integer;

type Price {
    amount : Decimal;
    currency : Currency;
}


// Define Entities--> 
entity Epoches : CodeList {
    key ID          : Integer;
};

entity Books: cuid, managed  {
    title           : localized String(255) @mandatory;
    author          : Association to Authors @mandatory @assert.target;
    genre           : Genre @assert.range: true;
    publCountry     : Country;
    stock           : noOfBooks default 0;
    price           : Price;
    isHardCover     : Boolean;
};

entity Authors : cuid, managed{ @mandatory
        name        : String(100);
        dateOfBirth : Date;
        dateOfDeath : Date;
        epoch       : Association to Epoches @assert.target;
        books       : Association to many Books 
                        on books.author = $self;

};

annotate Books with {
    modifiedAt @odata.etag
};

annotate Authors with{
    modifiedAt @odata.etag
} ;
