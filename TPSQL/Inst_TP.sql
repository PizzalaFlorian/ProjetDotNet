
--Renvoie les produits de la catégorie Seafood
 Declare @cat as varchar(256) = 'Seafood';
 select * from dbo.Products P inner join dbo.Categories C on P.CategoryID = C.CategoryID and C.CategoryName = @cat;

--renvoie les catégories sans produits
Select * from dbo.Categories C where not Exists(Select 1 from dbo.Products P where P.CategoryID = C.CategoryID );

--Donner la liste des produits achetés par un client ainsi que la quantité achetée de chaque produit.
--Chaque produit est affiché une seule fois.
select P.ProductName, sum(OD.Quantity) as [Quantité Total] from dbo.Products P inner join dbo.[Order Details] OD on P.ProductID = OD.ProductID
									  inner join dbo.Orders O on OD.OrderID = O.OrderID
									  inner join dbo.Customers C on C.CustomerID = O.CustomerID
									  Where O.CustomerID = 'ANTON'
									  Group by P.ProductName
									  order by P.ProductName asc


	-- Donner le top 10 des produits les plus vendues
 select top 10 P.ProductName , sum(OD.Quantity) as total  from dbo.Products P inner join dbo.[Order Details] OD on P.ProductID = OD.ProductID group by P.ProductName order by sum(OD.Quantity) desc

-- Quels sont les produits non vendus
Select P.ProductName from dbo.Products P where not Exists(Select 1 from dbo.[Order Details] OD where OD.ProductID = P.ProductID );

--La liste des commandes d’un client (id+date de commande + date d’expédition)
Select C.CustomerID, P.ProductName, O.OrderDate from dbo.[Order Details] OD 
									 inner join dbo.Orders O on OD.OrderID = O.OrderID
									 inner join dbo.Customers C on C.CustomerID = O.CustomerID
									 inner join dbo.Products P on P.ProductID = OD.ProductID
									 group by C.CustomerID, P.ProductName, O.OrderDate
									  

-- Donner la liste des commandes triée par ordre décroissant du total de la commande.
select sum(OD.Quantity) from dbo.Orders O inner join dbo.[Order Details] OD on O.OrderID = OD.OrderID
 
--Donner la liste des clients qui ont passé au moins 10 commandes. La liste est triée par ordre
--décroissant du nombre de commandes.