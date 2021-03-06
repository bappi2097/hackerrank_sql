SELECT C.COMPANY_CODE, FOUNDER, COUNT(L.LEAD_MANAGER_CODE), COUNT(S.SENIOR_MANAGER_CODE), COUNT(M.MANAGER_CODE), COUNT(E.EMPLOYEE_CODE)
FROM COMPANY AS C INNER JOIN LEAD_MANAGER AS L ON C.COMPANY_CODE=L.COMPANY_CODE INNER JOIN SENIOR_MANAGER AS S ON C.COMPANY_CODE=S.COMPANY_CODE AND L.LEAD_MANAGER_CODE=S.LEAD_MANAGER_CODE INNER JOIN MANAGER AS M ON C.COMPANY_CODE=M.COMPANY_CODE AND L.LEAD_MANAGER_CODE=M.LEAD_MANAGER_CODE AND S.SENIOR_MANAGER_CODE=M.SENIOR_MANAGER_CODE INNER JOIN EMPLOYEE AS E ON C.COMPANY_CODE=E.COMPANY_CODE AND L.LEAD_MANAGER_CODE=E.LEAD_MANAGER_CODE AND S.SENIOR_MANAGER_CODE=E.SENIOR_MANAGER_CODE AND M.MANAGER_CODE=E.MANAGER_CODE
GROUP BY C.COMPANY_CODE;

SELECT C.COMPANY_CODE, FOUNDER, LMC, SMC, MC, EC, LEN
FROM (SELECT E.COMPANY_CODE , CONVERT(INT, SUBSTR(E.COMPANY_CODE,2,LENGTH(E.COMPANY_CODE))) AS LEN, COUNT(L.LEAD_MANAGER_CODE) AS LMC, COUNT(S.SENIOR_MANAGER_CODE) AS SMC, COUNT(M.MANAGER_CODE) AS MC, COUNT(E.EMPLOYEE_CODE) AS EC
    FROM LEAD_MANAGER AS L INNER JOIN SENIOR_MANAGER AS S ON L.COMPANY_CODE=S.COMPANY_CODE AND L.LEAD_MANAGER_CODE=S.LEAD_MANAGER_CODE INNER JOIN MANAGER AS M ON S.COMPANY_CODE=M.COMPANY_CODE AND L.LEAD_MANAGER_CODE=M.LEAD_MANAGER_CODE AND S.SENIOR_MANAGER_CODE=M.SENIOR_MANAGER_CODE INNER JOIN EMPLOYEE AS E ON M.COMPANY_CODE=E.COMPANY_CODE AND L.LEAD_MANAGER_CODE=E.LEAD_MANAGER_CODE AND S.SENIOR_MANAGER_CODE=E.SENIOR_MANAGER_CODE AND M.MANAGER_CODE=E.MANAGER_CODE
    GROUP BY E.COMPANY_CODE) AS T INNER JOIN COMPANY AS C ON T.COMPANY_CODE=C.COMPANY_CODE
ORDER BY T.LEN ASC;