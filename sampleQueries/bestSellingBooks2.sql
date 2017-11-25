SELECT ISBN, bookName, author 
FROM
	(
		(SELECT ISBN, sum(quantity) AS copiesSold, sum(quantity) * price AS totalIncome
		FROM suppliedBy
		WHERE
			(description = "purchase")
			AND
			(totalIncome >= all
				(SELECT sum(quantity) * price AS totalIncome2
				FROM suppliedBy
				GROUP BY ISBN
				)
			)
		GROUP BY ISBN
		) nj1
		NATURAL JOIN
		(SELECT ISBN, bookName, author
		FROM book
		) nj2
	)
