CREATE DEFINER=`little_lemon`@`localhost` PROCEDURE `UpdateBooking`(IN upd_BookingId INT, IN BookDate DATE, IN BookTime TIME, IN TableId INT)
BEGIN
    -- I added some fields
    
    -- add booking record
    UPDATE booking
    SET `Date` = BookDate, TimeSlot = BookTime, TableNumber = TableId
    WHERE `BookingId` = upd_BookingId;
    
	SELECT CONCAT('Booking: ', upd_BookingId, ' has been updated') AS 'Confirmation';
    
END