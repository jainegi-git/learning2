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


entity Books: cuid, managed  {
    title           : localized String(255);
    author          : Association to Authors;
    genre           : Genre;
    publCountry     : Country;
    stock           : noOfBooks;
    price           : Price;
    isHardCover     : Boolean;
};

entity Authors : cuid, managed{
        name        : String(100);
        dateOfBirth : Date;
        dateOfDeath : Date;
        epoch       : Association to Epoches;
        books       : Association to many Books 
                        on books.author = $self;

};

entity Epoches : CodeList {
    key ID          : Integer;
}


