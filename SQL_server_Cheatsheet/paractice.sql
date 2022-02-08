/*CREATE VIEW BillsBillDetails
AS  
SELECT Bills.*
FROM Bills LEFT OUTER JOIN BillDetails  
ON Bills.BillId = BillDetails.BillId;*/

/*CREATE VIEW BillsBillPayments
AS  
SELECT Bills.*
FROM Bills LEFT OUTER JOIN BillPayments  
ON Bills.BillPaymentId = BillPayments.BillPaymentId; */

CREATE VIEW BillsBillPayment
AS  
SELECT Bills.*
FROM Bills INNER JOIN BillPayments  
ON Bills.BillPaymentId = BillPayments.BillPaymentId; 

