-- Task 2.1, variant 3

-- Task 2.1.1 
SELECT ed.BusinessEntityID, e.JobTitle, ed.DepartmentID, d.Name 
FROM HumanResources.EmployeeDepartmentHistory ed 
INNER JOIN HumanResources.Department d
ON d.DepartmentID = ed.DepartmentID
INNER JOIN HumanResources.Employee e
ON e.BusinessEntityID = ed.BusinessEntityID
WHERE ed.EndDate IS NULL;


-- Task 2.1.2 
SELECT d.DepartmentID, d.Name, COUNT(*) AS EmpCount
FROM HumanResources.Department d
INNER JOIN HumanResources.EmployeeDepartmentHistory ed
ON d.DepartmentID = ed.DepartmentID
WHERE ed.EndDate IS NULL
GROUP BY d.DepartmentID, d.Name;


-- Task 2.1.3 
SELECT e.JobTitle, ep.Rate, ep.RateChangeDate,
CONCAT('The rate for ',e.JobTitle,' was set to ',ep.Rate,' at ',
CONVERT(nvarchar,ep.RateChangeDate,106)) as Report
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeePayHistory ep
ON e.BusinessEntityID = ep.BusinessEntityID;

