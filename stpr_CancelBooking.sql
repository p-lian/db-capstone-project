CREATE DEFINER=`little_lemon`@`localhost` PROCEDURE `CancelBooking`(IN del_BookingId INT)
BEGIN
	-- I don't like to remove cancelled row

    -- cancel booking
    DELETE FROM booking
    WHERE `BookingId` = del_BookingId;
    
	SELECT CONCAT('Booking: ', del_BookingId, ' has been cancelled') AS 'Confirmation';
    
END