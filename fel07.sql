/*1. Készítsünk nézetet VSZOBA néven, amely megjeleníti a szobák adatai mellett a megfelelő szálláshely nevét, helyét és a csillagok számát is!

Az oszlopoknak nem szükséges külön nevet adni!
Teszteljük is a nézetet, pl: SELECT * FROM UJAENB_VSZOBA*/
create or alter view VSZOBA
aS
SELECT sz.*,
sza.SZALLAS_NEV, sza.HELY, sza.CSILLAGOK_SZAMA
from szoba sz join Szallashely sza on sz.SZALLAS_FK=sza.SZALLAS_ID

SELECT * FROM VSZOBA

/*2 Készítsen tárolt eljárást SPUgyfelFoglalasok, amely a paraméterként megkapott ügyfél azonosítóhoz tartozó foglalások adatait listázza!
Teszteljük a tárolt eljárás működését, pl: EXEC UJAENB_SPUgyfelFoglalasok 'laszlo2'
*/
create OR alter PROC SPUgyfelFoglalasok
@ugyfel nvarchar(100)
AS
BEGIN
  SELECT *
  FROM Foglalas
  where ugyfel_fk = @ugyfel
END

EXEC SPUgyfelFoglalasok 'laszlo2'

/*
3. Készítsen skalár értékű függvényt UDFFerohely néven, amely visszaadja, hogy a paraméterként megkapott foglalás azonosítóhoz hány férőhelyes szoba tartozik!
a. Teszteljük a függvény működését!
*/
create or alter FUNCTION UDFFerohely
(
@fazon int  
)
returns INT
as
BEGIN
DECLARE @ferohely int
SELECT @ferohely = sz.FEROHELY
FROM Foglalas f join Szoba sz on f.SZOBA_FK=sz.SZOBA_ID
where f.FOGLALAS_PK = @fazon
return @ferohely
end

select UDFFerohely(5)
