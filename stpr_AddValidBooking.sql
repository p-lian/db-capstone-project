CREATE DEFINER=`little_lemon`@`localhost` PROCEDURE `AddValidBooking`(IN BookDate DATE, IN BookTime TIME, IN TableId INT, IN CustomerId INT)
BEGIN
    DECLARE bookingCount INT;
    START TRANSACTION;

    -- check count
    SELECT COUNT(*) INTO bookingCount FROM Booking WHERE `Date` = BookDate AND TableId = TableId;
    
    IF bookingCount > 0 THEN
		ROLLBACK;
        SELECT CONCAT('Table ', TableId, ' is already booked on ', BookDate, ' booking could not be completed') AS 'Status';
    ELSE
		INSERT INTO booking (CustomerId, `Date`, `TimeSlot`, TableNumber)
        VALUES (CustomerId, BookDate, BookTime, TableId);
        COMMIT;
		SELECT CONCAT('booking has been completed for ', BookDate, ' at table ', TableId) AS 'Status';
    END IF;
    
END