-- Clothes Codd & Co. Sells --
CREATE TABLE ClothesCoddandCoSells (
item	        text,
itemdescription	text,
retailpriceUSD	numeric (10,2),
qtyonhand	integer,
primary key    (item)
);

-- Purchase order data --
CREATE TABLE PurchaseOrderData (
supplier	        varchar,
itembeingpurchased	varchar,
qty	                integer,
purchasepriceUSD	numeric (10,2),
purchaseordernumber	numeric,
purchaseorderdate	datetime,
purchaseordercomments	varchar,
primary key (supplier, itembeingpurchased)
);

-- Supplier data -
CREATE TABLE SupplierData (
name	                varchar,
streetaddress	        varchar,
city	                varchar,
state	                char(2),
postalcode	        char(5),
contactinfoname	        varchar,
contactinfonumber	char(10),
paymentterms	        varchar,
primary key (name)
);


-- Clothes Codd & Co. Sells --
INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('ShortSleeve01', 'RedShortSleeveShirt', 15.00, 22);

INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('LongSleeve01', 'OrangeLongSleeveShirt', 20.00, 17);

INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('Shorts01', 'BlueShorts', 25.00, 17);

INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('Pants01', 'YellowPants', 35.00, 27);

INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('BaseballHat01', 'GreyBaseballHat', 20.00, 32);

INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('BaseballHat02', 'PurpleBaseballHat', 15.00, 7);

INSERT INTO ClothesCoddandCoSells(item, itemdescription, retailpriceUSD, qtyonhand)
VALUES ('Scarf01', 'BlackScarf', 30.00, 12);

-- Purchase order data --
INSERT INTO PurchaseOrderData(supplier, itembeingpurchased, qty, purchasepriceUSD, purchaseordernumber, purchaseorderdate, purchaseordercomments)
VALUES ('WarmColorClothingInc', 'ShortSleeveShirt', 20, 10.00, 1001, 'May-27-2014', 'SizesXS-L');

INSERT INTO PurchaseOrderData(supplier, itembeingpurchased, qty, purchasepriceUSD, purchaseordernumber, purchaseorderdate, purchaseordercomments)
VALUES ('WarmColorClothingInc', 'LongSleeveShirt', 15, 15.00, 2001, '09-15-2014', 'SizesXS-L');

INSERT INTO PurchaseOrderData(supplier, itembeingpurchased, qty, purchasepriceUSD, purchaseordernumber, purchaseorderdate, purchaseordercomments)
VALUES ('CoolColorClothingCo', 'Shorts', 15, 20.00, 3001, '06-14-2014', 'SizesS-XL');

INSERT INTO PurchaseOrderData(supplier, itembeingpurchased, qty, purchasepriceUSD, purchaseordernumber, purchaseorderdate, purchaseordercomments)
VALUES ('WarmColorClothingInc', 'Pants', 25, 25.00, 2001, '09-15-2014', 'SizesS-XL');

INSERT INTO PurchaseOrderData(supplier, itembeingpurchased, qty, purchasepriceUSD, purchaseordernumber, purchaseorderdate, purchaseordercomments)
VALUES ('DullColorClothingSupplier', 'BaseballHat', 30, 15.00, 4001, '03-03-2014', 'OneSize');


-- Supplier data --
INSERT INTO SupplierData (name, streetaddress, city, state, postalcode, contactinfoname, contactinfonumber, paymentterms)
VALUES ( 'WarmColorClothingInc', '123SunnyStreet', 'Miami', 'FL', '33125', 'SallySunshine', '1231231231', 'PayBeforeShipping');

INSERT INTO SupplierData (name, streetaddress, city, state, postalcode, contactinfoname, contactinfonumber, paymentterms)
VALUES ('CoolColorClothingCo', '456RainyRoad', 'Seattle', 'WA', '96101', 'DannyDamp', '4564564564', 'PayAfterReceive');

INSERT INTO SupplierData (name, streetaddress, city, state, postalcode, contactinfoname, contactinfonumber, paymentterms)
VALUES ('DullColorClothingSupplier', '789GrayLane', 'NewYork', 'NY', '10001', 'ChrisCloudy', '7897897897', 'PayBeforeShipping');