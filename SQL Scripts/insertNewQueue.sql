DELIMITER //
CREATE PROCEDURE insertNewQueue(typeEvent VARCHAR(255), queue VARCHAR(255))
BEGIN
    DECLARE clients_count INT DEFAULT 0;
    DECLARE idx INT DEFAULT 0;
    SELECT COUNT(*) FROM oauth_clients INTO clients_count;
    SET idx = 0;

    WHILE idx <= clients_count
        DO
            INSERT INTO oauth_clients_queue(type_event, client_id, queue, version, created_at, updated_at, deleted_at,
                                            is_encrypted)
            SELECT typeEvent,
                   client_id,
                   queue,
                   1,
                   NOW(),
                   NOW(),
                   null,
                   true
            FROM oauth_clients
            LIMIT idx, 1;

            SET idx = idx + 1;
        END WHILE;
END //
DELIMITER ;