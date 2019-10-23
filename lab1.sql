-- Task 1.2 variant 3

-- Task 1.2.1
SELECT DepartmentID, Name 
FROM HumanResources.Department
WHERE Name LIKE 'P%';

-- Task 1.2.2
SELECT BusinessEntityID, JobTitle, Gender, VacationHours, SickLeaveHours
FROM HumanResources.Employee
WHERE VacationHours BETWEEN 10 AND 13;

-- Task 1.2.3
SELECT BusinessEntityID, JobTitle, Gender, BirthDate, HireDate
FROM HumanResources.Employee 
WHERE HireDate LIKE '%-07-01'
ORDER BY BusinessEntityID ASC
OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY;
