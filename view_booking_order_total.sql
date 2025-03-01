CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `little_lemon`@`localhost` 
    SQL SECURITY DEFINER
VIEW `booking_order_total` AS
    SELECT 
        `b`.`BookingId` AS `BookingId`,
        `c`.`CustomerId` AS `CustomerId`,
        `c`.`Name` AS `CustomerName`,
        SUM((`o`.`Quantity` * `m`.`Price`)) AS `OrderTotal`
    FROM
        (((`booking` `b`
        JOIN `customer` `c` ON ((`b`.`CustomerId` = `c`.`CustomerId`)))
        JOIN `order` `o` ON ((`o`.`BookingId` = `o`.`BookingId`)))
        JOIN `menu` `m` ON ((`o`.`MenuId` = `m`.`MenuId`)))
    GROUP BY `b`.`BookingId` , `c`.`CustomerId` , `c`.`Name`
    HAVING (SUM((`o`.`Quantity` * `m`.`Price`)) > 150)
    ORDER BY SUM((`o`.`Quantity` * `m`.`Price`)) DESC