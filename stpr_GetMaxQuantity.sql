CREATE DEFINER=`little_lemon`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
	SELECT MAX(Quantity) AS MaxQuantityInOrder FROM
	`Order`;
END