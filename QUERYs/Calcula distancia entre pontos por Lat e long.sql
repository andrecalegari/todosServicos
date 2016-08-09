SELECT *, (6371 *
        acos(
            cos(radians(-19.83996)) *
            cos(radians(lat)) *
            cos(radians(-43.94910) - radians(lng)) +
            sin(radians(-19.83996)) *
            sin(radians(lat))
        )) AS distance
FROM tabela HAVING distance <= 5