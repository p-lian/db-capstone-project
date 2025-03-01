CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `little_lemon`@`localhost` 
    SQL SECURITY DEFINER
VIEW `order_view` AS
    SELECT 
        `o`.`OrderId` AS `OrderId`,
        `o`.`Quantity` AS `Quantity`,
        (`o`.`Quantity` * `m`.`Price`) AS `TotalCost`
    FROM
        (`order` `o`
        JOIN `menu` `m` ON ((`o`.`MenuId` = `m`.`MenuId`)))
    WHERE
        (`o`.`Quantity` > 2)