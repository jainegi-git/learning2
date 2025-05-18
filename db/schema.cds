namespace com;

// Define Types--> 

type Genre : Integer enum {
        fiction = 0;
        non_fiction = 1;
};

type noOfBooks : Integer;

type Price {
    amount : Decimal;
    currency : String(3);
}


// Define Entities--> 

define entity Authors {
    key ID          : UUID;
        name        : String(100);
        books       : Association to many Books on books.author = $self;
        dateOfBirth : Date;
        dateOfDeath : Date;
};

entity Books  {
    key ID          : UUID; 
    title           : String(100);
    author          : Association to Authors;
    genre           : Genre;
    publCountry     : String(3);
    stock           : noOfBooks;
    price           : Price;
    isHardCover     : Boolean;
};




