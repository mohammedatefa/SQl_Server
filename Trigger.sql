use BikeStores
create table product_audiot(
	[product_id] int primary key,
	[product_name] varchar(255) not null,
	[brand_id] int not null,
	[category_id] int not null,
	[model_year] smallint not null,
	[list_price] decimal(10,2)not null,
	operation varchar(5) check(operation='ins' or operation='del'),
	time_of_peration datetime
)

create trigger keep_change
on [production].[products]
after insert,delete
as
begin
	insert into [dbo].[product_audiot]([product_id],[product_name],[brand_id],[category_id],[model_year],[list_price],[operation],[time_of_peration])
	select i.product_id,i.product_name,i.brand_id,i.category_id,i.model_year,i.list_price,'INS',GETDATE() from inserted as i 
end
INSERT INTO production.products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);

create trigger price_check
on [production].[products]
instead of insert 
as
begin
	declare @price decimal
	select @price=i.list_price 
	from inserted i
	if @price<500
	begin
		print'you inserted price less than 500'
	end
end
insert into [production].[products]([product_name],[brand_id],[category_id],[model_year],[list_price])
values('tablet',5,6,2023,300)
