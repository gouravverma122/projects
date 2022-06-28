use housing
# change data type of column saledate to date
alter table housingdata
modify column saledate date 

#Chane data type of column yearbuilt to year
alter table housingdata
modify column yearbuilt int

alter table housingdata
modify column yearbuilt year

#checking the empty value in propertyaddress
select * from housingdata where propertyaddress like ""

#replace empty value with null
update housingdata
set propertyaddress = null where propertyaddress like ""

#populate propertyaddress data
update housingdata
set propertyaddress = isnull(a.propertyaddress , b.propertyaddress) as addr
from housingdata a
join housingdata b
	on a.parcelid = b.parcelid
	and a.uniqueid <> b.uniqueid 
where a.propertyaddress is null )

# we can also drop some raws to clean the data from propertyaddress
delete from housingdata 
where propertyaddress is null

# to delete Extra space from the column 
select * from housingdata where parcelid = '034 07 0B 015.00'

update housingdata
set propertyaddress = "2524 VAL MARIE DR, MADISON" where parcelid = "034 07 0B 015.00"

#spliting the propertyaddress column into address and city    
#it can be done by 2 diffrent method

#method 01
select substring_index(propertyaddress, ",", 1) as propertysplitaddress,
	substring_index(propertyaddress, ", ", -1) as propertysplitcity
    from housingdata
    
alter table housingdata
add column propertysplitcity varchar (255)

alter table housingdata
add column propertysplitaddress varchar (255)

update housingdata
set propertysplitaddress = substring_index(propertyaddress, ",", 1)

update housingdata
set propertysplitcity = substring_index(propertyaddress,", " , -1)

#Method 02
select substring(propertyaddress, 1 , locate( ",", propertyaddress)-1) as address,
substring(propertyaddress, locate( ",", propertyaddress) +2, length(propertyaddress)) as address
 from housingdata
 
alter table housingdata
add column address varchar (255)

alter table housingdata
add column city varchar (255)

update housingdata
set city = substring(propertyaddress, locate( ",", propertyaddress) +2, length(propertyaddress));

update housingdata
set address =substring(propertyaddress, 1 , locate( ",", propertyaddress)-1);

# Split the owneraddress into address, city, State
select substring_index(owneraddress, "," , 1),
substring_index(owneraddress, ", " , -1),
substring_index(substring_index(owneraddress, "," , 2), ", ", -1) from housingdata

alter table housingdata
add ownersplitaddress varchar (255);

alter table housingdata
add ownersplitcity varchar (255);

alter table housingdata
add ownersplitstate varchar (255);

update housingdata
set ownersplitaddress = substring_index(owneraddress, ",", 1);

update housingdata
set ownersplitcity = substring_index(substring_index(owneraddress, "," , 2), ", ", -1)

update housingdata
set ownersplitstate = substring_index(owneraddress, ", " , -1);

# to make the soldasvacant column identical in term of yes and no 
select distinct soldasvacant, count(soldasvacant) from housingdata group by soldasvacant

select 
case when soldasvacant = "Y" then "Yes"
when soldasvacant = "N" then "No"
else soldasvacant
end
from housingdata

update housingdata
set soldasvacant = case when soldasvacant = "Y" then "Yes" when soldasvacant = "N" then "No" else soldasvacant end;

# Remove Duplicate rows
delete from with cte as (select *, row_number() 
over (partition by ParcelId
		, Propertyaddress , saledate , saleprice
		, legalreference 
        ) as row_num
from housingdata)
select * from cte where row_num >1


# Delete extra columns from the table
alter table housingdata
drop column propertyaddress,
drop column owneraddress,
drop column ownername,
drop column taxdistrict 


