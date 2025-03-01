CREATE DEFINER=`little_lemon`@`localhost` PROCEDURE `AddBooking`(IN CustomerId INT, IN BookDate DATE, IN BookTime TIME, IN TableId INT)
BEGIN
    DECLARE bookingCount INT;
    
    -- I did not add the booking id parameter, because it is an auto increment field. 
    -- it is not required, and cause problems if the users creates there own
    
    -- add booking
    INSERT INTO booking (CustomerId, `Date`, `TimeSlot`, TableNumber)
	VALUES (CustomerId, BookDate, BookTime, TableId);	
    
	SELECT 'New booking added' AS 'Confirmation';
    
END