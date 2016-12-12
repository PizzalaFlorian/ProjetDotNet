
--Renvoie les produits de la cat�gorie Seafood
 Declare @cat as varchar(256) = 'Seafood';
 select * from dbo.Products P inner join dbo.Categories C on P.CategoryID = C.CategoryID and C.CategoryName = @cat;

--renvoie les cat�gories sans produits
Select * from dbo.Categories C where not Exists(Select 1 from dbo.Products P where P.CategoryID = C.CategoryID );

--Donner la liste des produits achet�s par un client ainsi que la quantit� achet�e de chaque produit.
--Chaque produit est affich� une seule fois.
select P.ProductName, sum(OD.Quantity) as [Quantit� Total] from dbo.Products P inner join dbo.[Order Details] OD on P.ProductID = OD.ProductID
									  inner join dbo.Orders O on OD.OrderID = O.OrderID
									  inner join dbo.Customers C on C.CustomerID = O.CustomerID
									  Where O.CustomerID = 'ANTON'
									  Group by P.ProductName
									  order by P.ProductName asc


	-- Donner le top 10 des produits les plus vendues
 select top 10 P.ProductName , sum(OD.Quantity) as total  from dbo.Products P inner join dbo.[Order Details] OD on P.ProductID = OD.ProductID group by P.ProductName order by sum(OD.Quantity) desc

-- Quels sont les produits non vendus
Select P.ProductName from dbo.Products P where not Exists(Select 1 from dbo.[Order Details] OD where OD.ProductID = P.ProductID );

--La liste des commandes d�un client (id+date de commande + date d�exp�dition)
Select C.CustomerID, P.ProductName, O.OrderDate from dbo.[Order Details] OD 
									 inner join dbo.Orders O on OD.OrderID = O.OrderID
									 inner join dbo.Customers C on C.CustomerID = O.CustomerID
									 inner join dbo.Products P on P.ProductID = OD.ProductID
									 group by C.CustomerID, P.ProductName, O.OrderDate
									  

-- Donner la liste des commandes tri�e par ordre d�croissant du total de la commande.
select sum(OD.Quantity) from dbo.Orders O inner join dbo.[Order Details] OD on O.OrderID = OD.OrderID
 
--Donner la liste des clients qui ont pass� au moins 10 commandes. La liste est tri�e par ordre
--d�croissant du nombre de commandes.