CREATE DEFINER=`little_lemon`@`localhost` PROCEDURE `CancelOrder`(IN OrderId INT)
BEGIN

  -- check if order exists
  IF (SELECT COUNT(*) FROM `order` WHERE OrderId = @OrderId) > 0 THEN
	-- delete order
    DELETE FROM `order` WHERE OrderID = OrderId;

	SELECT CONCAT('Order ', OrderId, ' has been cancelled') AS 'Confirmation';
  ELSE
    SELECT CONCAT('Order ', OrderId, ' does not exist') AS 'Confirmation';
  END IF;
    
END